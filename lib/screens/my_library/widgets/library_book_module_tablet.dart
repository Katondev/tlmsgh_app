import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/screens/library_page/book_detail/widget/book_item_module/common_widgets.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/screens/my_library/library_book_detail/common_widgets.dart';
import 'package:katon/screens/my_library/widgets/common_reviews.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_widgets.dart';
import 'package:katon/widgets/svgIcon.dart';

import '../../../network/api_constants.dart';

class LibraryBookModuleTablet extends StatelessWidget {
  final BookDetailsM book;
  final String imagePath;

  LibraryBookModuleTablet(
      {Key? key, required this.book, required this.imagePath})
      : super(key: key);
  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ELearningCnt>(builder: (cont) {
      return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryYellow,
            borderRadius: cr24,
          ),
          width: 670,
          child: Column(
            children: [
              h16,
              Padding(
                padding: l40,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: BookTitle(book: cnt.books[cnt.onTapSelectedIndex!]),
                ),
              ),
              h16,
              Expanded(
                child: Container(
                  margin: b10l10r10,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: cr24,
                  ),
                  child: Padding(
                    padding: l20r15t25b40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: t15,
                              height: 196,
                              width: 244.31,
                              color: AppColors.white,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  SvgIcon(Images.round2,
                                      height: 102, width: 244.31),
                                  Positioned(
                                    bottom: 35,
                                    child: CachedNetworkImage(
                                      height: 162,
                                      width: 114,
                                      imageUrl:
                                          "${ApiRoutes.imageURL}${cnt.books[cnt.onTapSelectedIndex!].bkPreview}",
                                    ),

                                    //  Image.file(
                                    //   File(imagePath),
                                    //   errorBuilder: (BuildContext context,
                                    //       Object exception,
                                    //       StackTrace? stackTrace) {
                                    //     return Container();
                                    //   },
                                    //   height: 162,
                                    //   width: 70,
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                            w20,
                            Padding(
                              padding: t15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 295,
                                      child: BookGenreText(book: book)),
                                  Text(
                                      "${"pages".tr} ${cnt.books[cnt.onTapSelectedIndex!].bkNoOfPages}",
                                      style: FontStyleUtilities.h6(
                                              height: 0,
                                              fontColor: AppColors.grey500)
                                          .copyWith(
                                              overflow: TextOverflow.visible)),
                                  h20,
                                  RatingStars(), //Rating Stars
                                  h16,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          cnt.books[cnt.onTapSelectedIndex!]
                                                          .bkPdf !=
                                                      null &&
                                                  cnt
                                                          .books[cnt
                                                              .onTapSelectedIndex!]
                                                          .bkPdf !=
                                                      ""
                                              ? cnt.pdf.value &&
                                                      cnt.downloadId ==
                                                          cnt
                                                              .books[cnt
                                                                  .onTapSelectedIndex!]
                                                              .bkId
                                                              .toString()
                                                  ? InProgressButton()
                                                  : ViewOrDownloadPdfButton(
                                                      book: cnt.books[cnt
                                                          .onTapSelectedIndex!])
                                              : const SizedBox(),
                                        ],
                                      ),
                                      h10,
                                      Row(
                                        children: [
                                          cnt.books[cnt.onTapSelectedIndex!]
                                                          .bkEpub !=
                                                      null &&
                                                  cnt
                                                          .books[cnt
                                                              .onTapSelectedIndex!]
                                                          .bkEpub !=
                                                      ""
                                              ? cnt.ePub.value &&
                                                      cnt.downloadId ==
                                                          cnt
                                                              .books[cnt
                                                                  .onTapSelectedIndex!]
                                                              .bkId
                                                              .toString()
                                                  ? InProgressButton()
                                                  : EpubReadOrDownloadButton(
                                                      book: cnt.books[cnt
                                                          .onTapSelectedIndex!])
                                              : const SizedBox(),
                                          cnt.books[cnt.onTapSelectedIndex!]
                                                          .bkVideo !=
                                                      null &&
                                                  cnt
                                                          .books[cnt
                                                              .onTapSelectedIndex!]
                                                          .bkVideo !=
                                                      ""
                                              ? cnt.video.value &&
                                                      cnt.downloadId ==
                                                          cnt
                                                              .books[cnt
                                                                  .onTapSelectedIndex!]
                                                              .bkId
                                                              .toString()
                                                  ? InProgressButton()
                                                  : ViewOrDownloadVideoButton(
                                                      book: cnt.books[cnt
                                                          .onTapSelectedIndex!])
                                              : const SizedBox()
                                        ],
                                      ),
                                    ],
                                  ),
                                  // cnt.isDownloading &&
                                  //         cnt.bookId ==
                                  //             cnt.books[cnt.onTapSelectedIndex!].bkId
                                  //                 .toString()
                                  //     ? InProgressButton()
                                  //     : cnt.books[cnt.onTapSelectedIndex!].videoPath!
                                  //                 .isEmpty &&
                                  //             cnt.books[cnt.onTapSelectedIndex!].pdfPath!
                                  //                     .isEmpty ==
                                  //                 false &&
                                  //             cnt.books[cnt.onTapSelectedIndex!].ePubPath!
                                  //                     .isEmpty ==
                                  //                 false
                                  //         ? DownloadButton(
                                  //             book: cnt.books[cnt.onTapSelectedIndex!])
                                  //         : Column(
                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                  //             children: [
                                  //               Row(
                                  //                 children: [
                                  //                   cnt.books[cnt.onTapSelectedIndex!]
                                  //                                   .bkPdf !=
                                  //                               null &&
                                  //                           cnt.books[cnt.onTapSelectedIndex!]
                                  //                                   .bkPdf !=
                                  //                               ""
                                  //                       ? cnt.pdf &&
                                  //                               cnt.downloadId ==
                                  //                                   cnt
                                  //                                       .books[cnt
                                  //                                           .onTapSelectedIndex!]
                                  //                                       .bkId
                                  //                                       .toString()
                                  //                           ? InProgressButton()
                                  //                           : ViewOrDownloadPdfButton(
                                  //                               book: cnt.books[
                                  //                                   cnt.onTapSelectedIndex!])
                                  //                       : const SizedBox(),
                                  //                 ],
                                  //               ),
                                  //               h10,
                                  //               Row(
                                  //                 children: [
                                  //                   cnt.books[cnt.onTapSelectedIndex!]
                                  //                                   .bkEpub !=
                                  //                               null &&
                                  //                           cnt.books[cnt.onTapSelectedIndex!]
                                  //                                   .bkEpub !=
                                  //                               ""
                                  //                       ? cnt.ePub == true &&
                                  //                               cnt.downloadId ==
                                  //                                   cnt
                                  //                                       .books[cnt
                                  //                                           .onTapSelectedIndex!]
                                  //                                       .bkId
                                  //                                       .toString()
                                  //                           ? InProgressButton()
                                  //                           : EpubReadOrDownloadButton(
                                  //                               book: cnt.books[
                                  //                                   cnt.onTapSelectedIndex!])
                                  //                       : const SizedBox(),
                                  //                   cnt.books[cnt.onTapSelectedIndex!]
                                  //                                   .bkVideo !=
                                  //                               null &&
                                  //                           cnt.books[cnt.onTapSelectedIndex!]
                                  //                                   .bkVideo !=
                                  //                               ""
                                  //                       ? cnt.downloadId ==
                                  //                               cnt
                                  //                                   .books[cnt
                                  //                                       .onTapSelectedIndex!]
                                  //                                   .bkId
                                  //                                   .toString()
                                  //                           ? InProgressButton()
                                  //                           : ViewOrDownloadVideoButton(
                                  //                               book: cnt.books[
                                  //                                   cnt.onTapSelectedIndex!])
                                  //                       : const SizedBox()
                                  //                 ],
                                  //               ),
                                  //   ],
                                  // ),
                                  // Text(
                                  //     "${File("/data/user/0/com.katon.student/app_flutter/${cnt.books[cnt.onTapSelectedIndex!].bkVideo!.split("/").last}").existsSync().toString()}"),
                                  // Text(
                                  //     "${cnt.books[cnt.onTapSelectedIndex!].bkPdf}"),
                                ],
                              ),
                            ),
                            RemoveFromLibraryButton(
                                book: cnt.books[cnt.onTapSelectedIndex!]),
                          ],
                        ),
                        h26,
                        SizedBox(
                          height: 100,
                          child: BookDescription(
                              book: cnt.books[cnt.onTapSelectedIndex!]),
                        ),
                        h18,
                        CommonReviews(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
