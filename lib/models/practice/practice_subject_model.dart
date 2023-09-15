// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

PracticeSubjectModel subjectModelFromJson(String str) =>
    PracticeSubjectModel.fromJson(json.decode(str));

String subjectModelToJson(PracticeSubjectModel data) =>
    json.encode(data.toJson());

class PracticeSubjectModel {
  bool? status;
  String? message;
  List<String>? data;

  PracticeSubjectModel({
    this.status,
    this.message,
    this.data,
  });

  factory PracticeSubjectModel.fromJson(Map<String, dynamic> json) =>
      PracticeSubjectModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<String>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}
