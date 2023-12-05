// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  bool? status;
  String? message;
  Data? data;

  BlogModel({
    this.status,
    this.message,
    this.data,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
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
  Blog? blog;

  Data({
    this.blog,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        blog: json["blog"] == null ? null : Blog.fromJson(json["blog"]),
      );

  Map<String, dynamic> toJson() => {
        "blog": blog?.toJson(),
      };
}

class Blog {
  int? count;
  List<BlogRow>? rows;

  Blog({
    this.count,
    this.rows,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        count: json["count"],
        rows: json["rows"] == null
            ? []
            : List<BlogRow>.from(json["rows"]!.map((x) => BlogRow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class BlogRow {
  int? blId;
  int? grpId;
  String? blTitle;
  String? blDesc;
  String? blImage;
  String? blCreationType;
  int? blCreatorId;
  int? blLikeCount;
  bool? blStatus;
  DateTime? blCreatedAt;
  bool? showComments;
  bool? isFetchComments;
  int? blCommentCount;
  String? blCreatorName;
  String? blCreatorPic;
  bool? isLike;
  bool? isshowComments;

  BlogRow({
    this.blId,
    this.grpId,
    this.blTitle,
    this.blDesc,
    this.blImage,
    this.blCreationType,
    this.blCreatorId,
    this.blLikeCount,
    this.blStatus,
    this.blCreatedAt,
    this.showComments,
    this.isFetchComments,
    this.blCommentCount,
    this.blCreatorName,
    this.blCreatorPic,
    this.isLike = false,
    this.isshowComments = false,
  });

  factory BlogRow.fromJson(Map<String, dynamic> json) => BlogRow(
        blId: json["bl_id"],
        grpId: json["grp_id"],
        blTitle: json["bl_title"],
        blDesc: json["bl_desc"],
        blImage: json["bl_image"] ,
        blCreationType: json["bl_creation_type"],
        blCreatorId: json["bl_creatorId"],
        blLikeCount: json["bl_likeCount"],
        blStatus: json["bl_status"],
        blCreatedAt: json["bl_createdAt"] == null
            ? null
            : DateTime.parse(json["bl_createdAt"]),
        showComments: json["showComments"],
        isFetchComments: json["isFetchComments"],
        blCommentCount: json["bl_commentCount"],
        blCreatorName: json["bl_creatorName"],
        blCreatorPic: json["bl_creatorPic"],
      );

  Map<String, dynamic> toJson() => {
        "bl_id": blId,
        "grp_id": grpId,
        "bl_title": blTitle,
        "bl_desc": blDesc,
        "bl_image": blImage,
        "bl_creation_type": blCreationType,
        "bl_creatorId": blCreatorId,
        "bl_likeCount": blLikeCount,
        "bl_status": blStatus,
        "bl_createdAt": blCreatedAt?.toIso8601String(),
        "showComments": showComments,
        "isFetchComments": isFetchComments,
        "bl_commentCount": blCommentCount,
        "bl_creatorName": blCreatorName,
        "bl_creatorPic": blCreatorPic,
        "isLike": isLike,
        "isshowComments": isshowComments,
      };
}
