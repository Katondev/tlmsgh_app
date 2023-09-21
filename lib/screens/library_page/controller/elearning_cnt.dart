import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/models/books_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/my_library/widgets/video_player.dart';
import 'package:katon/services/auth_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/custom_dialog.dart';
import 'package:katon/widgets/download_file.dart';
import 'package:katon/widgets/loading_indicator.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import '../../../models/library_book_model.dart';
import '../../../models/video_books_model.dart';
import '../../../services/api_service.dart';
import '../../../utils/global_singlton.dart';
import '../../training/pdf_viewer/pdf_viewer.dart';

class ELearningCnt extends GetxController {
  RxBool isLoading = false.obs;
  bool isLoadings = false;
  bool isDownloading = false;
  RxBool isDownloaded = false.obs;
  RxBool isDownloadedvideo = false.obs;
  RxInt downloadBookId = 0.obs;
  RxBool isDownloadingBook = false.obs;
  BooksM? booksM;
  RxBool isLiked = false.obs;
  RxBool valueChange = false.obs;
  String bookId = "";
  RxString downloadId = "".obs;
  String? ePubPath;
  String? pdfPath;
  String? videoPath;
  String? statusMessage;
  RxBool ePubExisted = false.obs;
  RxBool pdfExisted = false.obs;
  RxBool videoExisted = false.obs;
  RxBool ePub = false.obs;
  RxBool video = false.obs;
  RxBool pdf = false.obs;
  // RxBool isDownloadedPdf = false.obs;
  // RxBool isDownloadedEpub = false.obs;
  int pageNo = 0;
  RxDouble ratingval = 0.0.obs;

  RxList<BookDetailsM> books = <BookDetailsM>[].obs;
  int totalNumberOfPages = 1;
  RxList<BookDetailsM>? similarBookList = <BookDetailsM>[].obs;

  Future getAllBooks() async {
    try {
      isLoading.value = true;
      update();
      await AuthServices().getBooksList().then((value) {
        booksM = value;
        // print(
        //     "booksM?.data?.bookList?.rows?.length${booksM?.data?.bookList?.rows?.length}");
      });
      isLoading.value = false;
      update();
    } on Exception {
      isLoading.value = false;
      update();
      rethrow;
    }
  }

  Future getLibraryBook() async {
    try {
      isLoading.value = true;

      update();
      LibraryBookM? booksM;
      try {
        await ApiService.instance
            .getHTTP(ApiRoutes.libraryBook, queryParameters: {
          "userType": "${AppPreference().uType}",
        }).then((value) async {
          booksM = LibraryBookM.fromJson(value.data);
          books.value = booksM?.data?.books ?? [];
          log("dsdsdsdsdsdsdsdsd---${books.length}");

          // if (books.isNotEmpty) {
          log("empty");
          final String encodeData = BookDetailsM.encode(books);
          await AppPreference()
              .setString(PreferencesKey.myLibraryData, encodeData);
          // }
        });
        return booksM;
      } on Exception catch (e) {
        print("object>>${e.toString()}");
        rethrow;
      }
      // await AuthServices().getLibraryBook().then((value) async {
      //   books.value = value?.data?.books ?? [];

      //   if (books.isNotEmpty) {
      //     final String encodeData = BookDetailsM.encode(books);
      //     await AppPreference()
      //         .setString(PreferencesKey.myLibraryData, encodeData);
      //   }
      // });
      // isLoading = false;
      // update();
    } on Exception {
      isLoading.value = false;
      update();
      rethrow;
    }
  }

  Future getData() async {
    pageNo = 0;
    final String booksString =
        AppPreference().getString(PreferencesKey.myLibraryData);
    if (booksString.isNotEmpty) {
      books.value = BookDetailsM.decode(booksString);
      log(books.length.toString());
    }
    double totalPage = books.length / 12;
    if (totalPage <= 1.00) {
      totalNumberOfPages = 1;
    } else if (totalPage <= 2.00) {
      totalNumberOfPages = 2;
    } else {
      totalNumberOfPages = int.parse(totalPage.toStringAsFixed(0));
    }
  }

