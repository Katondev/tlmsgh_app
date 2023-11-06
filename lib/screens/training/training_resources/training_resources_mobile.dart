import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/screens/training/pdf_viewer/pdf_viewer.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../utils/Routes/teacher_route_arguments.dart';
import '../../../utils/app_binding.dart';
import '../../../widgets/button.dart';
import '../../../widgets/common_appbar.dart';
import '../../connect/widgets/create_blog_dialog.dart';

class TrainingResourcesMobile extends StatefulWidget {
  final Arguments arguments;
  const TrainingResourcesMobile({super.key, required this.arguments});

  @override
  State<TrainingResourcesMobile> createState() =>
      _TrainingResourcesMobileState();
}

class _TrainingResourcesMobileState extends State<TrainingResourcesMobile> {
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
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse("${pro?.videoUrl}"));
    print("${pro?.videoUrl}");
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.size.aspectRatio,
      autoInitialize: true,
      autoPlay: false,
      looping: false,
      showOptions: false,
     
      
      allowFullScreen: true,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ],
      allowPlaybackSpeedChanging: false,
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
          body: Consumer<TrainingProvider>(
            builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CommonAppBar2(
                    isshowback: true,
                    title: "Training",
                    description: "${widget.arguments.title}",
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    physics: BouncingScrollPhysics(),
                    children: [
                      // Container(
                      //   width: Get.width,
                      //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      //   alignment: Alignment.centerLeft,
                      //   decoration: BoxDecoration(
                      //     color: AppColors.boxgrey,
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(10),
                      //       topRight: Radius.circular(10),
                      //     ),
                      //   ),
                      //   child: Text(
                      //     "Topic",
                      //     style: FontStyleUtilities.h4(fontWeight: FWT.medium),
                      //   ),
                      // ),
                      // Divider(
                      //   height: 0,
                      //   thickness: 2,
                      // ),
                      Container(
                        width: Get.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColors.boxgrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value
                                  .trainingdetailModel!
                                  .data!
                                  .content![value.currentVideoIndex]
                                  .cmContentTitle
                                  .toString(),
                              style: FontStyleUtilities.h6(
                                fontWeight: FWT.medium,
                                fontColor: AppColors.black,
                              ),
                            ),
                            h10,
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (value.currentVideoIndex != 0)
                                  LargeButton(
                                    height: 40,
                                    width: 80,
                                    onPressed: () {
                                      if (value.currentVideoIndex > 0) {
                                        value.currentVideoIndex -= 1;
                                      }
                                      getVideo();
                                      value.notifyListeners();
                                      log(value.currentVideoIndex.toString());
                                    },
                                    child: Text("Previous"),
                                  ),
                                if ((value.currentVideoIndex != 0)) w6,
                                if (value.currentVideoIndex != 9)
                                  LargeButton(
                                    height: 40,
                                    width: 80,
                                    onPressed: () async {
                                      if (value.currentVideoIndex < 9) {
                                        value.currentVideoIndex += 1;
                                      }
                                      getVideo();
                                      value.notifyListeners();
                                      log(value.currentVideoIndex.toString());
                                    },
                                    child: Text("Next"),
                                  ),
                                  

                                Spacer(),
                                if (value
                                    .trainingdetailModel!
                                    .data!
                                    .content![value.currentVideoIndex]
                                    .cmReadingMaterial!
                                    .isNotEmpty)
                                  LargeButton(
                                    height: 40,
                                    width: 100,
                                    onPressed: () {
                                      Get.to(
                                        PdfViewerScreen(
                                          filename: value
                                              .trainingdetailModel!
                                              .data!
                                              .content![value.currentVideoIndex]
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
                            
                          ],
                        ),
                        // child: ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   itemBuilder: (context, i) {
                        //     var data = value.trainingdetailModel?.data?.content?[i];
                        //     return Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 10),
                        //       child: Text(
                        //         data!.cmContentTitle!,
                        //         style: FontStyleUtilities.h6(
                        //           fontWeight: FWT.medium,
                        //           fontColor: (value.currentVideoIndex == i)
                        //               ? AppColors.primary
                        //               : AppColors.black,
                        //         ),
                        //       ),
                        //     );
                        //   },
                        //   itemCount: value.trainingdetailModel?.data?.content?.length,
                        // ),
                      ),
            
                      h20,
                      SizedBox(
                        width: Get.width,
                        height: 210,
                        child: (chewieController == null ||
                                !videoPlayerController.value.isInitialized)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Chewie(controller: chewieController!),
                      ),
                        if (value.currentVideoIndex == 9)
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
                                                    onPressed: () async {
                                                      primaryFocus?.unfocus();
                                                      await uploadAddBlogDialog(
                                                          context);
                                                     // blgCnt;
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
