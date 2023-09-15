// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

SubjectModel subjectModelFromJson(String str) =>
    SubjectModel.fromJson(json.decode(str));

String subjectModelToJson(SubjectModel data) => json.encode(data.toJson());

class SubjectModel {
  bool? status;
  String? message;
  List<SubjectDataModel>? data;

  SubjectModel({
    this.status,
    this.message,
    this.data,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SubjectDataModel>.from(
                json["data"]!.map((x) => SubjectDataModel(
                      title: x,
                      isExpanded: false,
                      subList: ["E Books", "Videos"],
                    ))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}

class SubjectDataModel {
  String? title;
  bool? isExpanded;
  List<String>? subList;

  SubjectDataModel({
    this.title,
    this.isExpanded,
    this.subList,
  });

  factory SubjectDataModel.fromJson(Map<String, dynamic> json) =>
      SubjectDataModel(
        title: json["title"],
        isExpanded: json["isExpanded"],
        subList: json["subList"] == null
            ? []
            : List<String>.from(json["subList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "isExpanded": isExpanded,
        "subList":
            subList == null ? [] : List<dynamic>.from(subList!.map((x) => x)),
      };

  static String encode(List<SubjectDataModel> dEncode) => json.encode(
        dEncode
            .map<Map<String, dynamic>>((data) => SubjectDataModel.toMap(data))
            .toList(),
      );

  static List<SubjectDataModel> decode(String dEncode) =>
      (json.decode(dEncode) as List<dynamic>)
          .map<SubjectDataModel>((item) => SubjectDataModel.fromJson(item))
          .toList();

  static Map<String, dynamic> toMap(SubjectDataModel subjectData) => {
        'title': subjectData.title,
        'isExpanded': subjectData.isExpanded,
        'subList': subjectData.subList,
      };
}
