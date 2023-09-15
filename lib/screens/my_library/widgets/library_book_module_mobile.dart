import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/library_page/book_detail/widget/book_item_module/common_widgets.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/screens/my_library/library_book_detail/common_widgets.dart';
import 'package:katon/screens/my_library/widgets/common_reviews.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_widgets.dart';
import 'package:katon/widgets/svgIcon.dart';

import 'add_reviews.dart';

class LibraryBookModuleMobile extends StatelessWidget {
  final BookDetailsM book;
  final String imagePath;

  LibraryBookModuleMobile(
      {Key? key, required this.book, required this.imagePath})
      : super(key: key);
  final cnts = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ELearningCnt>(
      builder: (cnt) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primaryYellow,
            borderRadius: cr24,
          ),
          width: 670,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              h16,
              Padding(
                padding: l10,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BookTitle(book: cnt.books[cnt.onTapSelectedIndex!]),
                ),
              ),
              h16,
              Container(
                // height: 600,
                margin: b10l10r10,
                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: cr24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              color: AppColors.white,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  SvgIcon(
                                    Images.round2,
                                    height: 102,
                                    width: 244.31,
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    child: CachedNetworkImage(
                                      height: 162,
                                      width: 70,
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
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RemoveFromLibraryButton(book: book),
                            Padding(
                              padding: t15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: Get.width / 3,
                                      child: BookGenreText(
                                          book: cnt
                                              .books[cnt.onTapSelectedIndex!])),
                                  book.bkNoOfPages == null
                                      ? SizedBox.shrink()
                                      : SizedBox(
                                          width: Get.width / 3,
                                          child: Text(
                                            "${"pages".tr} ${cnt.books[cnt.onTapSelectedIndex!].bkNoOfPages}",
                                            style: FontStyleUtilities.h6(
                                                    height: 0,
                                                    fontColor:
                                                        AppColors.grey500)
                                                .copyWith(
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                        ),
                                  h20,
                                  RatingStars(), // Rating stars
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: 150,
                    //       width: 150,
                    //       color: AppColors.white,
                    //       child: Stack(
                    //         alignment: Alignment.bottomCenter,
                    //         children: [
                    //           SvgIcon(
                    //             Images.round2,
                    //             height: 102,
                    //             width: 244.31,
                    //           ),
                    //           Positioned(
                    //             bottom: 10,
                    //             child: CachedNetworkImage(
                    //               height: 162,
                    //               width: 70,
                    //               imageUrl:
                    //                   "${ApiRoutes.imageURL}${book.bkPreview}",
                    //             ),

                    //             //  Image.file(
                    //             //   File(imagePath),
                    //             //   errorBuilder: (BuildContext context,
                    //             //       Object exception,
                    //             //       StackTrace? stackTrace) {
                    //             //     return Container();
                    //             //   },
                    //             //   height: 162,
                    //             //   width: 70,
                    //             // ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     w20,
                    //     // Padding(
                    //     //   padding: t15,
                    //     //   child: Column(
                    //     //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     //     children: [
                    //     //       SizedBox(
                    //     //           width: Get.width / 3,
                    //     //           child: BookGenreText(
                    //     //               book: cnt
                    //     //                   .books[cnt.onTapSelectedIndex!])),
                    //     //       book.bkNoOfPages == null
                    //     //           ? SizedBox.shrink()
                    //     //           : SizedBox(
                    //     //               width: Get.width / 3,
                    //     //               child: Text(
                    //     //                 "${"pages".tr} ${cnt.books[cnt.onTapSelectedIndex!].bkNoOfPages}",
                    //     //                 style: FontStyleUtilities.h6(
                    //     //                         height: 0,
                    //     //                         fontColor: AppColors.grey500)
                    //     //                     .copyWith(
                    //     //                   overflow: TextOverflow.visible,
                    //     //                 ),
                    //     //               ),
                    //     //             ),
                    //     //       h20,
                    //     //       RatingStars(), // Rating stars
                    //     //     ],
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                    h16,
                    // cnt.isDownloading &&
                    //         cnt.bookId ==
                    //             cnt.books[cnt.onTapSelectedIndex!].bkId
                    //                 .toString()
                    //     ? InProgressButton()
                    // : cnt.books[cnt.onTapSelectedIndex!].videoPath!
                    //             .isEmpty &&
                    //         cnt.books[cnt.onTapSelectedIndex!].pdfPath!
                    //                 .isEmpty ==
                    //             false &&
                    //         cnt.books[cnt.onTapSelectedIndex!].ePubPath!
                    //                 .isEmpty ==
                    //             false
                    //     ? DownloadButton(
                    //         book: cnt.books[cnt.onTapSelectedIndex!])
                    // :
                    // Text(
                    //     "${File("${GlobalSingleton().Dirpath}/${cnt.books[cnt.onTapSelectedIndex!].bkPdf!.split("/").last}")}"),
                    // Text("${cnt.books[cnt.onTapSelectedIndex!].bkVideo}"),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            cnt.books[cnt.onTapSelectedIndex!].bkPdf != null &&
                                    cnt.books[cnt.onTapSelectedIndex!].bkPdf !=
                                        ""
                                ? cnt.pdf.value &&
                                        cnt.downloadId ==
                                            cnt.books[cnt.onTapSelectedIndex!]
                                                .bkId
                                                .toString()
                                    ? InProgressButton()
                                    : ViewOrDownloadPdfButton(
                                        book:
                                            cnt.books[cnt.onTapSelectedIndex!])
                                : const SizedBox(),
                          ],
                        ),
                        h10,
                        Row(
                          children: [
                            cnt.books[cnt.onTapSelectedIndex!].bkEpub != null &&
                                    cnt.books[cnt.onTapSelectedIndex!].bkEpub !=
                                        ""
                                ? cnt.ePub.value &&
                                        cnt.downloadId ==
                                            cnt.books[cnt.onTapSelectedIndex!]
                                                .bkId
                                                .toString()
                                    ? InProgressButton()
                                    : EpubReadOrDownloadButton(
                                        book:
                                            cnt.books[cnt.onTapSelectedIndex!])
                                : const SizedBox(),
                            cnt.books[cnt.onTapSelectedIndex!].bkVideo !=
                                        null &&
                                    cnt.books[cnt.onTapSelectedIndex!]
                                            .bkVideo !=
                                        ""
                                ? cnt.video.value &&
                                        cnt.downloadId ==
                                            cnt.books[cnt.onTapSelectedIndex!]
                                                .bkId
                                                .toString()
                                    ? InProgressButton()
                                    : ViewOrDownloadVideoButton(
                                        book:
                                            cnt.books[cnt.onTapSelectedIndex!])
                                : const SizedBox()
                          ],
                        ),
                      ],
                    ),
                    h24,
                    BookDescription(book: cnt.books[cnt.onTapSelectedIndex!]),
                    h18,
                    AddReviews(),
                    h18,
                    CommonReviews()
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
