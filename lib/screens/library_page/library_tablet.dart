// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/screens/library_page/widget/expansion_widget.dart';
import 'package:katon/utils/route_const.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/loader.dart';
import '../home_page.dart';

class LibraryPageTablet extends StatefulWidget {
  final Arguments arguments;

  const LibraryPageTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<LibraryPageTablet> createState() => _LibraryPageTabletState();
}

class _LibraryPageTabletState extends State<LibraryPageTablet> {
  // ELearningProvider? eLearningPrv;

  // ScrollController scrollController = ScrollController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   eLearningPrv = Provider.of<ELearningProvider>(context, listen: false);
  //   scrollController.addListener(_scrollListener);
  // }

  // @override
  // void dispose() {
  //   // eLearningPrv?.pagingController.dispose();
  //   super.dispose();
  // }

  // _scrollListener() async {
  //   if (scrollController.position.pixels ==
  //           scrollController.position.maxScrollExtent &&
  //       !scrollController.position.outOfRange) {
  //     if (!eLearningPrv!.isLoadingStarted) {
  //       eLearningPrv?.pages++;
  //       await eLearningPrv?.callApiPagination();
  //     }

  //     log(eLearningPrv!.pages.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Container(
          // decoration: BoxContainer.boxDeco,
          child: Consumer<ELearningProvider>(
            builder: (context, ePrv, child) {
               var args = ModalRoute.of(context)!.settings.arguments;
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                // appBar: commonAppBar(
                //     title: widget.arguments.title.toString(),
                //     description: widget.arguments.description),
                // endDrawer: endDrawer(),
                // bottomNavigationBar: LibraryPagination(
                //   ePrv: ePrv,
                //   width: Get.width / 3,
                // ),
                body: Container(
                  padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "${widget.arguments.title}",
                      //       style: AppTextStyle.normalBold28.copyWith(
                      //         color: AppColors.black,
                      //       ),
                      //     ),
                      //     // h4,
                      //     Text(
                      //       "${widget.arguments.description}",
                      //       style: AppTextStyle.normalRegular16.copyWith(
                      //         color: AppColors.textgrey,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      
                       CommonAppBar2(
                        isshowback: true,
                        title: args.toString(),
                        description: widget.arguments.description),
                          
                      customHeight(15),
                      Expanded(
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.boxgreyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.fromLTRB(60, 48, 60, 26),
                          child: ePrv.value
                              ? Loader(message: "loading_wait".tr)
                              : ePrv.connection
                                  ? (ePrv.listOfSubject.isEmpty)
                                      ? NoDataFound(message: "no_book_found".tr)
                                      : SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              ...List.generate(
                                                  ePrv.listOfSubject.length,
                                                  (index) {
                                                var data =
                                                    ePrv.listOfSubject[index];
                                                return Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        ePrv.SelectedIndex =
                                                            index;
                                                        // ePrv.isExpanded = !ePrv.isExpanded;
                                                        data.isExpanded =
                                                            !data.isExpanded!;
                                                        ePrv.notifyListeners();
                                                        log("message--${ePrv.SelectedIndex}---${ePrv.isExpanded}");
                                                      },
                                                      child: ExpansionWidget(
                                                        title: data.title!,
                                                        trailingIcon: data
                                                                .isExpanded!
                                                            ? AppAssets
                                                                .ic_arrow_down
                                                            : AppAssets
                                                                .ic_arrow_left,
                                                        margin: EdgeInsets.only(
                                                            bottom: (data
                                                                    .isExpanded!)
                                                                ? 12
                                                                : 20),
                                                        borderColor: data.isExpanded!
                                                            ? AppColors
                                                                .primaryYellow
                                                            : AppColors
                                                                .transparentColor,
                                                      ),
                                                    ),
                                                    if (data.isExpanded!)
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                log("$data");
                                                                ePrv.subCategoryName =
                                                                    data.title!;
                                                                navigatorKey
                                                                    .currentState
                                                                    ?.pushNamed(
                                                                        RoutesConst
                                                                            .libraryeBooks,
                                                                        arguments:
                                                                            data.title);
                                                              },
                                                              child: Container(
                                                                height: 48,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "${data.subList?[0]}",
                                                                  style: AppTextStyle
                                                                      .normalRegular16
                                                                      .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          w18,
                                                          Expanded(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                log("$data");
                                                                ePrv.subCategoryName =
                                                                    data.title!;
                                                                navigatorKey
                                                                    .currentState
                                                                    ?.pushNamed(
                                                                  RoutesConst
                                                                      .libraryvideo,
                                                                  arguments: data
                                                                      .title!,
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 48,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "${data.subList?[1]}",
                                                                  style: AppTextStyle
                                                                      .normalRegular16
                                                                      .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    if (data.isExpanded!) h12,
                                                  ],
                                                );
                                              }),
                                            ],
                                          ),
                                        )
                                  : SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          ...List.generate(
                                              ePrv.subjectList1.length,
                                              (index) {
                                            var data = ePrv.subjectList1[index];
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                   
                                                    ePrv.SelectedIndex = index;
                                                    // ePrv.isExpanded = !ePrv.isExpanded;
                                                   if( ePrv.selectedPractice == 0){
                                                     ePrv.selectsubjectype = "ebook";
                                                     //print("khjkiihkh${ePrv.selectsubjectype}");
                                                    ePrv.subCategoryName =
                                                                data.title!;
                                                            navigatorKey
                                                                .currentState
                                                                ?.pushNamed(
                                                                    RoutesConst
                                                                        .libraryeBooks,
                                                                    arguments: data
                                                                        .title);

                                                   }else if(ePrv.selectedPractice == 1){
                                                     ePrv.selectsubjectype = "videos";
                                                      // print("khjkiihkh${ePrv.selectsubjectype}");
                                                                    ePrv.subCategoryName =
                                                                data.title!;
                                                            navigatorKey
                                                                .currentState
                                                                ?.pushNamed(
                                                              RoutesConst
                                                                  .libraryvideo,
                                                              arguments:
                                                                  data.title!,
                                                            );
                                                   }
                                                                
                                                    data.isExpanded =
                                                        !data.isExpanded!;
                                                    ePrv.notifyListeners();
                                                    log("message--${ePrv.SelectedIndex}---${ePrv.isExpanded}");
                                                  },
                                                  child: ExpansionWidget(
                                                    title: data.title!,
                                                    // trailingIcon:
                                                    //     data.isExpanded!
                                                    //         ? AppAssets
                                                    //             .ic_arrow_down
                                                    //         : AppAssets
                                                    //             .ic_arrow_left,
                                                    margin: EdgeInsets.only(
                                                        bottom:
                                                            (data.isExpanded!)
                                                                ? 12
                                                                : 20),
                                                    // borderColor: data.isExpanded!
                                                    //     ? AppColors
                                                    //         .primaryYellow
                                                    //     : AppColors
                                                    //         .transparentColor,
                                                  ),
                                                ),
                                                // if (data.isExpanded!)
                                                //   Row(
                                                //     children: [
                                                //       Expanded(
                                                //         child: GestureDetector(
                                                //           onTap: () {
                                                //             log("$data");
                                                //             ePrv.subCategoryName =
                                                //                 data.title!;
                                                //             navigatorKey
                                                //                 .currentState
                                                //                 ?.pushNamed(
                                                //                     RoutesConst
                                                //                         .libraryeBooks,
                                                //                     arguments: data
                                                //                         .title);
                                                //           },
                                                //           child: Container(
                                                //             height: 48,
                                                //             decoration:
                                                //                 BoxDecoration(
                                                //               color: AppColors
                                                //                   .white,
                                                //               borderRadius:
                                                //                   BorderRadius
                                                //                       .circular(
                                                //                           10),
                                                //             ),
                                                //             alignment: Alignment
                                                //                 .center,
                                                //             child: Text(
                                                //               "${data.subList?[0]}",
                                                //               style: AppTextStyle
                                                //                   .normalRegular16
                                                //                   .copyWith(
                                                //                 fontWeight:
                                                //                     FontWeight
                                                //                         .w400,
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       w18,
                                                //       Expanded(
                                                //         child: GestureDetector(
                                                //           onTap: () {
                                                //             log("$data");
                                                //             ePrv.subCategoryName =
                                                //                 data.title!;
                                                //             navigatorKey
                                                //                 .currentState
                                                //                 ?.pushNamed(
                                                //               RoutesConst
                                                //                   .libraryvideo,
                                                //               arguments:
                                                //                   data.title!,
                                                //             );
                                                //           },
                                                //           child: Container(
                                                //             height: 48,
                                                //             decoration:
                                                //                 BoxDecoration(
                                                //               color: AppColors
                                                //                   .white,
                                                //               borderRadius:
                                                //                   BorderRadius
                                                //                       .circular(
                                                //                           10),
                                                //             ),
                                                //             alignment: Alignment
                                                //                 .center,
                                                //             child: Text(
                                                //               "${data.subList?[1]}",
                                                //               style: AppTextStyle
                                                //                   .normalRegular16
                                                //                   .copyWith(
                                                //                 fontWeight:
                                                //                     FontWeight
                                                //                         .w400,
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // if (data.isExpanded!) h12,
                                              ],
                                            );
                                          }),
                                        ],
                                      ),
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
            