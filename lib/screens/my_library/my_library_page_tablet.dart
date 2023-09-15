import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/screens/library_page/widget/book_list_widget.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:number_paginator/number_paginator.dart';

class MyLibraryPageTablet extends StatefulWidget {
  final Arguments? arguments;

  const MyLibraryPageTablet({Key? key, this.arguments}) : super(key: key);

  @override
  State<MyLibraryPageTablet> createState() => _MyLibraryPageTabletState();
}

class _MyLibraryPageTabletState extends State<MyLibraryPageTablet> {
  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: commonAppBar(
          title: widget.arguments!.title,
          description: widget.arguments!.description),
      // endDrawer: endDrawer(),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: Get.width / 3,
                decoration: BoxDecoration(
                    borderRadius: onlyBottomLeft42,
                    color: AppColors.backGroundColor),
                padding: all10,
                height: 70,
                child: NumberPaginator(
                    numberPages: cnt.totalNumberOfPages,
                    onPageChange: (index) async {
                      setState(() {
                        cnt.pageNo = index * 12;
                      });
                    })),
          ],
        ),
      ),
      body: Obx(
        () => cnt.books.isEmpty
            ? NoDataFound(message: "no_book_found".tr)
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: h30v20,
                  // child: GridView.builder(
                  //                         itemCount: cnt.books.length,
                  //                         gridDelegate:
                  //                             SliverGridDelegateWithMaxCrossAxisExtent(
                  //                                 maxCrossAxisExtent: 310,
                  //                                 crossAxisSpacing: 10,
                  //                                 mainAxisSpacing: 10,
                  //                                 mainAxisExtent: 330),
                  //                         itemBuilder: (context, i) {
                  //                                 return BookListItem(
                  //           book: cnt.books[i],
                  //           onTap: () {
                  //             cnt.onBookDetailsTap(
                  //                 bookObj: cnt.books[i],
                  //                 bookList: cnt.books,
                  //                 navigation: true,
                  //                 isSimilarOrNot: true);
                  //           });
                  //                           // return LiveClassList(
                  //                           //   liveSession: lcP.liveClassModel
                  //                           //       ?.data?.liveSession?[i],
                  //                           //   onTap: () {
                  //                           //     navigatorKey.currentState
                  //                           //         ?.pushNamed(
                  //                           //             RoutesConst
                  //                           //                 .liveClassDetails,
                  //                           //             arguments: [
                  //                           //           lcP.liveClassModel?.data
                  //                           //               ?.liveSession?[i],
                  //                           //           StudentRouteArguments()
                  //                           //               .getArgument(RoutesConst
                  //                           //                   .liveClassDetails)
                  //                           //         ]);
                  //                           //   },
                  //                           // );
                  //                         }),
                  child: LayoutGrid(
                    rowGap: 10,
                    columnGap: 10,
                    gridFit: GridFit.passthrough,
                    columnSizes: [auto, auto, auto, auto],
                    rowSizes: List<IntrinsicContentTrackSize>.generate(
                        (cnt.books.length == 1
                                ? cnt.books.length
                                : cnt.books.length / 3)
                            .round(),
                        (int index) => auto),
                    children: cnt.books.skip(cnt.pageNo).take(12).map(
                      (bookItem) {
                        return BookListItem(
                            book: bookItem,
                            onTap: () {
                              cnt.onBookDetailsTap(
                                  bookObj: bookItem,
                                  bookList: cnt.books,
                                  navigation: true,
                                  isSimilarOrNot: true);
                            });
                      },
                    ).toList(),
                  ),
                ),
              ),
      ),
    );
  }
}
