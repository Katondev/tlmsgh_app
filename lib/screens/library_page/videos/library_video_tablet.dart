import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import '../../../../components/app_text_style.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../book_detail/widget/library_video_widget.dart';
import '../controller/cnt_prv.dart';

class LibraryVideoTablet extends StatefulWidget {
  final Arguments arguments;
  const LibraryVideoTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<LibraryVideoTablet> createState() => _LibraryVideoTabletState();
}

class _LibraryVideoTabletState extends State<LibraryVideoTablet> {
  ELearningProvider? eLearningPrv;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("calling0000----");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eLearningPrv = Provider.of<ELearningProvider>(context, listen: false);
      // eLearningPrv?.pages = 1;
      init();

      print("object---${eLearningPrv!.videobookslabel.length}");
      // getBooks();
    });
    // scrollController.addListener(_scrollListener);
  }

  init() async {
    await eLearningPrv?.callVideobookApiPagination();
    eLearningPrv?.getBooks();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // _scrollListener() async {
  //   if (scrollController.position.pixels ==
  //           scrollController.position.maxScrollExtent &&
  //       !scrollController.position.outOfRange) {
  //     if (!eLearningPrv!.isLoadingStarted) {
  //       eLearningPrv?.pages++;
  //       log("page-----${eLearningPrv?.pages}");
  //       await eLearningPrv?.callVideobookApiPagination();
  //     }

  //     log(eLearningPrv!.pages.toString());
  //   }
  // }

  // init() async {
  //   await eLearningPrv?.callVideobookApiPagination().whenComplete(() {
  //     initOffline();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    return Consumer<BookDetailProvider>(builder: (context, value, child) {
      // bookId = value.books?.bkId;
      return Scaffold(
        // endDrawer: endDrawer(),
        backgroundColor: AppColors.white,
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
                              ? (ePrv.offlinevideobooks.isEmpty ||
                                      ePrv.offlinevideobooks.length == 0)
                                  ? NoDataFound(message: "no_book_found".tr)
                                  : ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        var dd = ePrv.offlinevideobooks[i];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${dd.label}",
                                              style: AppTextStyle.normalBold14
                                                  .copyWith(
                                                fontSize: 15,
                                                color: AppColors.black,
                                              ),
                                            ),
                                            h10,
                                            Container(
                                              height: 160,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: ListView.builder(
                                                      key: ValueKey(
                                                          i.toString()),
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          dd.data?.length,
                                                      itemBuilder: (context,
                                                          horizontalIndex) {
                                                        var data = dd.data?[
                                                            horizontalIndex];
                                                        return LibraryVideoWidget(
                                                          onTapShare: () {},
                                                          book: data,
                                                          booksList: dd.data,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  if (dd.data!.length > 3) w10,
                                                  if (dd.data!.length > 3)
                                                    Icon(Icons
                                                        .arrow_forward_ios_rounded),
                                                ],
                                              ),
                                            ),
                                            h10,
                                          ],
                                        );
                                      },
                                      itemCount: ePrv.offlinevideobooks.length,
                                    )
                              : (ePrv.videobooks.isEmpty &&
                                          ePrv.videobookslabel.isEmpty &&
                                          ePrv.videobookData1.isEmpty ||
                                      ePrv.videobookData1.isEmpty)
                                  ? NoDataFound(message: "no_book_found".tr)
                                  : ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        var dd = ePrv.videobooks[i];
                                        return (dd.data!.isEmpty)
                                            ? SizedBox()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${dd.label}",
                                                    style: AppTextStyle
                                                        .normalBold14
                                                        .copyWith(
                                                      fontSize: 15,
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                  h10,
                                                  Container(
                                                    height: 160,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              ListView.builder(
                                                            key: ValueKey(
                                                                i.toString()),
                                                            physics:
                                                                BouncingScrollPhysics(),
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                dd.data?.length,
                                                            itemBuilder: (context,
                                                                horizontalIndex) {
                                                              var data = dd
                                                                      .data?[
                                                                  horizontalIndex];
                                                              return LibraryVideoWidget(
                                                                onTapShare:
                                                                    () {},
                                                                book: data,
                                                                booksList:
                                                                    dd.data!,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        if (dd.data!.length > 3)
                                                          w10,
                                                        if (dd.data!.length > 3)
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(Icons
                                                                  .arrow_forward_ios_rounded),
                                                              h20,
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  h10,
                                                ],
                                              );
                                      },
                                      itemCount: ePrv.videobookslabel.length,
                                    ),
                      // child: GridView.builder(
                      //   physics: BouncingScrollPhysics(),
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 4,
                      //     crossAxisSpacing: 16,
                      //     mainAxisSpacing: 8,
                      //     childAspectRatio: 0.82,
                      //   ),
                      //   itemBuilder: (context, i) {
                      //     return LibraryEbookWidget(
                      //       onTapDownload: () {},
                      //       onTapShare: () {},
                      //       onTap: () {},
                      //     );
                      //   },
                      //   itemCount: 9,
                      // ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}
