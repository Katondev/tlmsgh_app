import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/widgets/custom_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';

import '../models/video_books_model.dart';
import '../utils/global_singlton.dart';

class DownloadGeoJsonFile {
  final cnt = Get.put(ELearningCnt());

  Future downloadFile({
    required String url,
    required String filename,
    bool? isLoading,
    bool? isLoadingType,
    BookDetailsM? book,
    VideoBooksData? videobook,
    bool? isFrom = false,
    bool? isshowSnackbar = false,
    String? fileType,
    Function(String)? uploadprogress,
  }) async {
    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    print("\n==================  Url===================\n");
    print(url.toString());

    print("\n==================  Url1===================\n");

    String path = "";
    var tempDir = await getTemporaryDirectory();
    // if (filename.toLowerCase().contains('mp4')) {
    //   // path = "video.mp4";
    //   path = filename;
    // } else {
    path = filename;
    // }
    String fullPath = '';
    var iosPath =
        "${(await getApplicationDocumentsDirectory()).path}/Download" +
            "/${fileType}_${path.split("/").last}";
    var androidPath = "/storage/emulated/0/Download/Katon" +
        "/${fileType}_${path.split("/").last}";
    if (filename.toLowerCase().contains('.epub')) {
      fullPath = "${dir.path}/${path.split("/").last}";
    } else {
      tempDir = await getApplicationDocumentsDirectory();
      if (isshowSnackbar!) {
        if (Platform.isAndroid) {
          fullPath = androidPath;
        } else if (Platform.isIOS) {
          fullPath = iosPath;
        }
      } else {
        fullPath = tempDir.path + "/${path.split("/").last}";
      }
      log("---fullpath----${fullPath.toString()}");
    }

    print('full path ${fullPath}');
    try {
      cnt.isLoading.value = true;
      if (videobook != null || book != null) {
        if (fileType == "Video" &&
            !File("${GlobalSingleton().Dirpath}/${book?.bkVideo?.split("/").last}")
                .existsSync()) {
          SnackBarService().showSnackBar(
              message: "Video downloading...", type: SnackBarType.success);
          // book!.isDownloadingVideo!.value = true;
          videobook!.isDownloadingVideo.value = true;
          log("file Type---${fileType}------${videobook.isDownloadingVideo.value}-------");
        } else if ((fileType == "Pdf" &&
                !File("${GlobalSingleton().Dirpath}/${book?.bkPdf?.split("/").last}")
                    .existsSync()) ||
            (fileType == "Epub" &&
                !File("${GlobalSingleton().Dirpath}/${book?.bkVideo?.split("/").last}")
                    .existsSync())) {
          SnackBarService().showSnackBar(
              message: "Book resource downloading...",
              type: SnackBarType.success);
          book!.isDownloading!.value = true;
          log("file Type---${fileType}------${book.isDownloading!.value}-------");
        }
      }

      cnt.update();
      print("\n==================  Start New Download ===================\n");

      await dio.download(url.toString(), "${fullPath}",
          onReceiveProgress: (rec, total) {
        String percentage = (rec / total * 100).toStringAsFixed(2);
        if (videobook != null || book != null) {
          if (fileType == "Video") {
            videobook!.isDownloadingVideo.value = true;
          } else {
            book!.isDownloading!.value = true;
          }
        }
        final progress =
            "$rec Bytes of ” “$total Bytes - $percentage % uploaded";
        uploadprogress!(percentage);
        if (double.parse(percentage) < 100) {}
        // progressdata = double.parse(percentage);

        print("upload-->${url}------ $progress");
        if (rec == total) {
          if (fileType == "Video") {
            Provider.of<ELearningProvider>(Get.context!, listen: false)
                .initOffline();
          } else if (fileType == "Pdf" || fileType == "Epub") {
            Provider.of<ELearningProvider>(Get.context!, listen: false)
                .initEbookOffline();
          }
          // if (book != null) {
          //   if (filename.toLowerCase().contains('.pdf')) {
          //     log("bkid----${book.bkId!}");
          //     cnt.updateFilePath(fullPath, book.bkId!);
          //   } else if (filename.toLowerCase().contains('.epub')) {
          //     cnt.updateFilePath(fullPath, book.bkId!);
          //   }
          // } else if (book == null && videobook != null) {
          //   if (filename.toLowerCase().contains('.mp4')) {
          //     cnt.updateFilePath(fullPath, videobook.bkId!);
          //   }
          // }
          if (isFrom == true) {
            cnt.updatePreviewFilePath(fullPath);
          }

          print("File Download $filename---$fullPath");
        }
      });

      print("\n==================  End New Download ===================\n");
      cnt.isLoading.value = false;
      cnt.isDownloading = isLoading ?? false;
      if (videobook != null || book != null) {
        if (fileType == "Video") {
          // if (File(
          //         "${GlobalSingleton().Dirpath}/${book?.bkVideo?.split("/").last}")
          //     .existsSync()) {
          print("exist video-----");
          if (fileType == "Video") {
            SnackBarService().showSnackBar(
                message: "Video downloaded successfully...",
                type: SnackBarType.success,
                position: SnackPosition.TOP);
            book?.isDownloading!.value = false;
            videobook!.isDownloadingVideo.value = false;
            // }
          }
        } else {
          // if (File("${GlobalSingleton().Dirpath}/${book!.bkPdf?.split("/").last}")
          //         .existsSync() ||
          //     File("${GlobalSingleton().Dirpath}/${book.bkEpub?.split("/").last}")
          //         .existsSync()) {
          // cnt.isDownloaded.value = true;
          // if (File(
          //         "${GlobalSingleton().Dirpath}/${book.bkPdf?.split("/").last}")
          //     .existsSync()) {
          if (fileType == "Pdf") {
            print("-------PDF downloaded");
            SnackBarService().showSnackBar(
                message: "Pdf downloaded successfully...",
                type: SnackBarType.success,
                position: SnackPosition.TOP,
                margin: EdgeInsets.only(left: Get.width * 1.2));
            book?.isDownloading?.value = false;
            book?.isDownloadedPdf?.value = true;
          }
          // if (File(
          //         "${GlobalSingleton().Dirpath}/${book.bkEpub?.split("/").last}")
          //     .existsSync()) {
          if (fileType == "Epub") {
            print("-------Epub downloaded");
            SnackBarService().showSnackBar(
                message: "Epub downloaded successfully...",
                type: SnackBarType.success,
                position: SnackPosition.TOP,
                margin: EdgeInsets.only(left: Get.width * 1.2));
            book?.isDownloading?.value = false;
            book?.isDownloadedEpub?.value = true;
          }
          // }
        }
      }
      cnt.update();
      if (isshowSnackbar!) {
        SnackBarService().showSnackBar(
          message: "${fileType} downloaded successfully.",
          type: SnackBarType.success,
        );
      }
    } on DioError catch (e) {
      cnt.isDownloading = isLoading ?? false;
      cnt.isLoading.value = false;
      cnt.update();
      SnackBarService().showSnackBar(
        message: "Error ${e.message.toString()}",
        type: SnackBarType.error,
      );
      print(e);
    }
  }

  Future<Uint8List> filePath(uniqueFileName) async {
    Uint8List? text;
    Directory dir = await getApplicationDocumentsDirectory();

    final File file = File('${dir.path}/$uniqueFileName');
    await file.readAsBytes().then((value) {
      text = value;
    });

    return text!;
  }

  Future<String> filePaths(uniqueFileName) async {
    String? text;
    Directory dir = await getApplicationDocumentsDirectory();

    final File file = File('${dir.path}/$uniqueFileName');
    await file.readAsString().then((value) {
      text = value;
    });

    return text!;
  }
}
