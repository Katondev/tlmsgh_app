import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/res.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import '../../../../components/image/image_widget.dart';
import '../../../../network/api_constants.dart';
import '../../../../utils/global_singlton.dart';
import '../../../../widgets/pdf_view/pdf_view_page.dart';
import '../../../training/pdf_viewer/pdf_viewer.dart';
import '../../controller/cnt_prv.dart';
import '../../controller/elearning_cnt.dart';

class LibraryEbookWidget extends StatefulWidget {
  // final GestureTapCallback onTapDownload;
  final GestureTapCallback onTapShare;
  final BookDetailsM? book;
  final List<BookDetailsM>? booksList;
  // final String title;
  // final String bookImage;
  const LibraryEbookWidget({
    super.key,
    // required this.onTapDownload,
    required this.onTapShare,
    this.book,
    this.booksList,
  });

  @override
  State<LibraryEbookWidget> createState() => _LibraryEbookWidgetState();
}

class _LibraryEbookWidgetState extends State<LibraryEbookWidget> {
  var image;
  var imagePath;
  final cnt = Get.put(ELearningCnt());
  ELearningProvider? eLearningPrv;

  bool loading = true;

  Directory? dir;

  Future initDir() async {
    loading = true;
    // setState(() {});
    dir = await getApplicationDocumentsDirectory();
    imagePath = '${widget.book!.bkPreview}';
    if (cnt.isDownloading == true && cnt.bookId == widget.book!.bkId) {
    } else {
      cnt.ePubPath = '${dir!.path}/${widget.book!.bkEpub}';
      final savedDir = File(cnt.ePubPath!);
      cnt.ePubExisted.value = await savedDir.exists();
      // log("epub existed---${cnt.ePubExisted}---${dir!.path}/${widget.book?.bkEpub!.split("/").last}");
      if (widget.book!.bkEpub == null || widget.book!.bkEpub == "") {
        cnt.ePubExisted.value = true;
      }

      cnt.pdfPath = '${dir!.path}/${widget.book?.bkPdf}';
      final savedDir1 = File(cnt.pdfPath!);
      cnt.pdfExisted.value = await savedDir1.exists();
      // log("pdf existed---${cnt.pdfExisted}---${dir!.path}/${widget.book?.bkPdf!.split("/").last}");

      if (widget.book?.bkPdf == null || widget.book?.bkPdf == "") {
        cnt.pdfExisted.value = true;
      }

      if (File("${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}")
              .existsSync() ||
          File("${GlobalSingleton().Dirpath}/${widget.book?.bkEpub?.split("/").last}")
              .existsSync()) {
        // cnt.isDownloaded.value = true;'
        log("ddddd----1");
        if (File(
                "${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}")
            .existsSync()) {
          log("ddddd----2");

          widget.book!.isDownloadedPdf!.value = true;

          widget.book!.isDownloading!.value = false;
        }
        log("ddddd-----------------${widget.book!.isDownloadedEpub}----------${widget.book!.isDownloadedPdf}---------${widget.book!.isDownloading}");
        if (File(
                "${GlobalSingleton().Dirpath}/${widget.book?.bkEpub?.split("/").last}")
            .existsSync()) {
          widget.book!.isDownloadedEpub!.value = true;
          widget.book!.isDownloading!.value = false;
          // var dd = cnt.books.any((element) => element.isDownloadedEpub == true);
          // log("cnt--------${cnt.books}");
        }
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

      initDir();
    });
    // log("epub---${GlobalSingleton().Dirpath}/${widget.book!.bkEpub!.split("/").last}");
  }

