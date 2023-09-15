// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';

class BookDetailsM {
  int? bkId;
  String? bkLanguage;
  String? bkTitle;
  String? bkAuthor;
  String? bkDescription;
  int? bkNoOfPages;
  String? bkPublishedDate;
  bool? bkIsFree;
  bool? bkIsPhysicalAvailable;
  int? bkPrice;
  String? bkPublisher;
  String? bkEdition;
  String? bkAudio;
  String? bkEpub;
  String? bkPreview;
  String? bkPdf;
  String? bkVideo;
  String? bkPreviewVideo;
  bool? bkStatus;
  String? bkCreatedAt;
  String? bkMainCategory;
  String? bkCategory;
  String? bkSubCategory;
  List? bkGenre;
  List<KtStudentLibraries>? ktStudentLibraries;
  bool? isInLibrary;
  RxBool? ePub;
  RxBool? pdf;
  RxBool? video;
  RxBool? isFullyDownloaded;
  bool? isVideoDownloaded = false;
  bool? isPdfDownloaded = false;
  bool? isEpubDownloaded = false;
  String? videoPath = '';
  String? pdfPath = '';
  String? ePubPath = '';
  RxBool? isDownloading = false.obs;
  RxBool? isDownloadingVideo = false.obs;
  RxBool? isDownloadedPdf = false.obs;
  RxBool? isDownloadedEpub = false.obs;
  RxBool? isDownloadedVideo = false.obs;

  BookDetailsM({
    this.bkId,
    this.bkLanguage,
    this.bkTitle,
    this.bkAuthor,
    this.bkDescription,
    this.bkNoOfPages,
    this.bkPublishedDate,
    this.bkIsFree,
    this.bkIsPhysicalAvailable,
    this.bkPrice,
    this.bkPublisher,
    this.bkEdition,
    this.bkAudio,
    this.bkEpub,
    this.bkPreview,
    this.bkPdf,
    this.bkVideo,
    this.bkPreviewVideo,
    this.bkStatus,
    this.bkCreatedAt,
    this.bkMainCategory,
    this.pdf,
    this.video,
    this.ePub,
    this.bkCategory,
    this.bkSubCategory,
    this.bkGenre,
    this.ktStudentLibraries,
    this.isFullyDownloaded,
    this.isInLibrary,
    this.isVideoDownloaded,
    this.isPdfDownloaded,
    this.isEpubDownloaded,
    this.videoPath,
    this.ePubPath,
    this.pdfPath,
  });

  static Map<String, dynamic> toMap(BookDetailsM bookDetailsM) => {
        'bk_id': bookDetailsM.bkId,
        'bk_language': bookDetailsM.bkLanguage,
        'bk_title': bookDetailsM.bkTitle,
        'bk_author': bookDetailsM.bkAuthor,
        'bk_description': bookDetailsM.bkDescription,
        'bk_noOfPages': bookDetailsM.bkNoOfPages,
        'bk_publishedDate': bookDetailsM.bkPublishedDate,
        'bk_isFree': bookDetailsM.bkIsFree,
        'bk_isPhysicalAvailable': bookDetailsM.bkIsPhysicalAvailable,
        'bk_price': bookDetailsM.bkPrice,
        'bk_publisher': bookDetailsM.bkPublisher,
        'bk_edition': bookDetailsM.bkEdition,
        'bk_audio': bookDetailsM.bkAudio,
        'bk_epub': bookDetailsM.bkEpub,
        'bk_preview': bookDetailsM.bkPreview,
        'bk_pdf': bookDetailsM.bkPdf,
        'bk_video': bookDetailsM.bkVideo,
        'bk_previewVideo': bookDetailsM.bkPreviewVideo,
        'bk_status': bookDetailsM.bkStatus,
        'bk_createdAt': bookDetailsM.bkCreatedAt,
        'bk_mainCategory': bookDetailsM.bkMainCategory,
        'bk_category': bookDetailsM.bkCategory,
        'bk_subCategory': bookDetailsM.bkSubCategory,
        'bk_genre': bookDetailsM.bkGenre,
        // 'isInLibrary': bookDetailsM.isInLibrary,
        'kt_studentLibraries': bookDetailsM.ktStudentLibraries,
        'videoPath': bookDetailsM.videoPath!,
        'ePubPath': bookDetailsM.ePubPath!,
        'pdfPath': bookDetailsM.pdfPath!,
      };

