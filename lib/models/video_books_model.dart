// To parse this JSON data, do
//
//     final videoBooksModel = videoBooksModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

VideoBooksModel videoBooksModelFromJson(String str) =>
    VideoBooksModel.fromJson(json.decode(str));

String videoBooksModelToJson(VideoBooksModel data) =>
    json.encode(data.toJson());

class VideoBooksModel {
  bool? status;
  String? message;
  VideoData? data;

  VideoBooksModel({
    this.status,
    this.message,
    this.data,
  });

  factory VideoBooksModel.fromJson(Map<String, dynamic> json) =>
      VideoBooksModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : VideoData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class VideoData {
  List<VideoDatum>? videoData;

  VideoData({
    this.videoData,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        videoData: json["videoData"] == null
            ? []
            : List<VideoDatum>.from(
                json["videoData"]!.map((x) => VideoDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "videoData": videoData == null
            ? []
            : List<dynamic>.from(videoData!.map((x) => x.toJson())),
      };

  static String encode(List<VideoDatum> dEncode) {
    return json.encode(
      dEncode.map<Map<String, dynamic>>((data) => data.toJson()).toList(),
    );
  }

  static List<VideoDatum> decode(String dEncode) =>
      (json.decode(dEncode) as List<dynamic>)
          .map<VideoDatum>((item) => VideoDatum.fromJson(item))
          .toList();
}

class VideoDatum {
  String? label;
  List<VideoBooksData>? data;

  VideoDatum({
    this.label,
    this.data,
  });

  factory VideoDatum.fromJson(Map<String, dynamic> json) => VideoDatum(
        label: json["label"],
        data: json["data"] == null
            ? []
            : List<VideoBooksData>.from(
                json["data"]!.map((x) => VideoBooksData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  //  static Map<String, dynamic> toMap(VideoDatum bookDetailsM) => {
  //  "videoData": videoData == null
  //       ? []
  //       : List<dynamic>.from(videoData!.map((x) => x.toJson())),
  // };
}

class VideoBooksData {
  int? bkId;
  String? bkLanguage;
  String? bkTitle;
  String? bkAuthor;
  String? bkDescription;
  dynamic bkNoOfPages;
  DateTime? bkPublishedDate;
  bool? bkIsFree;
  bool? bkIsPhysicalAvailable;
  int? bkPrice;
  String? bkPublisher;
  dynamic bkEdition;
  dynamic bkAudio;
  String? bkEpub;
  String? bkPreview;
  String? bkPdf;
  String? bkVideo;
  dynamic bkPreviewVideo;
  bool? bkStatus;
  DateTime? bkCreatedAt;
  String? bkMainCategory;
  String? bkCategory;
  String? bkSubCategory;
  List<BkGenre>? bkGenre;
  List<BkWhoCanRead>? bkWhoCanRead;
  dynamic tpId;
  RxBool isDownloadedVideo = false.obs;
  RxBool isDownloadingVideo = false.obs;

  VideoBooksData({
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
    this.bkCategory,
    this.bkSubCategory,
    this.bkGenre,
    this.bkWhoCanRead,
    this.tpId,
  });

  factory VideoBooksData.fromJson(Map<String, dynamic> json) => VideoBooksData(
        bkId: json["bk_id"],
        bkLanguage: json["bk_language"],
        bkTitle: json["bk_title"],
        bkAuthor: json["bk_author"],
        bkDescription: json["bk_description"],
        bkNoOfPages: json["bk_noOfPages"],
        bkPublishedDate: json["bk_publishedDate"] == null
            ? null
            : DateTime.parse(json["bk_publishedDate"]),
        bkIsFree: json["bk_isFree"],
        bkIsPhysicalAvailable: json["bk_isPhysicalAvailable"],
        bkPrice: json["bk_price"],
        bkPublisher: json["bk_publisher"],
        bkEdition: json["bk_edition"],
        bkAudio: json["bk_audio"],
        bkEpub: json["bk_epub"],
        bkPreview: json["bk_preview"],
        bkPdf: json["bk_pdf"],
        bkVideo: json["bk_video"],
        bkPreviewVideo: json["bk_previewVideo"],
        bkStatus: json["bk_status"],
        bkCreatedAt: json["bk_createdAt"] == null
            ? null
            : DateTime.parse(json["bk_createdAt"]),
        bkMainCategory: json["bk_mainCategory"],
        bkCategory: json["bk_category"],
        bkSubCategory: json["bk_subCategory"],
        bkGenre: json["bk_genre"] == null
            ? []
            : List<BkGenre>.from(
                json["bk_genre"]!.map((x) => bkGenreValues.map[x]!)),
        bkWhoCanRead: json["bk_whoCanRead"] == null
            ? []
            : List<BkWhoCanRead>.from(
                json["bk_whoCanRead"]!.map((x) => bkWhoCanReadValues.map[x]!)),
        tpId: json["tp_id"],
      );

  Map<String, dynamic> toJson() => {
        "bk_id": bkId,
        "bk_language": bkLanguage,
        "bk_title": bkTitle,
        "bk_author": bkAuthor,
        "bk_description": bkDescription,
        "bk_noOfPages": bkNoOfPages,
        "bk_publishedDate":
            "${bkPublishedDate!.year.toString().padLeft(4, '0')}-${bkPublishedDate!.month.toString().padLeft(2, '0')}-${bkPublishedDate!.day.toString().padLeft(2, '0')}",
        "bk_isFree": bkIsFree,
        "bk_isPhysicalAvailable": bkIsPhysicalAvailable,
        "bk_price": bkPrice,
        "bk_publisher": bkPublisher,
        "bk_edition": bkEdition,
        "bk_audio": bkAudio,
        "bk_epub": bkEpub,
        "bk_preview": bkPreview,
        "bk_pdf": bkPdf,
        "bk_video": bkVideo,
        "bk_previewVideo": bkPreviewVideo,
        "bk_status": bkStatus,
        "bk_createdAt": bkCreatedAt?.toIso8601String(),
        "bk_mainCategory": bkMainCategory,
        "bk_category": bkCategory,
        "bk_subCategory": bkSubCategory,
        "bk_genre": bkGenre == null
            ? []
            : List<dynamic>.from(bkGenre!.map((x) => bkGenreValues.reverse[x])),
        "bk_whoCanRead": bkWhoCanRead == null
            ? []
            : List<dynamic>.from(
                bkWhoCanRead!.map((x) => bkWhoCanReadValues.reverse[x])),
        "tp_id": tpId,
      };
}

enum BkAuthorEnum { CENDLOS }

final bkAuthorEnumValues = EnumValues({"Cendlos": BkAuthorEnum.CENDLOS});

enum Label { SHS_1, SHS_2, SHS_3 }

final labelValues = EnumValues(
    {"SHS 1": Label.SHS_1, "SHS 2": Label.SHS_2, "SHS 3": Label.SHS_3});

enum BkGenre { VIDEO, VIDEO_AND_TRANSCRIPT }

final bkGenreValues = EnumValues({
  "Video": BkGenre.VIDEO,
  "Video and Transcript": BkGenre.VIDEO_AND_TRANSCRIPT
});

enum BkLanguageEnum {
  CORE_MATHEMATICS,
  ENGLISH,
  ENGLISH_LANGUAGE,
  INFORMATION_COMMUINCATION_AND_TECHNOLOGY,
  INTEGRATED_SCIENCE,
  KIDS_SUBJECT_1,
  MATHEMATICS,
  SCIENCE,
  SOCIAL_SCIENCE,
  SOCIAL_STUDIES
}

final bkLanguageEnumValues = EnumValues({
  "Core Mathematics": BkLanguageEnum.CORE_MATHEMATICS,
  "English": BkLanguageEnum.ENGLISH,
  "English Language": BkLanguageEnum.ENGLISH_LANGUAGE,
  "Information Commuincation And Technology":
      BkLanguageEnum.INFORMATION_COMMUINCATION_AND_TECHNOLOGY,
  "Integrated Science": BkLanguageEnum.INTEGRATED_SCIENCE,
  "Kids Subject 1": BkLanguageEnum.KIDS_SUBJECT_1,
  "Mathematics": BkLanguageEnum.MATHEMATICS,
  "Science": BkLanguageEnum.SCIENCE,
  "Social Science": BkLanguageEnum.SOCIAL_SCIENCE,
  "Social Studies": BkLanguageEnum.SOCIAL_STUDIES
});

enum BkMainCategory { SHS }

final bkMainCategoryValues = EnumValues({"SHS": BkMainCategory.SHS});

enum BkWhoCanRead { STUDENT, TEACHER }

final bkWhoCanReadValues = EnumValues(
    {"Student": BkWhoCanRead.STUDENT, "Teacher": BkWhoCanRead.TEACHER});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
