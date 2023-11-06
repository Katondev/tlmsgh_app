import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/training_model.dart';
import 'package:katon/screens/training/pdf_viewer/pdf_viewer.dart';
import 'package:katon/screens/training/training_details/widgets/stage_widget.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:provider/provider.dart';
import '../../../utils/Routes/teacher_route_arguments.dart';
import '../../../utils/global_singlton.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../../../widgets/no_internet.dart';
import '../../../widgets/pdf_view/pdf_view_page.dart';
import '../../home_page.dart';
import '../controller/training_prv.dart';
import '../widgets/content_widget.dart';
import '../widgets/expansion_tile_custom.dart';

class TrainingDetailsTablet extends StatefulWidget {
  final Arguments arguments;
  const TrainingDetailsTablet({super.key, required this.arguments});

  @override
  State<TrainingDetailsTablet> createState() => _TrainingDetailsTabletState();
}

class _TrainingDetailsTabletState extends State<TrainingDetailsTablet> {
  var args;
  TrainingPrograms? data;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments;
    data = args;
    return Material(
      color: AppColors.primaryWhite,
      child: SafeArea(
        child: Scaffold(
          body: Consumer<TrainingProvider>(
            builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
                  child: CommonAppBar2(
                      isshowback: true,
                      title: data?.tpProgramTitle ?? "",
                      description: widget.arguments.description),
                ),
                // customHeight(15),
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

                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    h20,
                                    StageWidget(),
                                    Padding(
                                      padding: EdgeInsets.all(30),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: Get.width,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      color: AppColors.white,
                                                      child: Text(
                                                        "Course Content",
                                                        style: FontStyleUtilities
                                                            .h3(
                                                                fontWeight: FWT
                                                                    .semiBold,
                                                                fontColor:
                                                                    AppColors
                                                                        .black),
                                                      ),
                                                    ),
                                                    h10,
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount: value
                                                          .trainingdetailModel
                                                          ?.data
                                                          ?.content
                                                          ?.length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        var data = value
                                                            .trainingdetailModel
                                                            ?.data
                                                            ?.content?[i];
                                                        return ExpansionTileCustom(
                                                          title: Text(
                                                            "${data?.cmContentTitle}",
                                                            style: FontStyleUtilities.h5(
                                                                fontWeight:
                                                                    FWT.medium,
                                                                fontColor:
                                                                    AppColors
                                                                        .primary),
                                                          ),
                                                          children: [
                                                            ListView.builder(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: data
                                                                  ?.cmDescription
                                                                  ?.length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                var desData = data
                                                                    ?.cmDescription?[
                                                                        i]
                                                                    .replaceAll(
                                                                        "\n",
                                                                        "");
                                                                return ContentWidget(
                                                                  leading:
                                                                      "${i + 1}. ",
                                                                  title:
                                                                      "${desData}",
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
                                              w20,
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  children: [
                                                    if (value.trainingStatus ==
                                                        1) 
                                                      if (value.trainingStatus == 1 )
                                                  value.trainingdetailModel?.data!.trainingParticipants!.tpsTrainingOption == null||value.trainingStatus == 1 &&value.trainingdetailModel?.data!.trainingParticipants!.tpsTrainingOption == 1? Container(
                                                        color:
                                                            AppColors.boxgrey,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  "Note: Lets complete all recorded videos and then submit attestation form"),
                                                              h20,
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
                                                                width:
                                                                    Get.width,
                                                                // borderRadius:
                                                                //     BorderRadius
                                                                //         .circular(30),
                                                                child: Text(
                                                                  "Training Resources",
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ):  
                                                      Container(
                                                        width: Get.width,
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        color:
                                                            AppColors.boxgrey,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Submit Form",
                                                              style:
                                                                  FontStyleUtilities
                                                                      .h4(
                                                                fontWeight: FWT
                                                                    .semiBold,
                                                                fontColor:
                                                                    AppColors
                                                                        .blueType2,
                                                              ),
                                                            ),
                                                            h20,
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
                                                                          arguments:
                                                                              TeacherRouteArguments().getTeacherArgument(RoutesConst.trainingOptions),
                                                                        );
                                                                      } else if (value
                                                                              .trainingStatus ==
                                                                          1) {
                                                                        navigatorKey
                                                                            .currentState
                                                                            ?.pushNamed(
                                                                          RoutesConst
                                                                              .trainingSignature,
                                                                          arguments:
                                                                              TeacherRouteArguments().getTeacherArgument(RoutesConst.trainingSignature),
                                                                        );
                                                                      }
                                                                    },
                                                              height: 50,
                                                              width: Get.width,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: Text(
                                                                // "Start Upload Document",
                                                                "Digital Attestation",
                                                                style: FontStyleUtilities.h5(
                                                                    fontWeight: FWT
                                                                        .medium,
                                                                    fontColor:
                                                                        AppColors
                                                                            .white),
                                                              ),
                                                            ),
                                                            h10,
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    child:
                                                                        Divider(
                                                                  endIndent: 10,
                                                                )),
                                                                Text("OR"),
                                                                Expanded(
                                                                    child:
                                                                        Divider(
                                                                  indent: 10,
                                                                )),
                                                              ],
                                                            ),
                                                            h10,
                                                            LargeButton(
                                                              onPressed: () {},
                                                              height: 50,
                                                              width: Get.width,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: Text(
                                                                // "Start Upload Document",
                                                                "Upload Attestation",
                                                                style: FontStyleUtilities.h5(
                                                                    fontWeight: FWT
                                                                        .medium,
                                                                    fontColor:
                                                                        AppColors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    if (value.trainingStatus ==
                                                            2 ||
                                                        value.trainingStatus ==
                                                            3)
                                                      Container(
                                                        width: Get.width,
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        color:
                                                            AppColors.boxgrey,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Online Exam",
                                                              style:
                                                                  FontStyleUtilities
                                                                      .h3(
                                                                fontWeight: FWT
                                                                    .semiBold,
                                                                fontColor:
                                                                    AppColors
                                                                        .primary,
                                                              ),
                                                            ),
                                                            h20,
                                                            GestureDetector(
                                                              onTap: () {
                                                                //          await value
                                                                // .downloadCertificate(
                                                                //     path: value
                                                                //         .certificatePath);

                                                                Get.to(
                                                                  PdfViewerScreen(
                                                                    filename: value
                                                                        .trainingdetailModel!
                                                                        .data!
                                                                        .trainingParticipants!
                                                                        .tpsSignedForm,
                                                                    // isFrom: true,
                                                                    isdownloadicon:
                                                                        true,
                                                                    filetype:
                                                                        "Signed Form",
                                                                  ),
                                                                );
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    color: AppColors
                                                                        .primary,
                                                                    child: Image
                                                                        .asset(
                                                                      Images
                                                                          .img,
                                                                      height:
                                                                          15,
                                                                      width: 15,
                                                                      // color: AppColors.white,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          40,
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              15),
                                                                      color: AppColors
                                                                          .white,
                                                                      child:
                                                                          Text(
                                                                        "Signed Form",
                                                                        style: FontStyleUtilities.h5(
                                                                            fontWeight:
                                                                                FWT.regular),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            h20,
                                                            LargeButton(
                                                              onPressed: () {
                                                                // Navigator.of(context)
                                                                //     .pushNamed(
                                                                //   RoutesConst.onlineExam,
                                                                //   arguments: TeacherRouteArguments()
                                                                //       .getTeacherArgument(
                                                                //           RoutesConst
                                                                //               .onlineExam),
                                                                // );
                                                                Get.toNamed(
                                                                  RoutesConst
                                                                      .onlineExam,
                                                                  arguments: TeacherRouteArguments()
                                                                      .getTeacherArgument(
                                                                          RoutesConst
                                                                              .onlineExam),
                                                                );
                                                              },
                                                              height: 50,
                                                              width: Get.width,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: Text(
                                                                "Start Exam",
                                                                style: FontStyleUtilities.h5(
                                                                    fontWeight: FWT
                                                                        .medium,
                                                                    fontColor:
                                                                        AppColors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    if (value.trainingStatus ==
                                                        4)
                                                      Container(
                                                        width: Get.width,
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        color:
                                                            AppColors.boxgrey,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Certification!",
                                                              style:
                                                                  FontStyleUtilities
                                                                      .h3(
                                                                fontWeight: FWT
                                                                    .semiBold,
                                                                fontColor:
                                                                    AppColors
                                                                        .blueType2,
                                                              ),
                                                            ),
                                                            h10,
                                                            Text(
                                                              "Great, you have passed Online MCQ Exam. Admin team will approve your certificate soon.",
                                                              style:
                                                                  FontStyleUtilities
                                                                      .h5(
                                                                fontWeight: FWT
                                                                    .semiBold,
                                                                fontColor:
                                                                    AppColors
                                                                        .black,
                                                              ),
                                                            ),
                                                            // h20,
                                                            // LargeButton(
                                                            //   onPressed:
                                                            //       () async {},
                                                            //   height: 50,
                                                            //   width: Get.width,
                                                            //   borderRadius:
                                                            //       BorderRadius
                                                            //           .circular(30),
                                                            //   child: Text(
                                                            //     "Waiting for Admin to check Result",
                                                            //     style: FontStyleUtilities.h5(
                                                            //         fontWeight:
                                                            //             FWT.medium,
                                                            //         fontColor:
                                                            //             AppColors
                                                            //                 .white),
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    if (value.trainingStatus ==
                                                        5)
                                                      Container(
                                                        width: Get.width,
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        color:
                                                            AppColors.boxgrey,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Certification!",
                                                              style:
                                                                  FontStyleUtilities
                                                                      .h3(
                                                                fontWeight: FWT
                                                                    .semiBold,
                                                                fontColor:
                                                                    AppColors
                                                                        .blueType2,
                                                              ),
                                                            ),
                                                            h10,
                                                            Text(
                                                              "Congratulations, you have successfully completed ICT training program. Hit button to download your certificate",
                                                              style:
                                                                  FontStyleUtilities
                                                                      .h5(
                                                                fontWeight: FWT
                                                                    .semiBold,
                                                                fontColor:
                                                                    AppColors
                                                                        .black,
                                                              ),
                                                            ),
                                                            h20,
                                                            LargeButton(
                                                              onPressed:
                                                                  () async {
                                                                Get.to(
                                                                  PdfViewerScreen(
                                                                    filename:
                                                                        "${value.trainingdetailModel!.data!.trainingParticipants!.tpsCertificate}",
                                                                    // isFrom: true,
                                                                    isdownloadicon:
                                                                        true,
                                                                    filetype:
                                                                        "Certificate",
                                                                  ),
                                                                );
                                                                // await value
                                                                //     .downloadCertificate(
                                                                //         path: value
                                                                //             .certificatePath);
                                                              },
                                                              height: 50,
                                                              width: Get.width,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: Text(
                                                                "Download Certificate",
                                                                style: FontStyleUtilities.h5(
                                                                    fontWeight: FWT
                                                                        .medium,
                                                                    fontColor:
                                                                        AppColors
                                                                            .white),
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
                                                              height: 50,
                                                              width: Get.width,
                                                              color: AppColors
                                                                  .lightOrange,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: Text(
                                                                "Submit Your Feedback",
                                                                style: FontStyleUtilities.h5(
                                                                    fontWeight: FWT
                                                                        .medium,
                                                                    fontColor:
                                                                        AppColors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    (value.trainingStatus ==
                                                                1 ||
                                                            value.trainingStatus ==
                                                                2 ||
                                                            value.trainingStatus ==
                                                                3 ||
                                                            value.trainingStatus ==
                                                                4 ||
                                                            value.trainingStatus ==
                                                                5)
                                                        ? h30
                                                        : SizedBox(),
                                                    (value.trainingStatus == 0)
                                                        ? ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount: value!
                                                                .trainingList
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    i) {
                                                              var data = value
                                                                  .trainingList[i];
                                                              value.selectedTrainingMode =
                                                                  i;

                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    if (i ==
                                                                        0) {
                                                                      value.trainingOption =
                                                                          3;
                                                                    } else if (i ==
                                                                        1) {
                                                                      value.trainingOption =
                                                                          2;
                                                                    } else if (i ==
                                                                        2) {
                                                                      value.trainingOption =
                                                                          1;
                                                                    }

                                                                    print(value
                                                                        .trainingOption);
                                                                    if (value
                                                                            .trainingStatus ==
                                                                        0) {
                                                                      navigatorKey
                                                                          .currentState
                                                                          ?.pushNamed(
                                                                        RoutesConst
                                                                            .trainingOptions,
                                                                        arguments:
                                                                            TeacherRouteArguments().getTeacherArgument(RoutesConst.trainingOptions),
                                                                      );
                                                                    } else if (value
                                                                            .trainingStatus ==
                                                                        1) {
                                                                      navigatorKey
                                                                          .currentState
                                                                          ?.pushNamed(
                                                                        RoutesConst
                                                                            .trainingSignature,
                                                                        arguments:
                                                                            TeacherRouteArguments().getTeacherArgument(RoutesConst.trainingSignature),
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      height: 150,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: value.selectedTrainingMode ==
                                                                                0
                                                                            ? AppColors.purple
                                                                            : value.selectedTrainingMode == 1
                                                                                ? AppColors.skayblue
                                                                                : AppColors.blue,
                                                                      ),
                                                                      width: Get.width,
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            data["image"],
                                                                          ),
                                                                          Text(
                                                                            data["title"],
                                                                            style:
                                                                                FontStyleUtilities.t1(fontColor: AppColors.white, fontWeight: FWT.semiBold),
                                                                          ),
                                                                        ],
                                                                      )

                                                                      //     ListTile(
                                                                      //   leading: Image
                                                                      //       .asset(
                                                                      //     data[
                                                                      //         "image"],
                                                                      //     height:
                                                                      //         30,
                                                                      //   ),
                                                                      //   title:
                                                                      //       Text(
                                                                      //     data[
                                                                      //         "title"],
                                                                      //     style: FontStyleUtilities.t1(
                                                                      //         fontColor:
                                                                      //             AppColors.white,
                                                                      //         fontWeight: FWT.semiBold),
                                                                      //   ),
                                                                      // ),
                                                                      ),
                                                                ),
                                                              );
                                                            })
                                                        // ? Container(
                                                        //     width: Get.width,
                                                        //     padding:
                                                        //         EdgeInsets.all(
                                                        //             20),
                                                        //     color: AppColors
                                                        //         .boxgrey,
                                                        //     child: Column(
                                                        //       children: [
                                                        //         Row(
                                                        //           mainAxisAlignment:
                                                        //               MainAxisAlignment
                                                        //                   .spaceBetween,
                                                        //           children: [
                                                        //             Text(
                                                        //               "Duration :",
                                                        //               style: FontStyleUtilities.h5(
                                                        //                   fontWeight:
                                                        //                       FWT.semiBold),
                                                        //             ),
                                                        //             Text(
                                                        //               data?.tpDuration ??
                                                        //                   "",
                                                        //               style: FontStyleUtilities.h5(
                                                        //                   fontWeight:
                                                        //                       FWT.regular),
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //         Divider(
                                                        //             height: 20),
                                                        //         Row(
                                                        //           mainAxisAlignment:
                                                        //               MainAxisAlignment
                                                        //                   .spaceBetween,
                                                        //           children: [
                                                        //             Text(
                                                        //               "Course level :",
                                                        //               style: FontStyleUtilities.h5(
                                                        //                   fontWeight:
                                                        //                       FWT.semiBold),
                                                        //             ),
                                                        //             Text(
                                                        //               "Intermediate",
                                                        //               style: FontStyleUtilities.h5(
                                                        //                   fontWeight:
                                                        //                       FWT.regular),
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //         Divider(
                                                        //             height: 20),
                                                        //         Row(
                                                        //           mainAxisAlignment:
                                                        //               MainAxisAlignment
                                                        //                   .spaceBetween,
                                                        //           children: [
                                                        //             Text(
                                                        //               "Language :",
                                                        //               style: FontStyleUtilities.h5(
                                                        //                   fontWeight:
                                                        //                       FWT.semiBold),
                                                        //             ),
                                                        //             Text(
                                                        //               "English",
                                                        //               style: FontStyleUtilities.h5(
                                                        //                   fontWeight:
                                                        //                       FWT.regular),
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //         Divider(
                                                        //             height: 20),
                                                        //         h6,
                                                        //         LargeButton(
                                                        //           onPressed:
                                                        //               () {
                                                        //             if (value
                                                        //                     .trainingStatus ==
                                                        //                 0) {
                                                        //               navigatorKey
                                                        //                   .currentState
                                                        //                   ?.pushNamed(
                                                        //                 RoutesConst
                                                        //                     .trainingOptions,
                                                        //                 arguments:
                                                        //                     TeacherRouteArguments().getTeacherArgument(RoutesConst.trainingOptions),
                                                        //               );
                                                        //             } else if (value
                                                        //                     .trainingStatus ==
                                                        //                 1) {
                                                        //               navigatorKey
                                                        //                   .currentState
                                                        //                   ?.pushNamed(
                                                        //                 RoutesConst
                                                        //                     .trainingSignature,
                                                        //                 arguments:
                                                        //                     TeacherRouteArguments().getTeacherArgument(RoutesConst.trainingSignature),
                                                        //               );
                                                        //             }
                                                        //           },
                                                        //           height: 50,
                                                        //           width:
                                                        //               Get.width,
                                                        //           borderRadius:
                                                        //               BorderRadius
                                                        //                   .circular(
                                                        //                       30),
                                                        //           child: Text(
                                                        //             "Choose Training Option",
                                                        //             style: FontStyleUtilities.h5(
                                                        //                 fontWeight: FWT
                                                        //                     .medium,
                                                        //                 fontColor:
                                                        //                     AppColors.white),
                                                        //           ),
                                                        //         ),
                                                        //       ],
                                                        //     ),
                                                        //   )
                                                        :value.trainingdetailModel?.data!.trainingParticipants!.tpsTrainingOption == null||value.trainingdetailModel?.data!.trainingParticipants!.tpsTrainingOption == 1 || value.trainingOption ==1 ? Text(""): Container(
                                                            width: Get.width,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            color: AppColors
                                                                .boxgrey,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Duration :",
                                                                      style: FontStyleUtilities.h5(
                                                                          fontWeight:
                                                                              FWT.semiBold),
                                                                    ),
                                                                    Text(
                                                                      data?.tpDuration ??
                                                                          "",
                                                                      style: FontStyleUtilities.h5(
                                                                          fontWeight:
                                                                              FWT.regular),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                    height: 20),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Course level :",
                                                                      style: FontStyleUtilities.h5(
                                                                          fontWeight:
                                                                              FWT.semiBold),
                                                                    ),
                                                                    Text(
                                                                      "Intermediate",
                                                                      style: FontStyleUtilities.h5(
                                                                          fontWeight:
                                                                              FWT.regular),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                    height: 20),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Language :",
                                                                      style: FontStyleUtilities.h5(
                                                                          fontWeight:
                                                                              FWT.semiBold),
                                                                    ),
                                                                    Text(
                                                                      "English",
                                                                      style: FontStyleUtilities.h5(
                                                                          fontWeight:
                                                                              FWT.regular),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                    height: 20),
                                                                h6,
                                                                LargeButton(
                                                                  onPressed:
                                                                      () {
                                                                    navigatorKey
                                                                        .currentState
                                                                        ?.pushNamed(
                                                                      RoutesConst
                                                                          .trainingResources,
                                                                    );
                                                                  },
                                                                  height: 50,
                                                                  width:
                                                                      Get.width,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  child: Text(
                                                                    "View Training Resources",
                                                                    style: FontStyleUtilities.h5(
                                                                        fontWeight: FWT
                                                                            .medium,
                                                                        fontColor:
                                                                            AppColors.white),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
