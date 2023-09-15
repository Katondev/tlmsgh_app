import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/practice/assignment/controller/assignment_controller.dart';
import 'package:katon/utils/config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import '../../../../components/image/image_widget.dart';
import '../../../../network/api_constants.dart';
import '../../../../utils/global_singlton.dart';
import '../../../../widgets/pdf_view/pdf_view_page.dart';

class AssignmentWidget extends StatefulWidget {
  // final GestureTapCallback onTapDownload;
  final GestureTapCallback onTapShare;
  final BookDetailsM? book;
  final List<BookDetailsM>? booksList;
  // final String title;
  // final String bookImage;
  const AssignmentWidget({
    super.key,
    // required this.onTapDownload,
    required this.onTapShare,
    this.book,
    this.booksList,
  });

  @override
  State<AssignmentWidget> createState() => _AssignmentWidgetState();
}

class _AssignmentWidgetState extends State<AssignmentWidget> {
  var image;
  var imagePath;
  AssignmentController? assignPrv;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      assignPrv = Provider.of<AssignmentController>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        border: Border.all(color: AppColors.boxborderColor),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 135,
                width: Get.width,
                color: AppColors.primaryYellow.withOpacity(.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.network(
                    //   bookImage,
                    //   height: 110,
                    // ),
                    NetworkImageWidget(
                      height: 110,
                      width: 80,
                      fit: BoxFit.fill,
                      imageUrl:
                          "${ApiRoutes.imageURL}${widget.book!.bkPreview}",
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Obx(
                  () => GestureDetector(
                    onTap: () {
                      log("message");
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryWhite,
                      ),
                      padding: EdgeInsets.all(5),
                      child: (widget.book!.isDownloading!.value)
                          ? CircularProgressIndicator()
                          : Image.asset(
                              ((widget.book!.isDownloadedPdf!.value &&
                                          File("${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}")
                                              .existsSync()) ||
                                      (widget.book!.isDownloadedEpub!.value &&
                                          File("${GlobalSingleton().Dirpath}/${widget.book?.bkEpub?.split("/").last}")
                                              .existsSync()))
                                  ? AppAssets.ic_download_finish
                                  : AppAssets.ic_download,

                              // height: 18,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          h12,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //     "${cnt.pdf.value}---${cnt.downloadId.value}----${widget.booksList?[cnt.onTapDownloadIndex.value].bkId.toString()}"),

                    Row(
                      children: [
                        if (widget.book!.isDownloadedPdf!.value)
                          GestureDetector(
                            onTap: () {
                              Get.to(() => PDFViewPage(
                                    filename: "${widget.book!.bkPdf}",
                                    isFrom: true,
                                  ));
                            },
                            child: Image.asset(
                              AppAssets.ic_pdf,
                              height: 16,
                              // color: AppColors.textFieldhintColor,
                            ),
                          ),
                        if (widget.book!.isDownloadedPdf!.value) w10,
                        if (widget.book!.isDownloadedEpub!.value)
                          GestureDetector(
                            onTap: () {
                              VocsyEpub.open(
                                widget.book!.ePubPath!,
                              );
                            },
                            child: Image.asset(
                              AppAssets.ic_epub,
                              height: 18,
                              // color: AppColors.textFieldhintColor,
                            ),
                          ),
                      ],
                    ),
                    GestureDetector(
                      onTap: widget.onTapShare,
                      child: Image.asset(
                        AppAssets.ic_share,
                        height: 14,
                      ),
                    ),
                  ],
                ),
              ),
              h6,
              Text(
                "${widget.book!.bkTitle}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    AppTextStyle.normalBold10.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
