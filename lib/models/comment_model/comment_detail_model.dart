// To parse this JSON data, do
//
//     final commentDetailModel = commentDetailModelFromJson(jsonString);

import 'dart:convert';

CommentDetailModel commentDetailModelFromJson(String str) =>
    CommentDetailModel.fromJson(json.decode(str));

String commentDetailModelToJson(CommentDetailModel data) =>
    json.encode(data.toJson());

class CommentDetailModel {
  bool? status;
  String? message;
  Data? data;

  CommentDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory CommentDetailModel.fromJson(Map<String, dynamic> json) =>
      CommentDetailModel(
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
  List<Comment>? comment;

  Data({
    this.comment,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        comment: json["comment"] == null
            ? []
            : List<Comment>.from(
                json["comment"]!.map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment == null
            ? []
            : List<dynamic>.from(comment!.map((x) => x.toJson())),
      };
}

class Comment {
  int? cmnId;
  String? cmnComment;
  int? cmnUserId;
  String? cmnUserType;
  int? blId;
  DateTime? cmnDate;
  DateTime? cmnCreatedAt;
  String? cmnFullName;
  String? cmnProfilePic;
  bool? isLoadingComments;

  Comment({
    this.cmnId,
    this.cmnComment,
    this.cmnUserId,
    this.cmnUserType,
    this.blId,
    this.cmnDate,
    this.cmnCreatedAt,
    this.cmnFullName,
    this.cmnProfilePic,
    this.isLoadingComments = false,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        cmnId: json["cmn_id"],
        cmnComment: json["cmn_comment"],
        cmnUserId: json["cmn_userId"],
        cmnUserType: json["cmn_userType"],
        blId: json["bl_id"],
        cmnDate:
            json["cmn_date"] == null ? null : DateTime.parse(json["cmn_date"]),
        cmnCreatedAt: json["cmn_createdAt"] == null
            ? null
            : DateTime.parse(json["cmn_createdAt"]),
        cmnFullName: json["cmn_fullName"],
        cmnProfilePic: json["cmn_profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "cmn_id": cmnId,
        "cmn_comment": cmnComment,
        "cmn_userId": cmnUserId,
        "cmn_userType": cmnUserType,
        "bl_id": blId,
        "cmn_date": cmnDate?.toIso8601String(),
        "cmn_createdAt": cmnCreatedAt?.toIso8601String(),
        "cmn_fullName": cmnFullName,
        "cmn_profilePic": cmnProfilePic,
        "isLoadingComments": isLoadingComments,
      };
}
