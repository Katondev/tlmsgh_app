import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/training_model.dart';
import 'package:katon/screens/training/pdf_viewer/pdf_viewer.dart';
import 'package:katon/screens/training/training_details/widgets/stage_widget.dart';
import 'package:katon/utils/Routes/teacher_route_arguments.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:provider/provider.dart';

import '../../../models/argument_model.dart';
import '../../../widgets/common_container.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../../../widgets/no_internet.dart';
import '../../../widgets/pdf_view/pdf_view_page.dart';
import '../../blog_page/controller/blog_controller.dart';
import '../../connect/widgets/create_blog_dialog.dart';
import '../../home_page.dart';
import '../controller/training_prv.dart';
import '../widgets/content_widget.dart';
import '../widgets/expansion_tile_custom.dart';

class TrainingDetailsMobile extends StatefulWidget {
  final Arguments arguments;
  const TrainingDetailsMobile({super.key, required this.arguments});

  @override
  State<TrainingDetailsMobile> createState() => _TrainingDetailsMobileState();
}

class _TrainingDetailsMobileState extends State<TrainingDetailsMobile> {
  var args;
  TrainingPrograms? data;
  final blgCnt = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments;
    data = args;
    return Material(
      color: AppColors.primaryWhite,
      child: SafeArea(
        child: Scaffold(
          // appBar: CommonAppbarMobile(title: "${data?.tpProgramTitle}"),
          // appBar: AppBar(
          //   title: Column(
          //     children: [
          //       Text(
          //         "${data?.tpProgramTitle}",
          //         maxLines: 2,
          //         style: FontStyleUtilities.t1(
          //           fontWeight: FWT.semiBold,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // endDrawer: endDrawerMobile(),

          body: Consumer<TrainingProvider>(
            builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CommonAppBar2(
                    isshowback: true,
                    title: "Training",
                    description: "${data?.tpProgramTitle}",
                  ),
                ),
                ConnectionWidget.connection,
                value.value
                    ? Expanded(child: Loader(message: "loading_wait".tr))
                    : value.connection
                        ? Expanded(
                            child: NoInternet(
                                onTap: () => value.getAllTrainings()))
                        : value.trainingdetailModel == null ||
                                value.trainingdetailModel?.data?.content
                                        ?.length ==
                                    0
                            ? Expanded(
                                child: NoDataFound(message: "no_data_found".tr))
                            : Expanded(
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    h20,
                                    StageWidget(),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          if (value.trainingStatus == 1)
                                            Container(
                                              width: Get.width,
                                              padding: EdgeInsets.all(20),
                                              color: AppColors.boxgrey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Submit Form",
                                                    style:
                                                        FontStyleUtilities.h4(
                                                      fontWeight: FWT.semiBold,
                                                      fontColor:
                                                          AppColors.blueType2,
                                                    ),
                                                  ),
                                                  h10,
                                                  LargeButton(
                                                    onPressed: (value
                                                                    .trainingStatus ==
                                                                3 ||
                                                            value.trainingStatus ==
                                                                4 ||
                                                            value.trainingStatus ==
                                                                5)
                                                        ? () {
                                                            log("this side");
                                                            navigatorKey
                                                                .currentState
                                                                ?.pushNamed(
                                                              RoutesConst
                                                                  .trainingResources,
                                                            );
                                                          }
                                                        : () {
                                                            if (value
                                                                    .trainingStatus ==
                                                                0) {
                                                              navigatorKey
                                                                  .currentState
                                                                  ?.pushNamed(
                                                                RoutesConst
                                                                    .trainingOptions,
                                                                arguments: TeacherRouteArguments()
                                                                    .getTeacherArgument(
                                                                        RoutesConst
                                                                            .trainingOptions),
                                                              );
                                                            } else if (value
                                                                    .trainingStatus ==
                                                                1) {
                                                              navigatorKey
                                                                  .currentState
                                                                  ?.pushNamed(
                                                                RoutesConst
                                                                    .trainingSignature,
                                                                arguments: TeacherRouteArguments()
                                                                    .getTeacherArgument(
                                                                        RoutesConst
                                                                            .trainingSignature),
                                                              );
                                                            }
                                                          },
                                                    height: 40,
                                                    width: Get.width,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Text(
                                                      // "Start Upload Document",
                                                      "Digital Attestation",
                                                    ),
                                                  ),
                                                  h10,
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Divider(
                                                        endIndent: 10,
                                                      )),
                                                      Text("OR"),
                                                      Expanded(
                                                          child: Divider(
                                                        indent: 10,
                                                      )),
                                                    ],
                                                  ),
                                                  h10,
                                                  LargeButton(
                                                    onPressed: () async{
                                                        primaryFocus
                                                                  ?.unfocus();
                                                              await uploadAddBlogDialog(
                                                                  context);
                                                                  blgCnt;
                                                                  
                                                    },
                                                    height: 40,
                                                    width: Get.width,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Text(
                                                      // "Start Upload Document",
                                                      "Upload Attestation",
                                                      // style: AppTextStyle
                                                      //     .normalRegular14
                                                      //     .copyWith(
                                                      //         color: AppColors
                                                      //             .primaryWhite),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (value.trainingStatus == 2 ||
                                              value.trainingStatus == 3)
                                            Container(
                                              width: Get.width,
                                              padding: EdgeInsets.all(20),
                                              color: AppColors.boxgrey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Online Exam",
                                                    style:
                                                        FontStyleUtilities.h4(
                                                      fontWeight: FWT.semiBold,
                                                      fontColor:
                                                          AppColors.primary,
                                                    ),
                                                  ),
                                                  h10,
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await value
                                                          .downloadCertificate(
                                                              path: value
                                                                  .certificatePath);
                                                      Get.to(
                                                        PdfViewerScreen(
                                                          filename: value
                                                              .trainingdetailModel!
                                                              .data!
                                                              .trainingParticipants!
                                                              .tpsSignedForm,
                                                          // isFrom: true,
                                                          isdownloadicon: true,
                                                          filetype:
                                                              "Signed Form",
                                                        ),
                                                      );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 35,
                                                          width: 35,
                                                          alignment:
                                                              Alignment.center,
                                                          color:
                                                              AppColors.primary,
                                                          child: Image.asset(
                                                            Images.img,
                                                            height: 15,
                                                            width: 15,
                                                            // color: AppColors.white,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            height: 35,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            color:
                                                                AppColors.white,
                                                            child: Text(
                                                              "Signed Form",
                                                              style: FontStyleUtilities.t1(
                                                                  fontWeight: FWT
                                                                      .regular),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  h10,
                                                  LargeButton(
                                                    onPressed: () {
                                                      // Navigator.of(context).pushNamed(
                                                      //   RoutesConst.onlineExam,
                                                      //   arguments: TeacherRouteArguments()
                                                      //       .getTeacherArgument(
                                                      //           RoutesConst.onlineExam),
                                                      // );
                                                      Get.toNamed(RoutesConst
                                                          .onlineExam);
                                                    },
                                                    height: 40,
                                                    width: Get.width,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Text(
                                                      "Start Exam",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (value.trainingStatus == 4)
                                            Container(
                                              width: Get.width,
                                              padding: EdgeInsets.all(20),
                                              color: AppColors.boxgrey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Certification!",
                                                    style:
                                                        FontStyleUtilities.h4(
                                                      fontWeight: FWT.semiBold,
                                                      fontColor:
                                                          AppColors.blueType2,
                                                    ),
                                                  ),
                                                  h10,
                                                  Text(
                                                    "Great, you have passed Online MCQ Exam. Admin team will approve your certificate soon.",
                                                    style:
                                                        FontStyleUtilities.t1(
                                                      fontWeight: FWT.semiBold,
                                                      fontColor:
                                                          AppColors.black,
                                                    ),
                                                  ),
                                                  // h10,
                                                  // LargeButton(
                                                  //   onPressed: () async {},
                                                  //   height: 40,
                                                  //   width: Get.width,
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(30),
                                                  //   child: Text(
                                                  //     "Waiting for Admin to check Result",
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          if (value.trainingStatus == 5)
                                            Container(
                                              width: Get.width,
                                              padding: EdgeInsets.all(20),
                                              color: AppColors.boxgrey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Certification!",
                                                    style:
                                                        FontStyleUtilities.h4(
                                                      fontWeight: FWT.semiBold,
                                                      fontColor:
                                                          AppColors.blueType2,
                                                    ),
                                                  ),
                                                  h10,
                                                  Text(
                                                    "Congratulations, you have successfully completed ICT training program. Hit button to download your certificate",
                                                    style:
                                                        FontStyleUtilities.t1(
                                                      fontWeight: FWT.semiBold,
                                                      fontColor:
                                                          AppColors.black,
                                                    ),
                                                  ),
                                                  h10,
                                                  LargeButton(
                                                    onPressed: () async {
                                                      // await value
                                                      //     .downloadCertificate();

                                                      // Get.to(
                                                      //   PDFViewPage(
                                                      //     filename: value
                                                      //         .trainingdetailModel!
                                                      //         .data!
                                                      //         .trainingParticipants!
                                                      //         .tpsCertificate,
                                                      //     isFrom: true,
                                                      //     isdownloading: true,
                                                      //   ),
                                                      // );
                                                      Get.to(
                                                        PdfViewerScreen(
                                                          filename: value
                                                              .trainingdetailModel!
                                                              .data!
                                                              .trainingParticipants!
                                                              .tpsCertificate,
                                                          // isFrom: true,
                                                          isdownloadicon: true,
                                                          filetype:
                                                              "Certificate",
                                                        ),
                                                      );
                                                    },
                                                    height: 40,
                                                    width: Get.width,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Text(
                                                      "Download Certificate",
                                                    ),
                                                  ),
                                                  h10,
                                                  LargeButton(
                                                    onPressed: () {
                                                      // navigatorKey.currentState
                                                      //     ?.pushNamed(
                                                      //   RoutesConst.trainingOptions,
                                                      //   arguments: TeacherRouteArguments()
                                                      //       .getTeacherArgument(
                                                      //           RoutesConst
                                                      //               .trainingOptions),
                                                      // );
                                                    },
                                                    height: 40,
                                                    width: Get.width,
                                                    color:
                                                        AppColors.lightOrange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Text(
                                                      "Submit Your Feedback",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          (value.trainingStatus == 1 ||
                                                  value.trainingStatus == 2 ||
                                                  value.trainingStatus == 3 ||
                                                  value.trainingStatus == 4 ||
                                                  value.trainingStatus == 5)
                                              ? h20
                                              : SizedBox(),
                                          (value.trainingStatus == 0)
                                              ? Container(
                                                  width: Get.width,
                                                  padding: EdgeInsets.all(20),
                                                  color: AppColors.boxgrey,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Duration :",
                                                            style: FontStyleUtilities.t1(
                                                                fontWeight: FWT
                                                                    .semiBold),
                                                          ),
                                                          Text(
                                                              data?.tpDuration ??
                                                                  ""),
                                                        ],
                                                      ),
                                                      Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Course level :",
                                                            style: FontStyleUtilities.t1(
                                                                fontWeight: FWT
                                                                    .semiBold),
                                                          ),
                                                          Text("Intermediate"),
                                                        ],
                                                      ),
                                                      Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Language :",
                                                            style: FontStyleUtilities.t1(
                                                                fontWeight: FWT
                                                                    .semiBold),
                                                          ),
                                                          Text("English"),
                                                        ],
                                                      ),
                                                      Divider(),
                                                      h6,
                                                      LargeButton(
                                                        onPressed: () {
                                                          if (value
                                                                  .trainingStatus ==
                                                              0) {
                                                            navigatorKey
                                                                .currentState
                                                                ?.pushNamed(
                                                              RoutesConst
                                                                  .trainingOptions,
                                                              arguments: TeacherRouteArguments()
                                                                  .getTeacherArgument(
                                                                      RoutesConst
                                                                          .trainingOptions),
                                                            );
                                                          } else if (value
                                                                  .trainingStatus ==
                                                              1) {
                                                            navigatorKey
                                                                .currentState
                                                                ?.pushNamed(
                                                              RoutesConst
                                                                  .trainingSignature,
                                                              arguments: TeacherRouteArguments()
                                                                  .getTeacherArgument(
                                                                      RoutesConst
                                                                          .trainingSignature),
                                                            );
                                                          }
                                                        },
                                                        height: 40,
                                                        width: Get.width,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child: Text(
                                                          "Choose Training Option",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  width: Get.width,
                                                  padding: EdgeInsets.all(20),
                                                  color: AppColors.boxgrey,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Duration :",
                                                            style: FontStyleUtilities.t1(
                                                                fontWeight: FWT
                                                                    .semiBold),
                                                          ),
                                                          Text(
                                                              data?.tpDuration ??
                                                                  ""),
                                                        ],
                                                      ),
                                                      Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Course level :",
                                                            style: FontStyleUtilities.t1(
                                                                fontWeight: FWT
                                                                    .semiBold),
                                                          ),
                                                          Text("Intermediate"),
                                                        ],
                                                      ),
                                                      Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Language :",
                                                            style: FontStyleUtilities.t1(
                                                                fontWeight: FWT
                                                                    .semiBold),
                                                          ),
                                                          Text("English"),
                                                        ],
                                                      ),
                                                      Divider(),
                                                      h6,
                                                      LargeButton(
                                                        onPressed: () {
                                                          log("this side");
                                                          navigatorKey
                                                              .currentState
                                                              ?.pushNamed(
                                                            RoutesConst
                                                                .trainingResources,
                                                          );
                                                        },
                                                        height: 40,
                                                        width: Get.width,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child: Text(
                                                          "View Training Resources",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          h20,
                                          Container(
                                            height: 50,
                                            width: Get.width,
                                            alignment: Alignment.centerLeft,
                                            color: AppColors.white,
                                            child: Text(
                                              "Course Content",
                                              style: FontStyleUtilities.h4(
                                                  fontWeight: FWT.semiBold,
                                                  fontColor: AppColors.black),
                                            ),
                                          ),
                                          h10,
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemCount: value.trainingdetailModel
                                                ?.data?.content?.length,
                                            itemBuilder: (context, i) {
                                              var data = value
                                                  .trainingdetailModel
                                                  ?.data
                                                  ?.content?[i];
                                              return ExpansionTileCustom(
                                                title: Text(
                                                  "${data?.cmContentTitle}",
                                                  style: FontStyleUtilities.t1(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.primary),
                                                ),
                                                children: [
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: data
                                                        ?.cmDescription?.length,
                                                    itemBuilder: (context, i) {
                                                      var desData = data
                                                          ?.cmDescription?[i]
                                                          .replaceAll("\n", "");
                                                      return ContentWidget(
                                                        leading: "${i + 1}. ",
                                                        title: "${desData}",
                                                      );
                                                    },
                                                  ),
                                                  h20,
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
