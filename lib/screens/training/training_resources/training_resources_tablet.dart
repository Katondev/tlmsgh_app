import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/widgets/pdf_view/pdf_view_page.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../network/api_constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/font_style.dart';
import '../../../widgets/button.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../../../widgets/no_internet.dart';
import '../pdf_viewer/pdf_viewer.dart';

class TrainingResourcesTablet extends StatefulWidget {
  final Arguments arguments;
  const TrainingResourcesTablet({super.key, required this.arguments});

  @override
  State<TrainingResourcesTablet> createState() =>
      _TrainingResourcesTabletState();
}

class _TrainingResourcesTabletState extends State<TrainingResourcesTablet> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  TrainingProvider? pro;

  getVideo() async {
    // log(widget.title!);
    pro = Provider.of<TrainingProvider>(context, listen: false);
    if (pro?.currentVideoIndex == 0) {
      pro?.videoUrl =
          "${ApiRoutes.imageURL}${pro!.trainingdetailModel!.data!.content![0].cmVideo!}";
    } else {
      pro?.videoUrl =
          "${ApiRoutes.imageURL}${pro!.trainingdetailModel!.data!.content![pro!.currentVideoIndex].cmVideo!}";
    }
    videoPlayerController = VideoPlayerController.network("${pro?.videoUrl}");
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.size.aspectRatio,
      autoInitialize: true,
      autoPlay: false,
      looping: false,
      showOptions: false,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
      allowFullScreen: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryWhite,
      child: SafeArea(
        child: Scaffold(
          // endDrawer: endDrawer(),
          backgroundColor: Colors.white,
          // appBar: commonAppBar(
          //     onPressed: () => Navigator.pop(context),
          //     backIcon: true,
          //     // title: widget.arguments.title,
          //     title: "${widget.arguments.title}",
          //     description: widget.arguments.description),
          body: Consumer<TrainingProvider>(
            builder: (context, value, _) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
                  child: CommonAppBar2(
                      isshowback: true,
                      title: "${widget.arguments.title}",
                      description: widget.arguments.description),
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
                                  padding: EdgeInsets.all(20),
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: Get.width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            decoration: BoxDecoration(
                                              color: AppColors.boxgrey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            // child: Text(
                                            //   value
                                            //       .trainingdetailModel!
                                            //       .data!
                                            //       .content![
                                            //           value.currentVideoIndex]
                                            //       .cmContentTitle
                                            //       .toString(),
                                            //   style: FontStyleUtilities.h6(
                                            //     fontWeight: FWT.medium,
                                            //     fontColor: AppColors.black,
                                            //   ),
                                            // ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, i) {
                                                var data = value
                                                    .trainingdetailModel
                                                    ?.data
                                                    ?.content?[i];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    data!.cmContentTitle!,
                                                    style:
                                                        FontStyleUtilities.h6(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          (value.currentVideoIndex ==
                                                                  i)
                                                              ? AppColors
                                                                  .primaryYellow
                                                              : AppColors.black,
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: value
                                                  .trainingdetailModel
                                                  ?.data
                                                  ?.content
                                                  ?.length,
                                            ),
                                          ),
                                        ),
                                        w20,
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Get.width,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 20),
                                                decoration: BoxDecoration(
                                                  color: AppColors.boxgrey,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    if (value
                                                            .currentVideoIndex !=
                                                        0)
                                                      LargeButton(
                                                        height: 50,
                                                        width: 90,
                                                        onPressed: () {
                                                          if (value
                                                                  .currentVideoIndex >
                                                              0) {
                                                            value.currentVideoIndex -=
                                                                1;
                                                          }
                                                          getVideo();
                                                          value
                                                              .notifyListeners();
                                                          log(value
                                                              .currentVideoIndex
                                                              .toString());
                                                        },
                                                        child: Text("Previous"),
                                                      ),
                                                    if ((value
                                                            .currentVideoIndex !=
                                                        0))
                                                      w10,
                                                    if (value
                                                            .currentVideoIndex !=
                                                        9)
                                                      LargeButton(
                                                        height: 50,
                                                        width: 90,
                                                        onPressed: () async {
                                                          if (value
                                                                  .currentVideoIndex <
                                                              9) {
                                                            value.currentVideoIndex +=
                                                                1;
                                                          }
                                                          getVideo();
                                                          value
                                                              .notifyListeners();
                                                          log(value
                                                              .currentVideoIndex
                                                              .toString());
                                                        },
                                                        child: Text("Next"),
                                                      ),
                                                    Spacer(),
                                                    if (value
                                                        .trainingdetailModel!
                                                        .data!
                                                        .content![value
                                                            .currentVideoIndex]
                                                        .cmReadingMaterial!
                                                        .isNotEmpty)
                                                      LargeButton(
                                                        height: 50,
                                                        width: 100,
                                                        onPressed: () async {
                                                          // await value
                                                          //     .downloadCertificate(
                                                          //         path: value
                                                          //             .trainingdetailModel!
                                                          //             .data!
                                                          //             .content![value
                                                          //                 .currentVideoIndex]
                                                          //             .cmReadingMaterial!)
                                                          //     .then((v) {
                                                          // });
                                                          Get.to(
                                                            PdfViewerScreen(
                                                              filename: value
                                                                  .trainingdetailModel!
                                                                  .data!
                                                                  .content![value
                                                                      .currentVideoIndex]
                                                                  .cmReadingMaterial!,
                                                              // isFrom: true,
                                                              filetype: "Pdf",
                                                            ),
                                                          );
                                                        },
                                                        child: Text("Read PDF"),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              h20,
                                              SizedBox(
                                                width: Get.width,
                                                height: 330,
                                                child: (chewieController ==
                                                            null ||
                                                        !videoPlayerController
                                                            .value
                                                            .isInitialized)
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Chewie(
                                                        controller:
                                                            chewieController!),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
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