  Future<bool> addLibraryData(BookDetailsM book) async {
    CustomLoadingIndicator.instance.show(message: "adding".tr);
    try {
      await AuthServices().addLibrary(book.bkId!).then((value) {
        valueChange.value = value?.statusCode == 200;
      });
      getData();
      books.add(book);
      List<BookDetailsM> booksNew = books.reversed.toList();
      final String encodeData = BookDetailsM.encode(booksNew);
      await AppPreference().setString(PreferencesKey.myLibraryData, encodeData);
      CustomLoadingIndicator.instance.hide();
      return true;
    } catch (e) {
      CustomLoadingIndicator.instance.hide();
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      return false;
    }
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  Future deleteData(BookDetailsM book) async {
    CustomLoadingIndicator.instance.show(message: "deleting".tr);

    try {
      var res = await AuthServices().deleteLibrary(book.bkId!);

      valueChange.value = res?.statusMessage == 200;
      statusMessage = res?.data["message"];
      if (res?.statusCode == 200) {
        int index = books.indexWhere((element) => element.bkId == book.bkId);
        if (books[index].videoPath!.isNotEmpty) {
          File("/data/user/0/com.katon.student/app_flutter/${book.bkVideo!.split("/").last}")
              .delete();
          deleteFile(File(books[index].videoPath!));
        }
        if (books[index].pdfPath!.isNotEmpty) {
          File("/data/user/0/com.katon.student/app_flutter/${book.bkPdf!.split("/").last}")
              .delete();
          deleteFile(File(books[index].pdfPath!));
        }

        if (books[index].ePubPath!.isNotEmpty) {
          File("/data/user/0/com.katon.student/app_flutter/${book.bkEpub!.split("/").last}")
              .delete();
          deleteFile(File(books[index].ePubPath!));
        }
        books.removeWhere((item) => item.bkId == book.bkId);

        final String encodeData = BookDetailsM.encode(books);
        await AppPreference()
            .setString(PreferencesKey.myLibraryData, encodeData);
      }
      CustomLoadingIndicator.instance.hide();
      // Navigator.of(Get.context!).pop(true);
      if (Responsive.isMobile(navigatorKey.currentContext!)) {
        // Get.back(result: true);
        // Get.back(result: true);
        // Get.back(result: true);
        navigatorKey.currentState?.pop();
        log("in mobile");
      } else {
        navigatorKey.currentState?.pop();
      }
      getLibraryBook();
      Future.delayed(Duration(milliseconds: 100), () {
        log("BOOK successfully DELETED....");
        SnackBarService()
            .showSnackBar(message: statusMessage, type: SnackBarType.success);
      });
    } catch (e) {
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }

  Future internetConnectionCheck({
    required String url,
    required String filename,
    required String fileType,
    required bool bookItem1,
    required int bookId,
    String errorMessage = "",
    String path = "",
    BookDetailsM? book,
    VideoBooksData? videobook,
  }) async {
    if (path != "") {
      RxBool connection = false.obs;
      connection.value = await InternetConnectionChecker().hasConnection;
      if (connection.value) {
        log("${url}---${filename}---${book}");
        await DownloadGeoJsonFile().downloadFile(
            url: url,
            filename: filename,
            book: book,
            videobook: videobook,
            fileType: fileType,
            uploadprogress: (prg) {
              // var progress = double.parse(prg.toString());
              // log(progress.toString());
            });
      } else {
        SnackBarService()
            .showSnackBar(message: 'no_internet'.tr, type: SnackBarType.error);
      }
      isDownloading = false;
      bookItem1 = false;
    } else {
      SnackBarService()
          .showSnackBar(message: 'no_data_found'.tr, type: SnackBarType.error);
      isDownloading = false;
      bookItem1 = false;
      update();
    }
  }

  Future internetCheckforDownload({
    required String url,
    required String filename,
    required String fileType,
    required bool bookItem1,
    required int bookId,
    String errorMessage = "",
    String path = "",
    BookDetailsM? book,
    VideoBooksData? videobook,
    int? labelindex,
    int? videoindex,
  }) async {
    if (path != "") {
      RxBool connection = false.obs;
      connection.value = await InternetConnectionChecker().hasConnection;
      if (connection.value) {
        log("${url}---${filename}---${book}");
        await DownloadGeoJsonFile().downloadVideosandFiles(
            url: url,
            filename: filename,
            book: book,
            videobook: videobook,
            fileType: fileType,
            currentlabelIndex: labelindex,
            currentVideoIndex: videoindex,
            uploadprogress: (prg) {
              // var progress = double.parse(prg.toString());
              // log(progress.toString());
            });
      } else {
        SnackBarService()
            .showSnackBar(message: 'no_internet'.tr, type: SnackBarType.error);
      }
      isDownloading = false;
      bookItem1 = false;
    } else {
      SnackBarService()
          .showSnackBar(message: 'no_data_found'.tr, type: SnackBarType.error);
      isDownloading = false;
      bookItem1 = false;
      update();
    }
  }

  getEpubFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'epub',
      ],
    );
    if (result != null) {
      log("file path ${result.files.single.path}");
      return result.files.single.path!;
    } else {
      return null;
    }
  }

  String oldId = "";

  Future onPressed(
      {required String bookItem,
      required bool bookItem1,
      required bool bookItemExist,
      required String screenName,
      required BuildContext context,
      required int id,
      String? bookName,
      String? epubPath,
      BookDetailsM? book}) async {
    ///download ==true and Boookid==id download
    ///download ==true and Boookid!=id download
    ///same page ==true then download pdf|| download video enable.
    String pdfId = await AppPreference().getString('pdfId', defValue: '');
    log(pdfId);
    String idVideoStored =
        await AppPreference().getString('videoId', defValue: '');
    log(idVideoStored);
    String idEpubStored =
        await AppPreference().getString('epubId', defValue: '');
    if (pdfId.isNotEmpty && pdfId != id ||
        idVideoStored.isNotEmpty && idVideoStored != id ||
        idEpubStored.isNotEmpty && idEpubStored != id) {
      // await showDialog(
      //     context: Get.context!,
      //     builder: (BuildContext context) => CustomDialog(
      //           message: "book_resources".tr,
      //           title1: "ok".tr,
      //           onFirstButtonTap: () => Navigator.of(context).pop(),
      //         ));
      // return;
      // Fluttertoast.showToast(msg: "book_resources".tr);
    }
    switch (screenName) {
      case "PDF":
        {
          if (book!.bkPdf!.isNotEmpty &&
              File("${GlobalSingleton().Dirpath}/${book.bkPdf!.split("/").last}")
                  .existsSync()) {
            Get.to(() => PdfViewerScreen(
                  filename: "${book.bkPdf}",
                  filetype: "Pdf",
                ));
          } else {
            if (pdfId.isEmpty &&
                idVideoStored.isEmpty &&
                idEpubStored.isEmpty) {
              await AppPreference().setString('pdfId', id.toString());
              downloadId.value = id.toString();
              log("PDF download id---$downloadId");
              bookItem1 = true;
              isDownloading = true;
              pdf.value = true;
              video.value = false;
              update();
              await internetConnectionCheck(
                bookId: id,
                bookItem1: bookItem1,
                errorMessage: "no_video_found".tr,
                path: bookItem,
                url: "${ApiRoutes.imageURL}$bookItem",
                filename: bookItem,
                book: book,
                fileType: "Pdf",
              );
              print("Download Complete");
              isDownloading = false;
              bookItem1 = false;
              bookItemExist = true;
              await AppPreference().setString('pdfId', '');

              pdf.value = false;
              update();
            } else {
              await showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) => CustomDialog(
                        message: "book_resources".tr,
                        title1: "ok".tr,
                        onFirstButtonTap: () => Navigator.of(context).pop(),
                      ));
            }
          }
        }
        break;

      case "Epub":
        {
          {
            log("inside epub..");
            // PermissionStatus status = await Permission.storage.request();
            // Map<Permission, PermissionStatus> status =
            //     await PermissionService().requestStoragePermission();
            // log(status.toString());
            // if (status == PermissionStatus.denied) {
            //   await Permission.storage.request();
            // } else if (status == PermissionStatus.permanentlyDenied) {
            //   await openAppSettings();
            // } else {
            //   if (status == PermissionStatus.granted) {
            VocsyEpub.setConfig(
              themeColor: Theme.of(context).primaryColor,
              identifier: "iosBook",
              scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
              allowSharing: true,
              enableTts: true,
              nightMode: false,
            );
            VocsyEpub.locatorStream.listen((locator) {
              log('LOCATOR:----------------- $locator');
            });
            if (book?.bkEpub != null &&
                File("${GlobalSingleton().Dirpath}/${book?.bkEpub?.split("/").last}")
                    .existsSync()) {
              VocsyEpub.open(
                book!.ePubPath!,
              );
            } else {
              if (idEpubStored.isEmpty &&
                  idVideoStored.isEmpty &&
                  pdfId.isEmpty) {
                await AppPreference().setString('epubId', id.toString());

                ePub.value = true;
                bookItem1 = true;
                isDownloading = true;
                downloadId.value = id.toString();
                log("EPUB download id---$downloadId");
                update();
                await internetConnectionCheck(
                    bookId: id,
                    bookItem1: bookItem1,
                    errorMessage: "no_video_found".tr,
                    path: bookItem,
                    url: "${ApiRoutes.imageURL}$bookItem",
                    filename: bookItem,
                    fileType: "Epub",
                    book: book);
                print("Download Complete");
                isDownloading = false;
                bookItem1 = false;
                ePub.value = false;
                await AppPreference().setString('epubId', '');

                bookItemExist = true;
                update();
              } else {
                await showDialog(
                    context: Get.context!,
                    builder: (BuildContext context) => CustomDialog(
                          message: "book_resources".tr,
                          title1: "ok".tr,
                          onFirstButtonTap: () => Navigator.of(context).pop(),
                        ));
              }
            }
            // } else {
            //   print("hello");
            // }
            // }
          }
        }
        break;

      case "Video":
        {
          if (book!.bkVideo!.isNotEmpty &&
              File("${GlobalSingleton().Dirpath}/${book.bkVideo!.split("/").last}")
                  .existsSync()) {
            log(book.bkVideo.toString());
            Get.to(() => Video(title: book.bkVideo!));
          } else {
            if (idVideoStored.isEmpty &&
                pdfId.isEmpty &&
                idEpubStored.isEmpty) {
              await AppPreference().setString('videoId', id.toString());

              downloadId.value = id.toString();
              log("VIDEO download id---$downloadId");
              bookItem1 = true;
              isDownloading = true;
              video.value = true;
              // pdfId.isEmpty;
              update();
              await internetConnectionCheck(
                  bookId: id,
                  bookItem1: bookItem1,
                  errorMessage: "no_video_found".tr,
                  path: bookItem,
                  url: "${ApiRoutes.imageURL}$bookItem",
                  filename: bookItem,
                  fileType: "Video",
                  book: book);
              print("Download Complete");
              isDownloading = false;
              bookItem1 = false;
              bookItemExist = true;
              await AppPreference().setString('videoId', '');
              video.value = false;
              update();
            } else {
              log("pdfid----${idVideoStored}");
              await showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) => CustomDialog(
                        message: "book_resources".tr,
                        title1: "ok".tr,
                        onFirstButtonTap: () => Navigator.of(context).pop(),
                      ));
            }
          }
        }
        break;
    }
  }

  RxInt onTapDownloadIndex = 0.obs;

  Future onPressedDownload({
    required String bookItem,
    required bool bookItem1,
    required bool bookItemExist,
    required String screenName,
    required BuildContext context,
    required int id,
    String? bookName,
    String? epubPath,
    List<BookDetailsM>? booksList,
    BookDetailsM? book,
    List<VideoBooksData>? videoBookList,
    VideoBooksData? videobook,
    int? labelindex,
    int? videoindex,
  }) async {
    // log("message----->>>--${book?.bkId}---${booksList!.map((element) => element.bkId)}----${books.length}");
    if (screenName == "PDF" || screenName == "Epub") {
      var element = booksList!.firstWhere((k) => k.bkId == book?.bkId);
      var index = booksList.indexOf(element);
      onTapDownloadIndex.value = index;
    } else {
      var element = videoBookList!.firstWhere((k) => k.bkId == videobook?.bkId);
      var index = videoBookList.indexOf(element);
      onTapDownloadIndex.value = index;
    }
    log("ontap index---${onTapDownloadIndex.value}");

    ///download ==true and Boookid==id download
    ///download ==true and Boookid!=id download
    ///same page ==true then download pdf|| download video enable.
    String pdfId = await AppPreference().getString('pdfId', defValue: '');
    log(pdfId);
    String idVideoStored =
        await AppPreference().getString('videoId', defValue: '');
    log(idVideoStored);
    String idEpubStored =
        await AppPreference().getString('epubId', defValue: '');
    if (pdfId.isNotEmpty && pdfId != id ||
        idVideoStored.isNotEmpty && idVideoStored != id ||
        idEpubStored.isNotEmpty && idEpubStored != id) {}
    switch (screenName) {
      case "PDF":
        {
          if (pdfId.isEmpty && idVideoStored.isEmpty && idEpubStored.isEmpty) {
            await AppPreference().setString('pdfId', id.toString());
            downloadId.value = id.toString();
            log("PDF download id---$books");
            bookItem1 = true;
            isDownloading = true;
            pdf.value = true;
            video.value = false;
            update();
            await internetCheckforDownload(
                bookId: id,
                bookItem1: bookItem1,
                errorMessage: "no_video_found".tr,
                path: bookItem,
                url: "${ApiRoutes.imageURL}$bookItem",
                filename: bookItem,
                book: book,
                labelindex: labelindex,
                videoindex: videoindex,
                fileType: "Pdf");
            print("Download Complete");
            isDownloading = false;
            bookItem1 = false;
            bookItemExist = true;
            await AppPreference().setString('pdfId', '');

            pdf.value = false;
            update();
          } else {
            await showDialog(
                context: Get.context!,
                builder: (BuildContext context) => CustomDialog(
                      message: "book_resources".tr,
                      title1: "ok".tr,
                      onFirstButtonTap: () => Navigator.of(context).pop(),
                    ));
          }
        }
        break;

      case "Epub":
        {
          {
            log("inside epub..");

            VocsyEpub.setConfig(
              themeColor: Theme.of(context).primaryColor,
              identifier: "iosBook",
              scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
              allowSharing: true,
              enableTts: true,
              nightMode: false,
            );
            VocsyEpub.locatorStream.listen((locator) {
              log('LOCATOR:----------------- $locator');
            });

            if (idEpubStored.isEmpty &&
                idVideoStored.isEmpty &&
                pdfId.isEmpty) {
              await AppPreference().setString('epubId', id.toString());

              ePub.value = true;
              bookItem1 = true;
              isDownloading = true;
              downloadId.value = id.toString();
              log("EPUB download id---$downloadId");
              update();
              await internetCheckforDownload(
                  bookId: id,
                  bookItem1: bookItem1,
                  errorMessage: "no_video_found".tr,
                  path: bookItem,
                  url: "${ApiRoutes.imageURL}$bookItem",
                  filename: bookItem,
                  book: book,
                  labelindex: labelindex,
                  videoindex: videoindex,
                  fileType: "Epub");
              print("Download Complete");
              isDownloading = false;
              bookItem1 = false;
              ePub.value = false;
              await AppPreference().setString('epubId', '');

              bookItemExist = true;
              update();
            } else {
              await showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) => CustomDialog(
                        message: "book_resources".tr,
                        title1: "ok".tr,
                        onFirstButtonTap: () => Navigator.of(context).pop(),
                      ));
            }
          }
          // } else {
          //   print("hello");
          // }
          // }
        }
        break;

      case "Video":
        {
          if (idVideoStored.isEmpty && pdfId.isEmpty && idEpubStored.isEmpty) {
            await AppPreference().setString('videoId', id.toString());

            downloadId.value = id.toString();
            log("VIDEO download id---$downloadId");
            bookItem1 = true;
            isDownloading = true;
            video.value = true;
            // pdfId.isEmpty;
            update();
            await internetCheckforDownload(
                bookId: id,
                bookItem1: bookItem1,
                errorMessage: "no_video_found".tr,
                path: bookItem,
                url: "${ApiRoutes.imageURL}$bookItem",
                filename: bookItem,
                videobook: videobook,
                labelindex: labelindex,
                videoindex: videoindex,
                fileType: "Video");
            print("Download Complete");
            isDownloading = false;
            bookItem1 = false;
            bookItemExist = true;
            await AppPreference().setString('videoId', '');
            video.value = false;
            update();
          } else {
            log("pdfid----${idVideoStored}");
            await showDialog(
                context: Get.context!,
                builder: (BuildContext context) => CustomDialog(
                      message: "book_resources".tr,
                      title1: "ok".tr,
                      onFirstButtonTap: () => Navigator.of(context).pop(),
                    ));
          }
        }
        break;
    }
  }

  String updatePreviewPath = '';

  updatePreviewFilePath(String path) async {
    updatePreviewPath = path;
    update();
  }

  updateFilePath(String path, int id) async {
    videoPath = path;
    //
    log("update element---${books.length}");
    var element = books.firstWhere((k) => k.bkId == id, orElse: null);
    var index = books.indexOf(element);
    if (path.contains('.mp4')) {
      books[index].isVideoDownloaded = true;
      books[index].videoPath = path;
      //books[index].bkVideo = path;
    }
    if (path.contains('.pdf')) {
      books[index].isPdfDownloaded = true;
      //books[index].bkPdf = path;
      books[index].pdfPath = path;
    }
    if (path.contains('.epub')) {
      books[index].isEpubDownloaded = true;
      // books[index].bkEpub = path;
      books[index].ePubPath = path;
    }
    final String encodeData = BookDetailsM.encode(books);
    await AppPreference().setString(PreferencesKey.myLibraryData, encodeData);
    final String booksString =
        AppPreference().getString(PreferencesKey.myLibraryData);
    if (booksString.isNotEmpty) {
      books.value = BookDetailsM.decode(booksString);
    }
    isDownloading = false;
    isLoading.value = false;
    update();
  }

  Future<void> onAddToLibraryClick(BookDetailsM book) async {
    // print(book);
    // bool isAdded = await addLibraryData(book);
    // if (isAdded) {
    //   if (isDownloading == false) {
    //     isLoadings = true;
    //     isDownloading = true;
    //     bookId = book.bkId.toString();
    //     update();
    //     print("=================================");
    //     print("Book Preview Pdf ${ApiRoutes.imageURL}${book.bkPreview}");
    //     print("Book Pdf ${ApiRoutes.imageURL}${book.bkPdf}");
    //     print("Book Epub ${ApiRoutes.imageURL}${book.bkEpub}");
    //     print("Book Video ${ApiRoutes.imageURL}${book.bkVideo}");
    //     print("=================================");
    //     if (book.bkPreview != null) {
    //       await DownloadGeoJsonFile().downloadFile(
    //           url: "${ApiRoutes.imageURL}${book.bkPreview}",
    //           isLoading: true,
    //           filename: book.bkPreview.toString());
    //     }
    //     if (book.bkPdf != null) {
    //       await DownloadGeoJsonFile().downloadFile(
    //           // isLoadingType: pdfType,
    //           isLoading: true,
    //           url: "${ApiRoutes.imageURL}${book.bkPdf}",
    //           filename: book.bkPdf.toString());
    //       pdfExisted = true;
    //     }
    //
    //     if (book.bkEpub != null) {
    //       await DownloadGeoJsonFile().downloadFile(
    //           isLoading: true,
    //           url: "${ApiRoutes.imageURL}${book.bkEpub}",
    //           filename: book.bkEpub.toString());
    //       ePubExisted = true;
    //     }
    //
    //     print("book.bkVideo ${book.bkVideo.runtimeType}");
    //     if (book.bkVideo != null) {
    //       await DownloadGeoJsonFile().downloadFile(
    //           isLoading: true,
    //           url: "${ApiRoutes.imageURL}${book.bkVideo}",
    //           filename: book.bkVideo.toString(),
    //           book: book);
    //       videoExisted = true;
    //     }
    //
    //     isLoadings = false;
    //     isDownloading = false;
    //     update();
    //   }
    // }
  }

  int? onTapSelectedIndex;

  Future<void> onBookDetailsTap(
      {BookDetailsM? bookObj,
      List<BookDetailsM>? bookList,
      bool? navigation,
      bool? isSimilarOrNot}) async {
    similarBookList?.clear();
    if (isSimilarOrNot == true) {
      var element =
          books.firstWhere((k) => k.bkId == bookObj!.bkId, orElse: null);
      var index = books.indexOf(element);
      onTapSelectedIndex = index;
      log(onTapSelectedIndex.toString());
    } else {
      var element =
          books.firstWhere((k) => k.bkId == bookObj!.bkId, orElse: null);
      var index = books.indexOf(element);
      onTapSelectedIndex = index;
      log(onTapSelectedIndex.toString());
    }
    bookList?.forEach((element) {
      if (bookObj?.bkId != element.bkId) {
        similarBookList?.add(element);
      }
    });
    update();
    if (navigation ?? false) {
      bookObj = bookObj;
      // Get.toNamed(RoutesConst.libraryBookDetail, arguments: [
      //   bookObj,
      //   StudentRouteArguments().getArgument(RoutesConst.bookDetail),
      //   similarBookList
      // ])!
      //     .then((value) {
      //   if (value == true) {
      //     log("message");
      //   }
      //   ;
      // });
      navigatorKey.currentState
          ?.pushNamed(RoutesConst.libraryBookDetail, arguments: [
        bookObj,
        StudentRouteArguments().getArgument(RoutesConst.bookDetail),
        similarBookList
      ]).then((value) {
        if (value == true) {
          log("message");
        }
        ;
      });
    } else {
      // Get.to(LibraryBookDetailPage(), arguments:
      //   bookObj,
      //   StudentRouteArguments().getArgument(RoutesConst.bookDetail),
      //   similarBookList[
      // ]);

      // if (isSimilarOrNot == true) {
      //   Get.to(LibraryBookDetailPage(), arguments: [
      //     bookObj,
      //     StudentRouteArguments().getArgument(RoutesConst.bookDetail),
      //     similarBookList
      //   ]);
      // } else {
      //   navigatorKey.currentState?.pushNamed(
      //     RoutesConst.libraryBookDetail,
      //     arguments: [
      //       bookObj,
      //       StudentRouteArguments().getArgument(RoutesConst.bookDetail),
      //       similarBookList
      //     ],
      //   );
      // }
    }
  }

  Future<void> downloadResource(
      {required BuildContext context, required BookDetailsM book}) async {
    if (isDownloading == true) {
      log("Is downloading : ${isDownloading}");
      await showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
                title1: "ok".tr,
                onFirstButtonTap: () => Navigator.of(context).pop(),
                message: "book_resources".tr,
              ));
    } else {
      print("Nothing downloading now");
      if (isDownloading == false) {
        print("Download fun called inside ${isDownloading}");
        isLoadings = true;
        isDownloading = true;
        bookId = book.bkId.toString();
        update();
        if (book.bkPreview != null) {
          await DownloadGeoJsonFile().downloadFile(
              url: "${ApiRoutes.imageURL}${book.bkPreview}",
              isLoading: true,
              filename: book.bkPreview.toString(),
              book: book);
        }
        if (book.bkPdf != null) {
          log("in pdf...");
          await DownloadGeoJsonFile().downloadFile(
              // isLoadingType: pdfType,
              isLoading: true,
              url: "${ApiRoutes.imageURL}${book.bkPdf}",
              filename: book.bkPdf.toString(),
              book: book);
          pdfExisted.value = true;
        }
        if (book.bkEpub != null) {
          log("in epub...");
          await DownloadGeoJsonFile().downloadFile(
              // isLoadingType: ePubType,
              isLoading: true,
              url: "${ApiRoutes.imageURL}${book.bkEpub}",
              filename: book.bkEpub.toString(),
              book: book);
          ePubExisted.value = true;
        }
        if (book.bkVideo != null) {
          await DownloadGeoJsonFile().downloadFile(
              isLoading: true,
              url: "${ApiRoutes.imageURL}${book.bkVideo}",
              filename: book.bkVideo.toString(),
              book: book);
          videoExisted.value = true;
        }
        isLoadings = false;
        isDownloading = false;
        update();
      }
    }
  }
}
