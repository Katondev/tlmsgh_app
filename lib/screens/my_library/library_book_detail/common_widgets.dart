import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/utils/global_singlton.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/custom_dialog.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:path_provider/path_provider.dart';

class RemoveFromLibraryButton extends StatefulWidget {
  final BookDetailsM book;

  RemoveFromLibraryButton({Key? key, required this.book}) : super(key: key);

  @override
  State<RemoveFromLibraryButton> createState() =>
      _RemoveFromLibraryButtonState();
}

class _RemoveFromLibraryButtonState extends State<RemoveFromLibraryButton> {
  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            message: "remove_from_library".tr,
            title1: "no".tr,
            onFirstButtonTap: () => Navigator.of(context).pop(),
            title2: "yes".tr,
            onSecButtonTap: () async {
              Navigator.pop(context);
              await cnt.deleteData(widget.book).then(
                    (value) => setState(() {}),
                  );
            },
          ),
        );
      },
      child: Container(
        height: Responsive.isMobile(context) ? 35 : 48,
        width: Responsive.isMobile(context) ? 35 : 49,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
            border: Border.all(width: 0.69, color: AppColors.red)),
        child: Icon(Icons.close,
            size: Responsive.isMobile(context) ? 15 : 20, color: AppColors.red),
      ),
    );
  }
}

class InProgressButton extends StatelessWidget {
  const InProgressButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LargeButton(
        onPressed: () {},
        color: AppColors.nevYBlue,
        height: 40,
        width: 141,
        child: Text("in_progress".tr,
            style: FontStyleUtilities.t2(
                fontWeight: FWT.medium, fontColor: AppColors.white)));
  }
}

class DownloadButton extends StatelessWidget {
  final BookDetailsM book;

  DownloadButton({Key? key, required this.book}) : super(key: key);
  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return LargeButton(
      onPressed: () => cnt.downloadResource(context: context, book: book),
      color: AppColors.nevYBlue,
      height: 40,
      child: Text("download".tr,
          style: FontStyleUtilities.t2(
              fontWeight: FWT.medium, fontColor: AppColors.white)),
    );
  }
}

class EpubReadOrDownloadButton extends StatelessWidget {
  final BookDetailsM book;

  EpubReadOrDownloadButton({Key? key, required this.book}) : super(key: key);

  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: r18,
      child: LargeButton(
        onPressed: () async {
          cnt.onPressed(
              bookName: book.bkTitle,
              id: book.bkId!,
              context: context,
              bookItem: book.bkEpub ?? "",
              bookItem1: cnt.ePub.value,
              bookItemExist: cnt.ePubExisted.value,
              screenName: "Epub",
              epubPath: cnt.ePubPath,
              book: book);
        },
        color: AppColors.darkPink,
        height: 40,
        width: 141,
        child: Text(
          (book.bkEpub!.isNotEmpty &&
                  File("${GlobalSingleton().Dirpath}/${book.bkEpub!.split("/").last}")
                      .existsSync())
              ? "read_epub".tr
              : "download_epub".tr,
          style: FontStyleUtilities.t2(
            fontWeight: FWT.medium,
            fontColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class ViewOrDownloadVideoButton extends StatelessWidget {
  final BookDetailsM book;

  ViewOrDownloadVideoButton({Key? key, required this.book}) : super(key: key);
  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return LargeButton(
      onPressed: () async {
        cnt.onPressed(
            id: book.bkId!,
            context: context,
            bookItem: book.bkVideo ?? "",
            bookItem1: cnt.video.value,
            bookItemExist: cnt.videoExisted.value,
            screenName: "Video",
            book: book);
      },
      color: AppColors.lightRed,
      height: 40,
      width: 141,
      child: Text(
        (book.bkVideo!.isNotEmpty &&
                File("${GlobalSingleton().Dirpath}/${book.bkVideo!.split("/").last}")
                    .existsSync())
            ? "view_video".tr
            : "download_Video".tr,
        style: FontStyleUtilities.t2(
          fontWeight: FWT.medium,
          fontColor: AppColors.white,
        ),
      ),
    );
  }
}

class ViewOrDownloadPdfButton extends StatelessWidget {
  final BookDetailsM book;

  ViewOrDownloadPdfButton({Key? key, required this.book}) : super(key: key);
  final cnt = Get.put(ELearningCnt());
  // Directory? dir;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: r18,
      child: LargeButton(
        onPressed: () async {
          log(book.pdfPath.toString());
          log(File("${book.pdfPath}").existsSync().toString());
          cnt.onPressed(
              id: book.bkId!,
              context: context,
              bookItem: book.bkPdf ?? "",
              bookItem1: cnt.pdf.value,
              bookItemExist: cnt.pdfExisted.value,
              screenName: "PDF",
              book: book);
          // dir = await getApplicationDocumentsDirectory();
        },
        color: AppColors.lightGreen,
        height: 40,
        width: 141,
        child: Text(
          (book.bkPdf!.isNotEmpty &&
                  File("${GlobalSingleton().Dirpath}/${book.bkPdf!.split("/").last}")
                      .existsSync())
              ? "read_pdf".tr
              : "download_pdf".tr,
          style: FontStyleUtilities.t2(
            fontWeight: FWT.medium,
            fontColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class BookDescription extends StatelessWidget {
  final BookDetailsM book;

  const BookDescription({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Translator().translate("${book.bkDescription}"),
      builder: (context, snapshot) => Text(
        snapshot.hasData ? "${snapshot.data}" : "${book.bkDescription}",
        style: FontStyleUtilities.h6(
          fontColor: AppColors.grey500,
        ).copyWith(overflow: TextOverflow.ellipsis),
        maxLines: 4,
      ),
    );
  }
}

class BookTitle extends StatelessWidget {
  final BookDetailsM book;

  const BookTitle({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Translator().translate("${book.bkTitle}"),
      builder: (context, snapshot) => Text(
        "${book.bkTitle}",
        textAlign: TextAlign.start,
        style: FontStyleUtilities.h6(
          fontWeight: FWT.semiBold,
          fontColor: AppColors.white,
        ),
      ),
    );
  }
}
