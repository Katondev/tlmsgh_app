import 'package:get/get.dart';

class PastPaperModel {
  PastPaperModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  PastPaperModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;

  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    List<PastPaperList>? pastPaperList,
  }) {
    _pastPaper = pastPaperList;
  }

  Data.fromJson(dynamic json) {
    if (json['pastPaper'] != null) {
      _pastPaper = [];
      json['pastPaper'].forEach((v) {
        _pastPaper?.add(PastPaperList.fromJson(v));
      });
    }
  }
  List<PastPaperList>? _pastPaper;

  List<PastPaperList>? get pastPaper => _pastPaper;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_pastPaper != null) {
      map['pastPaper'] = _pastPaper?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PastPaperList {
  PastPaperList({
    int? ppId,
    int? ppYear,
    String? ppBody,
    String? ppTitle,
    String? ppCategory,
    String? ppSubCategory,
    String? ppTopic,
    String? ppPdf,
    String? ppWrittenPdf,
    int? ppTotalMarks,
    bool? ppStatus,
    String? ppCreatedAt,
    RxBool? isDownloading,
    RxBool? inProgress,
  }) {
    _ppId = ppId;
    _ppYear = ppYear;
    _ppBody = ppBody;
    _ppTitle = ppTitle;
    _ppCategory = ppCategory;
    _ppSubCategory = ppSubCategory;
    _ppTopic = ppTopic;
    _ppPdf = ppPdf;
    _ppWrittenPdf = ppWrittenPdf;
    _ppTotalMarks = ppTotalMarks;
    _ppStatus = ppStatus;
    _ppCreatedAt = ppCreatedAt;
    _ppisDownloading = isDownloading;
    _ppinProgress = inProgress;
  }

  PastPaperList.fromJson(dynamic json) {
    _ppId = json['pp_id'];
    _ppYear = json['pp_year'];
    _ppBody = json['pp_body'];
    _ppTitle = json['pp_title'];
    _ppCategory = json['pp_category'];
    _ppSubCategory = json['pp_subCategory'];
    _ppTopic = json['pp_topic'];
    _ppPdf = json['pp_pdf'];
    _ppWrittenPdf = json['pp_writtenPDF'];
    _ppTotalMarks = json['pp_totalMarks'];
    _ppStatus = json['pp_status'];
    _ppCreatedAt = json['pp_createdAt'];
  }
  int? _ppId;
  int? _ppYear;
  String? _ppBody;
  String? _ppTitle;
  String? _ppCategory;
  String? _ppSubCategory;
  String? _ppTopic;
  String? _ppPdf;
  String? _ppWrittenPdf;
  int? _ppTotalMarks;
  bool? _ppStatus;
  String? _ppCreatedAt;
  RxBool? _ppisDownloading = false.obs;
  RxBool? _ppinProgress = false.obs;

  int? get ppId => _ppId;
  int? get ppYear => _ppYear;
  String? get ppBody => _ppBody;
  String? get ppTitle => _ppTitle;
  String? get ppCategory => _ppCategory;
  String? get ppSubCategory => _ppSubCategory;
  String? get ppTopic => _ppTopic;
  String? get ppPdf => _ppPdf;
  String? get ppWrittenPdf => _ppWrittenPdf;
  int? get ppTotalMarks => _ppTotalMarks;
  bool? get ppStatus => _ppStatus;
  String? get ppCreatedAt => _ppCreatedAt;
  RxBool? get ppisDownloading => _ppisDownloading;
  RxBool? get ppinProgress => _ppinProgress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pp_id'] = _ppId;
    map['pp_year'] = _ppYear;
    map['pp_body'] = _ppBody;
    map['pp_title'] = _ppTitle;
    map['pp_category'] = _ppCategory;
    map['pp_subCategory'] = _ppSubCategory;
    map['pp_topic'] = _ppTopic;
    map['pp_pdf'] = _ppPdf;
    map['pp_writtenPDF'] = _ppWrittenPdf;
    map['pp_totalMarks'] = _ppTotalMarks;
    map['pp_status'] = _ppStatus;
    map['pp_createdAt'] = _ppCreatedAt;
    return map;
  }
}
