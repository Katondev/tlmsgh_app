import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/screens/my_library/widgets/video_player.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/global_singlton.dart';
import 'package:provider/provider.dart';
import '../../../../components/app_text_style.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../book_detail/widget/library_video_widget.dart';
import '../controller/cnt_prv.dart';

class LibraryVideoMobile extends StatefulWidget {
  final Arguments arguments;
  const LibraryVideoMobile({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<LibraryVideoMobile> createState() => _LibraryVideoMobileState();
}

class _LibraryVideoMobileState extends State<LibraryVideoMobile> {
  ELearningProvider? eLearningPrv;
  final cnt = Get.put(ELearningCnt());
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

    return Scaffold(
      // endDrawer: endDrawer(),
      backgroundColor: AppColors.boxgreyColor,
      body: SafeArea(
        child: Consumer<ELearningProvider>(builder: (context, ePrv, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonAppBar2(
                  isshowback: true,
                  title: args.toString(),
                  description: widget.arguments.description,
                ),
                customHeight(15),
                Expanded(
                  child: ePrv.value
                      ? Loader(message: "loading_wait".tr)
                      : ePrv.connection
                          ? (ePrv.offlinevideobooks.isEmpty)
                              ? NoDataFound(message: "no_book_found".tr)
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
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
                                                  key: ValueKey(i.toString()),
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: dd.data?.length,
                                                  itemBuilder: (context,
                                                      horizontalIndex) {
                                                    var data = dd
                                                        .data?[horizontalIndex];
                                                    return LibraryVideoWidget(
                                                      onTap:
                                                          (File("${GlobalSingleton().Dirpath}/${data?.bkVideo?.split("/").last}")
                                                                  .existsSync())
                                                              ? () {
                                                                  log("message");
                                                                  Get.to(Video(
                                                                    title: data
                                                                        ?.bkVideo,
                                                                  ));
                                                                }
                                                              : () {
                                                                  eLearningPrv
                                                                      ?.currentlabelIndex = i;
                                                                  eLearningPrv
                                                                          ?.currentVideoIndex =
                                                                      horizontalIndex;
                                                                  print(
                                                                      "index--------------------------------${eLearningPrv?.currentlabelIndex}");
                                                                },
                                                      onTapDownload: () {
                                                        log("message");
                                                        Get.to(Video(
                                                          title: data?.bkVideo,
                                                        ));
                                                      },
                                                      book: data,
                                                      booksList: dd.data,
                                                    );
                                                  },
                                                ),
                                              ),
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
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    var dd = ePrv.videobooks[i];
                                    return (dd.data!.isEmpty)
                                        ? const SizedBox()
                                        : Column(
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
                                                            const BouncingScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            dd.data?.length,
                                                        itemBuilder: (context,
                                                            horizontalIndex) {
                                                          var data = dd.data?[
                                                              horizontalIndex];
                                                          return Obx(
                                                            () =>
                                                                LibraryVideoWidget( 

                                                              onTap: (GlobalSingleton()
                                                                      .downloadedvideobookIdList
                                                                      .any((e) =>
                                                                          e ==
                                                                          data?.bkId))
                                                                          
                                                                  ? () {
                                                                      log("message");
                                                                      Get.to(
                                                                          Video(
                                                                        title: data
                                                                            ?.bkVideo,
                                                                      ));
                                                                    }
                                                                  : () {
                                                            Get.to(Video(
                                                          title: data?.bkVideo,
                                                        ));
                                                                      eLearningPrv
                                                                          ?.currentlabelIndex = i;
                                                                      eLearningPrv
                                                                              ?.currentVideoIndex =
                                                                          horizontalIndex;
                                                                      print(
                                                                          "index--------------------------------${GlobalSingleton().downloadedvideobookIdList}");
                                                                    },
                                                              onTapDownload: (GlobalSingleton()
                                                                      .downloadedvideobookIdList
                                                                      .any((e) =>
                                                                          e ==
                                                                          data?.bkId))
                                                                  ? () {
                                                                      log("message");
                                                                      Get.to(
                                                                          Video(
                                                                        title: data
                                                                            ?.bkVideo,
                                                                      ));
                                                                    }
                                                                  : () {
                                                                      log("message---1");
                                                        Get.to(Video(
                                                          title: data?.bkVideo,
                                                        ));
                                                                      eLearningPrv
                                                                          ?.currentlabelIndex = i;
                                                                      eLearningPrv
                                                                              ?.currentVideoIndex =
                                                                          horizontalIndex;

                                                                      cnt.onPressedDownload(
                                                                        id: data!
                                                                            .bkId!,
                                                                        context:
                                                                            context,
                                                                        bookItem:
                                                                            data.bkVideo ??
                                                                                "",
                                                                        bookItem1: cnt
                                                                            .video
                                                                            .value,
                                                                        bookItemExist: cnt
                                                                            .videoExisted
                                                                            .value,
                                                                        screenName:
                                                                            "Video",
                                                                        videobook:
                                                                            data,
                                                                        videoBookList:
                                                                            dd.data,
                                                                        labelindex:
                                                                            eLearningPrv?.currentlabelIndex,
                                                                        videoindex:
                                                                            eLearningPrv?.currentVideoIndex,
                                                                      );
                                                                    },
                                                              book: data,
                                                              booksList:
                                                                  dd.data!,
                                                            ),
                                                          );
                                                          // return Container(
                                                          //   height: 100,
                                                          //   width: Get.width,
                                                          //   margin:
                                                          //       EdgeInsets.only(
                                                          //           right: 10),
                                                          //   color: AppColors
                                                          //       .appbarRed,
                                                          // );
                                                        },
                                                      ),
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
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