  BookDetailsM.fromJson(Map<String, dynamic> json) {
    bkId = json['bk_id'];
    bkLanguage = json['bk_language'];
    bkTitle = json['bk_title'];
    bkAuthor = json['bk_author'];
    bkDescription = json['bk_description'];
    bkNoOfPages = json['bk_noOfPages'];
    bkPublishedDate = json['bk_publishedDate'];
    bkIsFree = json['bk_isFree'];
    bkIsPhysicalAvailable = json['bk_isPhysicalAvailable'];
    bkPrice = json['bk_price'];
    bkPublisher = json['bk_publisher'];
    bkEdition = json['bk_edition'];
    bkAudio = json['bk_audio'];
    bkEpub = json['bk_epub'];
    bkPreview = json['bk_preview'];
    bkPdf = json['bk_pdf'] != null ? json['bk_pdf'] : null;
    bkVideo = json['bk_video'];
    bkPreviewVideo = json['bk_previewVideo'];
    bkStatus = json['bk_status'];
    bkCreatedAt = json['bk_createdAt'];
    bkMainCategory = json['bk_mainCategory'];
    bkCategory = json['bk_category'];
    bkSubCategory = json['bk_subCategory'];
    bkGenre = json['bk_genre'];
    // isInLibrary = json['isInLibrar/**/y'];
    if (json['kt_studentLibraries'] != null) {
      ktStudentLibraries = <KtStudentLibraries>[];
      json['kt_studentLibraries'].forEach((v) {
        ktStudentLibraries!.add(KtStudentLibraries.fromJson(v));
      });
    }
    if (json["videoPath"] != null) {
      videoPath = json['videoPath'];
    }
    if (json["pdfPath"] != null) {
      pdfPath = json['pdfPath'];
    }
    if (json["ePubPath"] != null) {
      ePubPath = json['ePubPath'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bk_id'] = bkId;
    data['bk_language'] = bkLanguage;
    data['bk_title'] = bkTitle;
    data['bk_author'] = bkAuthor;
    data['bk_description'] = bkDescription;
    data['bk_noOfPages'] = bkNoOfPages;
    data['bk_publishedDate'] = bkPublishedDate;
    data['bk_isFree'] = bkIsFree;
    data['bk_isPhysicalAvailable'] = bkIsPhysicalAvailable;
    data['bk_price'] = bkPrice;
    data['bk_publisher'] = bkPublisher;
    data['bk_edition'] = bkEdition;
    data['bk_audio'] = bkAudio;
    data['bk_epub'] = bkEpub;
    data['bk_preview'] = bkPreview;
    data['bk_pdf'] = bkPdf;
    data['bk_video'] = bkVideo;
    data['bk_previewVideo'] = bkPreviewVideo;
    data['bk_status'] = bkStatus;
    data['bk_createdAt'] = bkCreatedAt;
    data['bk_mainCategory'] = bkMainCategory;
    data['bk_category'] = bkCategory;
    data['bk_subCategory'] = bkSubCategory;
    data['bk_genre'] = bkGenre;
    // data['isInLibrary'] = this.isInLibrary;
    if (ktStudentLibraries != null) {
      data['kt_studentLibraries'] =
          ktStudentLibraries!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static String encode(List<BookDetailsM> dEncode) => json.encode(
        dEncode
            .map<Map<String, dynamic>>((data) => BookDetailsM.toMap(data))
            .toList(),
      );

  static List<BookDetailsM> decode(String dEncode) =>
      (json.decode(dEncode) as List<dynamic>)
          .map<BookDetailsM>((item) => BookDetailsM.fromJson(item))
          .toList();

  @override
  String toString() {
    return 'BookDetailsM(bkId: $bkId, bkLanguage: $bkLanguage, bkTitle: $bkTitle, bkAuthor: $bkAuthor, bkDescription: $bkDescription, bkNoOfPages: $bkNoOfPages, bkPublishedDate: $bkPublishedDate, bkIsFree: $bkIsFree, bkIsPhysicalAvailable: $bkIsPhysicalAvailable, bkPrice: $bkPrice, bkPublisher: $bkPublisher, bkEdition: $bkEdition, bkAudio: $bkAudio, bkEpub: $bkEpub, bkPreview: $bkPreview, bkPdf: $bkPdf, bkVideo: $bkVideo, bkPreviewVideo: $bkPreviewVideo, bkStatus: $bkStatus, bkCreatedAt: $bkCreatedAt, bkMainCategory: $bkMainCategory, bkCategory: $bkCategory, bkSubCategory: $bkSubCategory, bkGenre: $bkGenre, ktStudentLibraries: $ktStudentLibraries, isInLibrary: $isInLibrary, ePub: $ePub, pdf: $pdf, video: $video, isFullyDownloaded: $isFullyDownloaded)';
  }
}

class KtStudentLibraries {
  int? ktSlId;
  int? slStudentId;
  int? slBookId;
  String? slCreatedAt;
  String? slUpdatedAt;

  KtStudentLibraries(
      {this.ktSlId,
      this.slStudentId,
      this.slBookId,
      this.slCreatedAt,
      this.slUpdatedAt});

  KtStudentLibraries.fromJson(Map<String, dynamic> json) {
    ktSlId = json['kt_slId'];
    slStudentId = json['sl_studentId'];
    slBookId = json['sl_bookId'];
    slCreatedAt = json['sl_createdAt'];
    slUpdatedAt = json['sl_updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kt_slId'] = ktSlId;
    data['sl_studentId'] = slStudentId;
    data['sl_bookId'] = slBookId;
    data['sl_createdAt'] = slCreatedAt;
    data['sl_updatedAt'] = slUpdatedAt;
    return data;
  }
}
