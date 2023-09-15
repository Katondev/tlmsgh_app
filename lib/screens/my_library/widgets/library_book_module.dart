import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/screens/my_library/widgets/library_book_module_mobile.dart';
import 'package:katon/screens/my_library/widgets/library_book_module_tablet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/loader.dart';
import 'package:path_provider/path_provider.dart';

class LibraryBookModule extends StatefulWidget {
  final BookDetailsM book;

  const LibraryBookModule({Key? key, required this.book}) : super(key: key);

  @override
  State<LibraryBookModule> createState() => _LibraryBookModuleState();
}

class _LibraryBookModuleState extends State<LibraryBookModule> {
  var image;
  var imagePath;
  final cnt = Get.put(ELearningCnt());

  bool loading = true;

  Directory? dir;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future init() async {
    loading = true;
    setState(() {});
    dir = await getApplicationDocumentsDirectory();
    imagePath = '${widget.book.bkPreview}';
    if (cnt.isDownloading == true && cnt.bookId == widget.book.bkId) {
    } else {
      cnt.ePubPath = '${dir!.path}/${widget.book.bkEpub}';
      final savedDir = File(cnt.ePubPath!);
      cnt.ePubExisted.value = await savedDir.exists();

      if (widget.book.bkEpub == null || widget.book.bkEpub == "") {
        cnt.ePubExisted.value = true;
      }

      cnt.pdfPath = '${dir!.path}/${widget.book.bkPdf}';
      final savedDir1 = File(cnt.pdfPath!);
      cnt.pdfExisted.value = await savedDir1.exists();
      log("pdf existed---${cnt.pdfExisted}");

      if (widget.book.bkPdf == null || widget.book.bkPdf == "") {
        cnt.pdfExisted.value = true;
      }
      cnt.videoPath = '${dir!.path}/${widget.book.bkVideo}';
      final savedDir2 = File(cnt.videoPath!);
      cnt.videoExisted.value = await savedDir2.exists();

      if (widget.book.bkVideo == null || widget.book.bkVideo == "") {
        cnt.videoExisted.value = true;
      }
      print("Video Exist  ${cnt.videoExisted}");
      print("Video File Name: ${widget.book.bkVideo}");
    }
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loader(
        message: "loading".tr,
      );
    }
    return Responsive.isMobile(context)
        ? LibraryBookModuleMobile(book: widget.book, imagePath: imagePath)
        : LibraryBookModuleTablet(book: widget.book, imagePath: imagePath);
  }
}
