// To parse this JSON data, do
//
//     final assignmentResultModel = assignmentResultModelFromJson(jsonString);

import 'dart:convert';

AssignmentResultModel assignmentResultModelFromJson(String str) =>
    AssignmentResultModel.fromJson(json.decode(str));

String assignmentResultModelToJson(AssignmentResultModel data) =>
    json.encode(data.toJson());

class AssignmentResultModel {
  bool? status;
  String? message;
  Data? data;

  AssignmentResultModel({
    this.status,
    this.message,
    this.data,
  });

  factory AssignmentResultModel.fromJson(Map<String, dynamic> json) =>
      AssignmentResultModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<AssignmentResult>? assignmentResult;

  Data({
    this.assignmentResult,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        assignmentResult: json["assignmentResult"] == null
            ? []
            : List<AssignmentResult>.from(json["assignmentResult"]!
                .map((x) => AssignmentResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assignmentResult": assignmentResult == null
            ? []
            : List<dynamic>.from(assignmentResult!.map((x) => x.toJson())),
      };
}

class AssignmentResult {
  int? arId;
  int? asnId;
  String? arAnswerKeys;
  int? arScore;
  int? stId;
  int? arTotalQuestion;
  int? arUnanswered;
  String? arSubmitTime;
  DateTime? arDateTime;
  DateTime? arCreatedAt;
  ArAssignment? arAssignment;
  ArStudent? arStudent;

  AssignmentResult({
    this.arId,
    this.asnId,
    this.arAnswerKeys,
    this.arScore,
    this.stId,
    this.arTotalQuestion,
    this.arUnanswered,
    this.arSubmitTime,
    this.arDateTime,
    this.arCreatedAt,
    this.arAssignment,
    this.arStudent,
  });

  factory AssignmentResult.fromJson(Map<String, dynamic> json) =>
      AssignmentResult(
        arId: json["ar_id"],
        asnId: json["asn_id"],
        arAnswerKeys: json["ar_answerKeys"],
        arScore: json["ar_score"],
        stId: json["st_id"],
        arTotalQuestion: json["ar_totalQuestion"],
        arUnanswered: json["ar_unanswered"],
        arSubmitTime: json["ar_submitTime"],
        arDateTime: json["ar_dateTime"] == null
            ? null
            : DateTime.parse(json["ar_dateTime"]),
        arCreatedAt: json["ar_createdAt"] == null
            ? null
            : DateTime.parse(json["ar_createdAt"]),
        arAssignment: json["ar_assignment"] == null
            ? null
            : ArAssignment.fromJson(json["ar_assignment"]),
        arStudent: json["ar_student"] == null
            ? null
            : ArStudent.fromJson(json["ar_student"]),
      );

  Map<String, dynamic> toJson() => {
        "ar_id": arId,
        "asn_id": asnId,
        "ar_answerKeys": arAnswerKeys,
        "ar_score": arScore,
        "st_id": stId,
        "ar_totalQuestion": arTotalQuestion,
        "ar_unanswered": arUnanswered,
        "ar_submitTime": arSubmitTime,
        "ar_dateTime": arDateTime?.toIso8601String(),
        "ar_createdAt": arCreatedAt?.toIso8601String(),
        "ar_assignment": arAssignment?.toJson(),
        "ar_student": arStudent?.toJson(),
      };
}

class ArAssignment {
  int? asnId;
  String? asnTitle;
  int? asnTotalMarks;

  ArAssignment({
    this.asnId,
    this.asnTitle,
    this.asnTotalMarks,
  });

  factory ArAssignment.fromJson(Map<String, dynamic> json) => ArAssignment(
        asnId: json["asn_id"],
        asnTitle: json["asn_title"],
        asnTotalMarks: json["asn_totalMarks"],
      );

  Map<String, dynamic> toJson() => {
        "asn_id": asnId,
        "asn_title": asnTitle,
        "asn_totalMarks": asnTotalMarks,
      };
}

class ArStudent {
  String? stFullName;
  String? stProfilePic;

  ArStudent({
    this.stFullName,
    this.stProfilePic,
  });

  factory ArStudent.fromJson(Map<String, dynamic> json) => ArStudent(
        stFullName: json["st_fullName"],
        stProfilePic: json["st_profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "st_fullName": stFullName,
        "st_profilePic": stProfilePic,
      };
}
