import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/library_page/book_detail/widget/library_ebook_widget.dart';
import 'package:katon/screens/library_page/widget/share_ebook_dialog.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import '../../../../components/app_text_style.dart';
import '../../../../utils/constants.dart';
import '../../../models/book_info_model.dart';
import '../../../utils/global_singlton.dart';
import '../../../utils/prefs/app_preference.dart';
import '../../../utils/prefs/preferences_key.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../../../widgets/no_internet.dart';
import '../controller/cnt_prv.dart';

class LibraryEbookTablet extends StatefulWidget {
  final Arguments arguments;
  const LibraryEbookTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<LibraryEbookTablet> createState() => _LibraryEbookTabletState();
}

class _LibraryEbookTabletState extends State<LibraryEbookTablet> {
  ELearningProvider? eLearningPrv;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("message-----");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      eLearningPrv = Provider.of<ELearningProvider>(context, listen: false);
      eLearningPrv?.pages = 1;
      init();
    });
    scrollController.addListener(_scrollListener);
  }

  init() async {
    await eLearningPrv?.callApiPagination();
    eLearningPrv?.getEBooks();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!eLearningPrv!.isLoadingStarted) {
        eLearningPrv?.pages++;
        log("page-----${eLearningPrv?.pages}");
        await eLearningPrv?.callApiPagination();
      }

      log(eLearningPrv!.pages.toString());
    }
  }

  // init() async {
  //   await eLearningPrv?.callApiPagination();
  // }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    // bookId = value.books?.bkId;
    return Scaffold(
      // endDrawer: endDrawer(),
      backgroundColor: AppColors.white,
      // appBar: commonAppBar(
      //     onPressed: () => Navigator.pop(context),
      //     backIcon: true,
      //     title: value.arg?.title ?? "",
      //     description:
      //     value.arg?.description ?? ""),
      // body: Stack(
      //   children: [
      //     BookAndSimilarBooksModule(books: value.books!),
      //     ConnectionWidget.connection,
      //   ],
      // ),
      body: SafeArea(
        child: Consumer<ELearningProvider>(builder: (context, ePrv, child) {
          return Container(
            padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonAppBar2(
                    isshowback: true,
                    title: args.toString(),
                    description: widget.arguments.description),
                customHeight(15),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.boxgreyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.fromLTRB(31, 42, 31, 38),
                    child: ePrv.value
                        ? Loader(message: "loading_wait".tr)
                        : ePrv.connection
                            ? (ePrv.listOfBookDetails.isEmpty ||
                                    ePrv.listOfBookDetails.length == 0)
                                ? NoDataFound(message: "no_book_found".tr)
                                : GridView.builder(
                                    controller: scrollController,
                                    physics: BouncingScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: 0.82,
                                    ),
                                    itemBuilder: (context, i) {
                                      var data = ePrv.listOfBookDetails[i];
                                      return LibraryEbookWidget(
                                        onTapShare: () async {
                                          await shareEbookDialog(context,
                                              book: data);
                                        },
                                        book: data,
                                        booksList: ePrv.listOfBookDetails,
                                      );
                                    },
                                    itemCount: ePrv.listOfBookDetails.length,
                                  )
                            : (ePrv.books.isEmpty)
                                ? NoDataFound(message: "no_book_found".tr)
                                : GridView.builder(
                                    controller: scrollController,
                                    physics: BouncingScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: 0.82,
                                    ),
                                    itemBuilder: (context, i) {
                                      // log("message---${ePrv.booksMCount}----${ePrv.books.length}");
                                      if (ePrv.booksMCount !=
                                          ePrv.books.length) {
                                        log("11");
                                        if (ePrv.books.length == i) {
                                          log("22");
                                          return ePrv.isLoadingStarted
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : SizedBox();
                                        }
                                      }
                                      var data = ePrv.books[i];
                                      return LibraryEbookWidget(
                                        onTapShare: () async {
                                          await shareEbookDialog(context,
                                              book: data);
                                        },
                                        book: data,
                                        booksList: ePrv.books,
                                      );
                                    },
                                    itemCount:
                                        ePrv.booksMCount != ePrv.books.length
                                            ? ePrv.books.length + 1
                                            : ePrv.books.length,
                                  ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
