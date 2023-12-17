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
import 'package:provider/provider.dart';
import '../../teacher/drawer.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/prefs/app_preference.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/loader.dart';
import '../../widgets/no_data_found.dart';
import '../home_page.dart';

class LibraryPageMobile extends StatefulWidget {
  final Arguments arguments;

  const LibraryPageMobile({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<LibraryPageMobile> createState() => _LibraryPageMobileState();
}

class _LibraryPageMobileState extends State<LibraryPageMobile> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.boxgreyColor,
          drawer: AppPreference().isTeacherLogin
              ? TeacherDrawerBox(navKey: navigatorKey)
              : DrawerBox(navKey: navigatorKey),
          // endDrawer: endDrawer(),
          // appBar: CommonAppbarMobile(title: widget.arguments.title),
          body: Consumer<ELearningProvider>(
            builder: (context, ePrv, child) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     // Text(
                    //     //   "${widget.arguments.title}",
                    //     //   style: AppTextStyle.normalBold28.copyWith(
                    //     //     color: AppColors.black,
                    //     //   ),
                    //     // ),
                    //     // h4,
                    //     Text(
                    //       "${widget.arguments.description}",
                    //       style: AppTextStyle.normalRegular14.copyWith(
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
                                                    ePrv.SelectedIndex = index;
                                                    // ePrv.isExpanded = !ePrv.isExpanded;

                                                    
                                                if (ePrv.selectedPractice ==
                                                    0) {
                                                  ePrv.subCategoryName =
                                                      data.title!;
                                                  navigatorKey.currentState
                                                      ?.pushNamed(
                                                          RoutesConst
                                                              .libraryeBooks,
                                                          arguments:
                                                              data.title);
                                                } else if (ePrv
                                                        .selectedPractice ==
                                                    1) {
                                                  //   log("$data");

                                                  //     print("--------------${  ePrv.selectsubjectype}-ddnddn") ;                                                ePrv.subCategoryName =
                                                  //       data.title!;
                                                  ePrv.subCategoryName =
                                                      data.title!;
                                                  navigatorKey.currentState
                                                      ?.pushNamed(
                                                    RoutesConst.libraryvideo,
                                                    arguments: data.title,
                                                  );
                                                }

                                                    data.isExpanded =
                                                        !data.isExpanded!;
                                                    ePrv.notifyListeners();
                                                    log("message--${ePrv.SelectedIndex}---${ePrv.isExpanded}");
                                                  },
                                                  child: ExpansionWidget(
                                                    title:
                                                        data.title.toString(),
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
                                                //             log("$data ddddd");
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
                                                //             log("$data ff");
                                                //             ePrv.subCategoryName =
                                                //                 data.title!;
                                                //             navigatorKey
                                                //                 .currentState
                                                //                 ?.pushNamed(
                                                //               RoutesConst
                                                //                   .libraryvideo,
                                                //               arguments:
                                                //                   data.title,
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
                                    )
                                    
                              : ePrv.subjectList1.isEmpty
                                  ? NoDataFound(message: "no_book_found".tr):SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      
                                      ...List.generate(ePrv.subjectList1.length,
                                          (index) {
                                        var data = ePrv.subjectList1[index];
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                ePrv.SelectedIndex = index;
                                                // ePrv.isExpanded = !ePrv.isExpanded;
                                                print("uutu");
                                                //        ePrv.selectsubjectype = "e-book";
                                                // print("------${ ePrv.selectsubjectype}--type");
                                                // if (ePrv.selectedPractice ==
                                                //     0) {

                                                if (ePrv.selectedPractice ==
                                                    0) {
                                                  ePrv.subCategoryName =
                                                      data.title!;
                                                  navigatorKey.currentState
                                                      ?.pushNamed(
                                                          RoutesConst
                                                              .libraryeBooks,
                                                          arguments:
                                                              data.title);
                                                } else if (ePrv
                                                        .selectedPractice ==
                                                    1) {
                                                  //   log("$data");

                                                  //     print("--------------${  ePrv.selectsubjectype}-ddnddn") ;                                                ePrv.subCategoryName =
                                                  //       data.title!;
                                                  ePrv.subCategoryName =
                                                      data.title!;
                                                  navigatorKey.currentState
                                                      ?.pushNamed(
                                                    RoutesConst.libraryvideo,
                                                    arguments: data.title,
                                                  );
                                                }

                                                data.isExpanded =
                                                    !data.isExpanded!;
                                                ePrv.notifyListeners();
                                                log("message--${ePrv.SelectedIndex}---${ePrv.isExpanded}");
                                              },
                                              child: ExpansionWidget(
                                                title: data.title.toString(),
                                                // trailingIcon: data.isExpanded!
                                                //     ? AppAssets.ic_arrow_down
                                                //     : AppAssets.ic_arrow_left,
                                                margin: EdgeInsets.only(
                                                    bottom: (data.isExpanded!)
                                                        ? 12
                                                        : 20),
                                                // borderColor: data.isExpanded!
                                                //     ? AppColors.primaryYellow
                                                //     : AppColors.transparentColor,
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
                                            //             navigatorKey.currentState
                                            //                 ?.pushNamed(
                                            //                     RoutesConst
                                            //                         .libraryeBooks,
                                            //                     arguments:
                                            //                         data.title);
                                            //           },
                                            //           child: Container(
                                            //             height: 48,
                                            //             decoration: BoxDecoration(
                                            //               color: AppColors.white,
                                            //               borderRadius:
                                            //                   BorderRadius.circular(
                                            //                       10),
                                            //             ),
                                            //             alignment: Alignment.center,
                                            //             child: Text(
                                            //               "${data.subList?[0]}",
                                            //               style: AppTextStyle
                                            //                   .normalRegular16
                                            //                   .copyWith(
                                            //                 fontWeight:
                                            //                     FontWeight.w400,
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
                                            //             navigatorKey.currentState
                                            //                 ?.pushNamed(
                                            //               RoutesConst.libraryvideo,
                                            //               arguments: data.title,
                                            //             );
                                            //           },
                                            //           child: Container(
                                            //             height: 48,
                                            //             decoration: BoxDecoration(
                                            //               color: AppColors.white,
                                            //               borderRadius:
                                            //                   BorderRadius.circular(
                                            //                       10),
                                            //             ),
                                            //             alignment: Alignment.center,
                                            //             child: Text(
                                            //               "${data.subList?[1]}",
                                            //               style: AppTextStyle
                                            //                   .normalRegular16
                                            //                   .copyWith(
                                            //                 fontWeight:
                                            //                     FontWeight.w400,
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
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