  @override
  Widget build(BuildContext context) {
    return (Responsive.isMobilenew(context))
        ? Container(
            padding: const EdgeInsets.all(12),
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
                      child: GestureDetector(
                        onTap: (File("${GlobalSingleton().Dirpath}/${widget.book?.bkEpub?.split("/").last}")
                                    .existsSync() ||
                                File("${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}")
                                    .existsSync())
                            ? () {
                                log("message");
                              }
                            : () {
                                if (widget.book?.bkPdf != null &&
                                    widget.book?.bkEpub == null) {
                                  log("message---1");

                                  cnt.onPressedDownload(
                                    id: widget.book!.bkId!,
                                    context: context,
                                    bookItem: widget.book!.bkPdf ?? "",
                                    bookItem1: cnt.pdf.value,
                                    bookItemExist: cnt.pdfExisted.value,
                                    screenName: "PDF",
                                    book: widget.book!,
                                    booksList: widget.booksList,
                                  );
                                } else if (widget.book?.bkPdf == null &&
                                    widget.book?.bkEpub != null) {
                                  log("message---2");
                                  cnt.onPressedDownload(
                                    bookName: widget.book!.bkTitle,
                                    id: widget.book!.bkId!,
                                    context: context,
                                    bookItem: widget.book!.bkEpub ?? "",
                                    bookItem1: cnt.ePub.value,
                                    bookItemExist: cnt.ePubExisted.value,
                                    screenName: "Epub",
                                    epubPath: cnt.ePubPath,
                                    book: widget.book!,
                                    booksList: widget.booksList,
                                  );
                                } else {
                                  log("message---3");
                                  log("epub path----${cnt.pdf.value}-&&-${cnt.downloadId.value}--==--${widget.booksList?[cnt.onTapDownloadIndex.value].bkId.toString()}");
                                  log("video path----${cnt.ePub.value}-&&-${cnt.downloadId.value}--==--${widget.booksList?[cnt.onTapDownloadIndex.value].bkId.toString()}");
                                  cnt
                                      .onPressedDownload(
                                          id: widget.book!.bkId!,
                                          context: context,
                                          bookItem: widget.book!.bkPdf ?? "",
                                          bookItem1: cnt.pdf.value,
                                          bookItemExist: cnt.pdfExisted.value,
                                          screenName: "PDF",
                                          book: widget.book!,
                                          booksList: widget.booksList)
                                      .then((value) {
                                    cnt.onPressedDownload(
                                        bookName: widget.book!.bkTitle,
                                        id: widget.book!.bkId!,
                                        context: context,
                                        bookItem: widget.book!.bkEpub ?? "",
                                        bookItem1: cnt.ePub.value,
                                        bookItemExist: cnt.ePubExisted.value,
                                        screenName: "Epub",
                                        epubPath: cnt.ePubPath,
                                        book: widget.book!,
                                        booksList: widget.booksList);
                                  });
                                }
                              },
                        child: Obx(
                          () => Container(
                            height: 28,
                            width: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryWhite,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: (widget.book!.isDownloading!.value)
                                ? const CircularProgressIndicator()
                                : Image.asset(
                                    (File("${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}")
                                                .existsSync() ||
                                            File("${GlobalSingleton().Dirpath}/${widget.book?.bkEpub?.split("/").last}")
                                                .existsSync())
                                        ? AppAssets.ic_download_finish
                                        : AppAssets.ic_download,

                                    // height: 18,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //     child: Text(
                    //   "-----${widget.book!.isDownloadedPdf!.value}",
                    //   style: TextStyle(fontSize: 14, color: Colors.red),
                    // ))
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
                                    Get.to(() => PdfViewerScreen(
                                          file:
                                              "${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}",
                                          filename: "${widget.book!.bkPdf}",
                                          filetype: "Pdf",
                                          isdownloaded: File(
                                                  "${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}")
                                              .existsSync(),
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
                                    if (widget.book!.bkEpub!.isNotEmpty &&
                                        File("${GlobalSingleton().Dirpath}/${widget.book!.bkEpub!.split("/").last}")
                                            .existsSync()) {
                                      VocsyEpub.open(
                                        "${GlobalSingleton().Dirpath}/${widget.book!.bkEpub!.split("/").last}",
                                      );
                                    }
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
                      style: AppTextStyle.normalBold10
                          .copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.all(12),
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
                          onTap: (File("${GlobalSingleton().Dirpath}/${widget.book?.bkEpub?.split("/").last}")
                                      .existsSync() ||
                                  File("${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}")
                                      .existsSync())
                              ? () {
                                  print("message");
                                }
                              : () {
                                  if (widget.book?.bkPdf != null &&
                                      widget.book?.bkEpub == null) {
                                    log("message---1");

                                    cnt.onPressedDownload(
                                      id: widget.book!.bkId!,
                                      context: context,
                                      bookItem: widget.book!.bkPdf ?? "",
                                      bookItem1: cnt.pdf.value,
                                      bookItemExist: cnt.pdfExisted.value,
                                      screenName: "PDF",
                                      book: widget.book!,
                                      booksList: widget.booksList,
                                    );
                                  } else if (widget.book?.bkPdf == null &&
                                      widget.book?.bkEpub != null) {
                                    log("message---2");
                                    cnt.onPressedDownload(
                                      bookName: widget.book!.bkTitle,
                                      id: widget.book!.bkId!,
                                      context: context,
                                      bookItem: widget.book!.bkEpub ?? "",
                                      bookItem1: cnt.ePub.value,
                                      bookItemExist: cnt.ePubExisted.value,
                                      screenName: "Epub",
                                      epubPath: cnt.ePubPath,
                                      book: widget.book!,
                                      booksList: widget.booksList,
                                    );
                                  } else {
                                    log("message---3");
                                    log("epub path----${cnt.pdf.value}-&&-${cnt.downloadId.value}--==--${widget.booksList?[cnt.onTapDownloadIndex.value].bkId.toString()}");
                                    log("video path----${cnt.ePub.value}-&&-${cnt.downloadId.value}--==--${widget.booksList?[cnt.onTapDownloadIndex.value].bkId.toString()}");
                                    cnt
                                        .onPressedDownload(
                                            id: widget.book!.bkId!,
                                            context: context,
                                            bookItem: widget.book!.bkPdf ?? "",
                                            bookItem1: cnt.pdf.value,
                                            bookItemExist: cnt.pdfExisted.value,
                                            screenName: "PDF",
                                            book: widget.book!,
                                            booksList: widget.booksList)
                                        .then((value) {
                                      cnt.onPressedDownload(
                                          bookName: widget.book!.bkTitle,
                                          id: widget.book!.bkId!,
                                          context: context,
                                          bookItem: widget.book!.bkEpub ?? "",
                                          bookItem1: cnt.ePub.value,
                                          bookItemExist: cnt.ePubExisted.value,
                                          screenName: "Epub",
                                          epubPath: cnt.ePubPath,
                                          book: widget.book!,
                                          booksList: widget.booksList);
                                    });
                                  }
                                },
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryWhite,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: (widget.book!.isDownloading!.value)
                                ? const CircularProgressIndicator()
                                : Image.asset(
                                    (File("${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}")
                                                .existsSync() ||
                                            File("${GlobalSingleton().Dirpath}/${widget.book?.bkEpub?.split("/").last}")
                                                .existsSync())
                                        ? AppAssets.ic_download_finish
                                        : AppAssets.ic_download,

                                    // height: 18,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //     child: Text(
                    //   "${widget.book!.isDownloading!.value}-----${widget.book!.isDownloadedPdf!.value}\n\n\n${File("${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}").existsSync()}-----${File("${GlobalSingleton().Dirpath}/${widget.book?.bkEpub?.split("/").last}").existsSync()}----\n${widget.book?.bkPdf?.split("/").last}-------${widget.book?.bkEpub?.split("/").last}",
                    //   style: TextStyle(fontSize: 14, color: Colors.red),
                    // ))
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
                                    Get.to(() => PdfViewerScreen(
                                          file:
                                              "${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}",
                                          filename: "${widget.book!.bkPdf}",
                                          filetype: "Pdf",
                                          isdownloaded: File(
                                                  "${GlobalSingleton().Dirpath}/${widget.book?.bkPdf?.split("/").last}")
                                              .existsSync(),
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
                                    if (widget.book!.bkEpub!.isNotEmpty &&
                                        File("${GlobalSingleton().Dirpath}/${widget.book!.bkEpub!.split("/").last}")
                                            .existsSync()) {
                                      VocsyEpub.open(
                                        "${GlobalSingleton().Dirpath}/${widget.book!.bkEpub!.split("/").last}",
                                      );
                                    }
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
                      style: AppTextStyle.normalBold10
                          .copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
