import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/my_library/widgets/video_player.dart';
import 'package:katon/utils/config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../../components/image/image_widget.dart';
import '../../../../models/video_books_model.dart';
import '../../../../network/api_constants.dart';
import '../../../../utils/global_singlton.dart';
import '../../controller/cnt_prv.dart';
import '../../controller/elearning_cnt.dart';

class LibraryVideoWidget extends StatefulWidget {
  // final GestureTapCallback onTapDownload;
  final GestureTapCallback onTap;
  final GestureTapCallback onTapDownload;
  final VideoBooksData? book;
  final List<VideoBooksData>? booksList;
  // final String title;
  // final String bookImage;
  const LibraryVideoWidget({
    super.key,
    // required this.onTapDownload,
    required this.onTap,
    this.book,
    this.booksList,
    required this.onTapDownload,
  });

  @override
  State<LibraryVideoWidget> createState() => _LibraryVideoWidgetState();
}

class _LibraryVideoWidgetState extends State<LibraryVideoWidget> {
  var image;
  var imagePath;
  final cnt = Get.put(ELearningCnt());
  ELearningProvider? eLearningPrv;

  bool loading = true;

  Directory? dir;

  Future initDir() async {
    loading = true;
    // print(
    //     "data-----------12-------------${GlobalSingleton().globalVideoData[widget.index].isDownloadedVideo.value.toString()}-------${widget.index}");
    // setState(() {});
    dir = await getApplicationDocumentsDirectory();
    imagePath = '${widget.book!.bkPreview}';
    if (cnt.isDownloading == true && cnt.bookId == widget.book!.bkId) {
    } else {
      cnt.videoPath = '${dir!.path}/${widget.book!.bkVideo}';
      final savedDir = File(cnt.videoPath!);
      cnt.videoExisted.value = await savedDir.exists();
      // log("epub existed---${cnt.videoExisted.value}---${dir!.path}/${widget.book?.bkVideo!.split("/").last}");
      if (widget.book!.bkVideo == null || widget.book!.bkVideo == "") {
        cnt.videoExisted.value = true;
      }

      if (File(
              "${GlobalSingleton().Dirpath}/${widget.book?.bkVideo?.split("/").last}")
          .existsSync()) {
        // cnt.isDownloaded.value = true;'
        widget.book!.isDownloadedVideo.value = true;
        // widget.book!.isDownloadingVideo.value = false;
      }
    }
    loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eLearningPrv = Provider.of<ELearningProvider>(context, listen: false);
    });
    initDir();
    log("video------book-----${widget.book!.bkTitle}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 220,
        // height: 150,
        margin: const EdgeInsets.only(right: 14),
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Stack(
              children: [
                NetworkImageWidget(
                  height: 125,
                  width: 220,
                  borderRadius: BorderRadius.circular(10),
                  fit: BoxFit.cover,
                  imageUrl: "${ApiRoutes.imageURL}${widget.book!.bkPreview}",
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: GestureDetector(
                    onTap: widget.onTapDownload,
                    child: Obx(
                      () => Container(
                        height: 28,
                        width: 28,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryWhite,
                        ),
                        padding: EdgeInsets.all(
                            (File("${GlobalSingleton().Dirpath}/${widget.book?.bkVideo?.split("/").last}")
                                    .existsSync())
                                ? 8
                                : 5),
                        child:
                            // (widget.book!.isDownloadingVideo.value &&
                            //         cnt.video.value &&
                            //         cnt.isDownloading)
                            (GlobalSingleton()
                                    .videobookIdList
                                    .any((e) => e == widget.book!.bkId))
                                ? const CircularProgressIndicator()
                                : (File("${GlobalSingleton().Dirpath}/${widget.book?.bkVideo?.split("/").last}")
                                        .existsSync())
                                    ? Image.asset(
                                        AppAssets.ic_play,
                                        height: 18,
                                        color: AppColors.green,
                                      )
                                    : Image.asset(
                                        AppAssets.ic_download,

                                        // height: 18,
                                        color: AppColors.gray909090,
                                      ),
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //     child: Text(
                //         "${GlobalSingleton().bookIdList.any((e) => e == widget.book!.bkId)}\n${widget.book!.isDownloadingVideo.value}")),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  // top: 10,
                  child: Container(
                    width: Get.width,
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppAssets.ic_play_outline,
                          height: 12,
                        ),
                        const Spacer(),
                        Text(
                          "5:00",
                          style: AppTextStyle.normalRegular12.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryWhite),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            h4,
            Text(
              "${widget.book!.bkTitle}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.normalBold10
                  .copyWith(color: AppColors.primaryBlack),
            ),
          ],
        ),
      ),
    );
  }
}
