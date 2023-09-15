// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/library_page/widget/expansion_widget.dart';
import 'package:katon/screens/practice/past_questions/past_questions_screen.dart';
import 'package:katon/screens/practice/self_assessment/self_assessment_screen.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/no_data_found.dart';
import '../../home_page.dart';
import '../../training/pdf_viewer/pdf_viewer.dart';
import '../controller/practice_prv.dart';

class PracticeTeacherPageTablet extends StatefulWidget {
  final Arguments arguments;

  const PracticeTeacherPageTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticeTeacherPageTablet> createState() =>
      _PracticeTeacherPageTabletState();
}

class _PracticeTeacherPageTabletState extends State<PracticeTeacherPageTablet> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Container(
          // decoration: BoxContainer.boxDeco,
          child: Consumer<PracticePrv>(
            builder: (context, ePrv, child) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                // endDrawer: endDrawer(),
                body: Container(
                  padding: const EdgeInsets.fromLTRB(35, 30, 35, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonAppBar2(
                          title: widget.arguments.title,
                          description: widget.arguments.description),
                      customHeight(15),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.boxgreyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.fromLTRB(40, 42, 60, 38),
                          child: (ePrv.practiceTeacherList.isEmpty)
                              ? NoDataFound(message: "no_book_found".tr)
                              : GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    // crossAxisCount: 4,
                                    maxCrossAxisExtent: 300,
                                    mainAxisExtent: 250,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30,
                                    childAspectRatio: 1.3,
                                  ),
                                  itemBuilder: (context, i) {
                                    var data = ePrv.practiceTeacherList[i];
                                    return GestureDetector(
                                      onTap: () {
                                        ePrv.selectedPractice = i;
                                        navigatorKey.currentState!.pushNamed(
                                            RoutesConst.practiceSubject,
                                            arguments: data["title"]);
                                      },
                                      child: Container(
                                        // height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: AppColors.primaryWhite,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColors.primaryBlack
                                                      .withOpacity(.05),
                                                  blurRadius: 12),
                                            ]),

                                        child: Column(
                                          children: [
                                            // Text(
                                            //   "${data.ppTitle}",
                                            //   textAlign: TextAlign.center,
                                            //   maxLines: 2,
                                            //   overflow: TextOverflow.ellipsis,
                                            //   style: AppTextStyle.normalBold20
                                            //       .copyWith(
                                            //     color: AppColors.primaryBlack,
                                            //   ),
                                            // ),
                                            // h20,
                                            Expanded(
                                              child: Container(
                                                width: Get.width,
                                                height: 100,
                                                padding:
                                                    const EdgeInsets.all(40),
                                                child: Image.asset(
                                                  data["image"],
                                                  // height: 100,
                                                ),
                                              ),
                                            ),
                                            // h22,
                                            // const Spacer(),
                                            Container(
                                              width: Get.width,
                                              height: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                                color: AppColors.boxgreyColor
                                                    .withOpacity(.7),
                                              ),
                                              child: Text(
                                                data["title"],
                                                style: AppTextStyle
                                                    .normalRegular16
                                                    .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: ePrv.practiceTeacherList.length,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

     // body: Row(
                //   children: [
                //     ValueListenableBuilder(
                //       valueListenable:
                //           context.read<ELearningProvider>().isFilter,
                //       builder: (context, isFilter, _) {
                //         return Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const ELearningFilterBar(),
                //               ConnectionWidget.connection,
                //               Expanded(
                //                 child: ePrv.value
                //                     ? Loader(message: "loading_wait".tr)
                //                     : ePrv.connection
                //                         ? NoInternet(
                //                             onTap: () => ePrv.resetOnTap(),
                //                           )
                //                         : isFilter
                //                             ? Consumer<ELearningProvider>(
                //                                 builder: (context, ePrv, _) {
                //                                   return ePrv.filterList ==
                //                                               null ||
                //                                           ePrv.filterList
                //                                               .isEmpty
                //                                       ? NoDataFound(
                //                                           message:
                //                                               "no_book_found"
                //                                                   .tr)
                //                                       : Padding(
                //                                           padding:
                //                                               const EdgeInsets
                //                                                   .all(8.0),
                //                                           child:
                //                                               GridView.builder(
                //                                             controller:
                //                                                 scrollController,
                //                                             gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //                                                 childAspectRatio:
                //                                                     10 / 13.3,
                //                                                 maxCrossAxisExtent:
                //                                                     310,
                //                                                 crossAxisSpacing:
                //                                                     10,
                //                                                 mainAxisSpacing:
                //                                                     10),
                //                                             itemCount: ePrv
                //                                                     .filterList
                //                                                     .length +
                //                                                 1,
                //                                             itemBuilder:
                //                                                 (context, i) {
                //                                               if (ePrv.filterList
                //                                                       .length ==
                //                                                   i) {
                //                                                 return ePrv
                //                                                         .isLoadingStarted
                //                                                     ? Center(
                //                                                         child:
                //                                                             CircularProgressIndicator(),
                //                                                       )
                //                                                     : SizedBox();
                //                                               }
                //                                               var data = ePrv
                //                                                   .filterList[i];
                //                                               return BookListItem(
                //                                                   book: data,
                //                                                   onTap: () {
                //                                                     ePrv.onBookDetailsTap(
                //                                                         context:
                //                                                             context,
                //                                                         bookObj:
                //                                                             data,
                //                                                         bookList:
                //                                                             ePrv
                //                                                                 .filterList,
                //                                                         navigation:
                //                                                             true);
                //                                                   });
                //                                             },
                //                                           ),
                //                                         );
                //                                   // : PaginationView<
                //                                   //     BookDetailsM>(
                //                                   //     key: ePrv
                //                                   //         .pageviewPaginationKeyTablet,
                //                                   //     preloadedItems: <
                //                                   //         BookDetailsM>[],
                //                                   //     itemBuilder: (BuildContext
                //                                   //             context,
                //                                   //         BookDetailsM user,
                //                                   //         int index) {
                //                                   //       return BookListItem(
                //                                   //           book:
                //                                   //               ePrv.filterList[
                //                                   //                   index],
                //                                   //           onTap: () {
                //                                   //             ePrv.onBookDetailsTap(
                //                                   //                 bookObj: ePrv
                //                                   //                         .filterList[
                //                                   //                     index],
                //                                   //                 bookList: ePrv
                //                                   //                     .filterList,
                //                                   //                 navigation:
                //                                   //                     true);
                //                                   //           });
                //                                   //     },
                //                                   //     paginationViewType:
                //                                   //         PaginationViewType
                //                                   //             .gridView, // optional
                //                                   //     gridDelegate:
                //                                   //         SliverGridDelegateWithMaxCrossAxisExtent(
                //                                   //       childAspectRatio:
                //                                   //           10 / 13.3,
                //                                   //       maxCrossAxisExtent:
                //                                   //           320,
                //                                   //       crossAxisSpacing:
                //                                   //           10,
                //                                   //       mainAxisSpacing: 10,
                //                                   //     ),
                //                                   //     padding:
                //                                   //         EdgeInsets.all(
                //                                   //             20),
                //                                   //     pageFetch: (_) {
                //                                   //       log("refresh list successfully");
                //                                   //       return ePrv
                //                                   //           .callApiPagination();
                //                                   //     },
                //                                   //     onError: (dynamic
                //                                   //             error) =>
                //                                   //         Center(
                //                                   //             child: NoDataFound(
                //                                   //                 message:
                //                                   //                     "no_book_found"
                //                                   //                         .tr)),
                //                                   //     onEmpty: Center(
                //                                   //         child: NoDataFound(
                //                                   //             message:
                //                                   //                 "no_book_found"
                //                                   //                     .tr)),
                //                                   //     bottomLoader: Center(
                //                                   //       // optional
                //                                   //       child:
                //                                   //           CircularProgressIndicator(),
                //                                   //     ),
                //                                   //   );
                //                                 },
                //                               )
                //                             : Padding(
                //                                 padding:
                //                                     const EdgeInsets.all(8.0),
                //                                 child: GridView.builder(
                //                                   controller: scrollController,
                //                                   gridDelegate:
                //                                       SliverGridDelegateWithMaxCrossAxisExtent(
                //                                           childAspectRatio:
                //                                               10 / 13.3,
                //                                           maxCrossAxisExtent:
                //                                               310,
                //                                           crossAxisSpacing: 10,
                //                                           mainAxisSpacing: 10),
                //                                   itemCount:
                //                                       ePrv.books.length + 1,
                //                                   itemBuilder: (context, i) {
                //                                     if (ePrv.books.length ==
                //                                         i) {
                //                                       return ePrv
                //                                               .isLoadingStarted
                //                                           ? Center(
                //                                               child:
                //                                                   CircularProgressIndicator(),
                //                                             )
                //                                           : SizedBox();
                //                                     }
                //                                     var data = ePrv.books[i];
                //                                     return BookListItem(
                //                                         book: data,
                //                                         onTap: () {
                //                                           ePrv.onBookDetailsTap(
                //                                               context: context,
                //                                               bookObj: data,
                //                                               bookList: ePrv
                //                                                   .booksM[0]
                //                                                   .data!
                //                                                   .bookList!
                //                                                   .rows!,
                //                                               navigation: true);
                //                                         });
                //                                   },
                //                                 ),
                //                               ),
                //                 // : PaginationView<BookDetailsM>(
                //                 //     key: ePrv
                //                 //         .pageviewPaginationKeyTablet,
                //                 //     preloadedItems: <
                //                 //         BookDetailsM>[],
                //                 //     itemBuilder:
                //                 //         (BuildContext context,
                //                 //             BookDetailsM user,
                //                 //             int index) {
                //                 //       return BookListItem(
                //                 //           book: user,
                //                 //           onTap: () {
                //                 //             ePrv.onBookDetailsTap(
                //                 //                 bookObj: user,
                //                 //                 bookList: ePrv
                //                 //                     .booksM[0]
                //                 //                     .data!
                //                 //                     .bookList!
                //                 //                     .rows!,
                //                 //                 navigation: true);
                //                 //           });
                //                 //       // return Padding(
                //                 //       //   padding: hz5,
                //                 //       //   child: LayoutGrid(
                //                 //       //     rowGap: 10,
                //                 //       //     columnGap: 10,
                //                 //       //     gridFit: GridFit.passthrough,
                //                 //       //     columnSizes: [auto, auto],
                //                 //       //     rowSizes: List<
                //                 //       //             IntrinsicContentTrackSize>.generate(
                //                 //       //         (ePrv.booksM!.data!.bookList!
                //                 //       //                     .rows!.length /
                //                 //       //                 2)
                //                 //       //             .round(),
                //                 //       //         (int index) => auto),
                //                 //       //     children: ePrv
                //                 //       //         .booksM!.data!.bookList!.rows!
                //                 //       //         .map(
                //                 //       //       (bookItem) {
                //                 //       //         return BookListItem(
                //                 //       //             book: bookItem,
                //                 //       //             onTap: () {
                //                 //       //               ePrv.onBookDetailsTap(
                //                 //       //                   bookObj: bookItem,
                //                 //       //                   bookList: ePrv
                //                 //       //                       .booksM!
                //                 //       //                       .data!
                //                 //       //                       .bookList!
                //                 //       //                       .rows!,
                //                 //       //                   navigation: true);
                //                 //       //             });
                //                 //       //       },
                //                 //       //     ).toList(),
                //                 //       //   ),
                //                 //       // );
                //                 //     },
                //                 //     paginationViewType:
                //                 //         PaginationViewType
                //                 //             .gridView, // optional
                //                 //     gridDelegate:
                //                 //         SliverGridDelegateWithMaxCrossAxisExtent(
                //                 //       childAspectRatio: 10 / 13.3,
                //                 //       maxCrossAxisExtent: 320,
                //                 //       crossAxisSpacing: 10,
                //                 //       mainAxisSpacing: 10,
                //                 //     ),
                //                 //     padding: EdgeInsets.all(20),
                //                 //     pageFetch: (_) {
                //                 //       return ePrv
                //                 //           .callApiPagination();
                //                 //     },
                //                 //     onError: (dynamic error) =>
                //                 //         Center(
                //                 //             child: NoDataFound(
                //                 //                 message:
                //                 //                     "no_book_found"
                //                 //                         .tr)),
                //                 //     onEmpty: Center(
                //                 //         child: NoDataFound(
                //                 //             message: "no_book_found"
                //                 //                 .tr)),
                //                 //     bottomLoader: Center(
                //                 //       // optional
                //                 //       child:
                //                 //           CircularProgressIndicator(),
                //                 //     ),
                //                 //   ),
                //               ),
                //             ],
                //           ),
                //         );
                //       },
                //     ),
                //   ],
                // ),
            