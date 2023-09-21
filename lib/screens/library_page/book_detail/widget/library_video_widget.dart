import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/my_library/widgets/video_player.dart';
import 'package:katon/utils/config.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../components/image/image_widget.dart';
import '../../../../models/video_books_model.dart';
import '../../../../network/api_constants.dart';
import '../../../../utils/global_singlton.dart';
import '../../controller/elearning_cnt.dart';

class LibraryVideoWidget extends StatefulWidget {
  // final GestureTapCallback onTapDownload;
  final GestureTapCallback onTapShare;
  final VideoBooksData? book;
  final List<VideoBooksData>? booksList;
  // final String title;
  // final String bookImage;
  const LibraryVideoWidget({
    super.key,
    // required this.onTapDownload,
    required this.onTapShare,
    this.book,
    this.booksList,
  });

  @override
  State<LibraryVideoWidget> createState() => _LibraryVideoWidgetState();
}

class _LibraryVideoWidgetState extends State<LibraryVideoWidget> {
  var image;
  var imagePath;
  final cnt = Get.put(ELearningCnt());

  bool loading = true;

  Directory? dir;

  Future initDir() async {
    loading = true;
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
        widget.book!.isDownloadingVideo.value = false;
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
    initDir();
    log("video------book-----${widget.book!.bkTitle}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          (File("${GlobalSingleton().Dirpath}/${widget.book?.bkVideo?.split("/").last}")
                  .existsSync())
              ? () {
                  log("message");
                  Get.to(Video(
                    title: widget.book?.bkVideo,
                  ));
                }
              : () {},
      child: Container(
        width: 220,
        // height: 150,
        margin: EdgeInsets.only(right: 14),
        decoration: BoxDecoration(),
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
                    onTap: (widget.book!.isDownloadedVideo.value)
                        ? () {
                            log("message");
                            Get.to(Video(
                              title: widget.book?.bkVideo,
                            ));
                          }
                        : () {
                            log("message---1");

                            cnt.onPressedDownload(
                              id: widget.book!.bkId!,
                              context: context,
                              bookItem: widget.book!.bkVideo ?? "",
                              bookItem1: cnt.video.value,
                              bookItemExist: cnt.videoExisted.value,
                              screenName: "Video",
                              videobook: widget.book!,
                              videoBookList: widget.booksList,
                            );
                          },
                    child: Obx(
                      () => Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryWhite,
                        ),
                        padding: EdgeInsets.all(
                            (File("${GlobalSingleton().Dirpath}/${widget.book?.bkVideo?.split("/").last}")
                                        .existsSync() &&
                                    !widget.book!.isDownloadingVideo.value)
                                ? 8
                                : 5),
                        child:
                            // (widget.book!.isDownloadingVideo.value &&
                            //         cnt.video.value &&
                            //         cnt.isDownloading)
                            (widget.book!.isDownloadingVideo.value)
                                ? CircularProgressIndicator()
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
                //     child:
                //         Text(widget.book!.isDownloadingVideo!.value.toString())),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  // top: 10,
                  child: Container(
                    width: Get.width,
                    height: 20,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
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
                        Spacer(),
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
