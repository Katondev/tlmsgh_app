// To parse this JSON data, do
//
//     final groupDetailModel = groupDetailModelFromJson(jsonString);

import 'dart:convert';

GroupDetailModel groupDetailModelFromJson(String str) =>
    GroupDetailModel.fromJson(json.decode(str));

String groupDetailModelToJson(GroupDetailModel data) =>
    json.encode(data.toJson());

class GroupDetailModel {
  bool? status;
  String? message;
  Data? data;

  GroupDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory GroupDetailModel.fromJson(Map<String, dynamic> json) =>
      GroupDetailModel(
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
  Group? group;

  Data({
    this.group,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
      );

  Map<String, dynamic> toJson() => {
        "group": group?.toJson(),
      };
}

class Group {
  int? grpId;
  String? grpName;
  String? grpDesc;
  List<int>? grpParticipants;
  int? stId;
  int? scId;
  String? grpClass;
  bool? grpStatus;
  DateTime? grpCreatedAt;
  List<GrpBlog>? grpBlogs;
  List<GrpParticipantsDetail>? grpParticipantsDetails;

  Group({
    this.grpId,
    this.grpName,
    this.grpDesc,
    this.grpParticipants,
    this.stId,
    this.scId,
    this.grpClass,
    this.grpStatus,
    this.grpCreatedAt,
    this.grpBlogs,
    this.grpParticipantsDetails,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        grpId: json["grp_id"],
        grpName: json["grp_name"],
        grpDesc: json["grp_desc"],
        grpParticipants: json["grp_participants"] == null
            ? []
            : List<int>.from(json["grp_participants"]!.map((x) => x)),
        stId: json["st_id"],
        scId: json["sc_id"],
        grpClass: json["grp_class"],
        grpStatus: json["grp_status"],
        grpCreatedAt: json["grp_createdAt"] == null
            ? null
            : DateTime.parse(json["grp_createdAt"]),
        grpBlogs: json["grp_blogs"] == null
            ? []
            : List<GrpBlog>.from(
                json["grp_blogs"]!.map((x) => GrpBlog.fromJson(x))),
        grpParticipantsDetails: json["grp_participants_details"] == null
            ? []
            : List<GrpParticipantsDetail>.from(json["grp_participants_details"]!
                .map((x) => GrpParticipantsDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "grp_id": grpId,
        "grp_name": grpName,
        "grp_desc": grpDesc,
        "grp_participants": grpParticipants == null
            ? []
            : List<dynamic>.from(grpParticipants!.map((x) => x)),
        "st_id": stId,
        "sc_id": scId,
        "grp_class": grpClass,
        "grp_status": grpStatus,
        "grp_createdAt": grpCreatedAt?.toIso8601String(),
        "grp_blogs": grpBlogs == null
            ? []
            : List<dynamic>.from(grpBlogs!.map((x) => x.toJson())),
        "grp_participants_details": grpParticipantsDetails == null
            ? []
            : List<dynamic>.from(
                grpParticipantsDetails!.map((x) => x.toJson())),
      };
}

class GrpBlog {
  int? blId;
  int? grpId;
  String? blTitle;
  String? blDesc;
  dynamic blImage;
  String? blCreationType;
  int? blCreatorId;
  int? blLikeCount;
  int? blCommentCount;
  bool? blStatus;
  DateTime? blCreatedAt;
  String? blCreatorName;
  String? blCreatorPic;
  bool? showComments;
  bool? isFetchComments;
  bool? isLike;
  bool? isshowComments;

  GrpBlog({
    this.blId,
    this.grpId,
    this.blTitle,
    this.blDesc,
    this.blImage,
    this.blCreationType,
    this.blCreatorId,
    this.blLikeCount,
    this.blCommentCount,
    this.blStatus,
    this.blCreatedAt,
    this.blCreatorName,
    this.blCreatorPic,
    this.showComments,
    this.isFetchComments,
    this.isLike = false,
    this.isshowComments = false,
  });

  factory GrpBlog.fromJson(Map<String, dynamic> json) => GrpBlog(
        blId: json["bl_id"],
        grpId: json["grp_id"],
        blTitle: json["bl_title"],
        blDesc: json["bl_desc"],
        blImage: json["bl_image"],
        blCreationType: json["bl_creation_type"],
        blCreatorId: json["bl_creatorId"],
        blLikeCount: json["bl_likeCount"],
        blCommentCount: json["bl_commentCount"],
        blStatus: json["bl_status"],
        blCreatedAt: json["bl_createdAt"] == null
            ? null
            : DateTime.parse(json["bl_createdAt"]),
        blCreatorName: json["bl_creatorName"],
        blCreatorPic: json["bl_creatorPic"],
        showComments: json["showComments"],
        isFetchComments: json["isFetchComments"],
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
        "bl_commentCount": blCommentCount,
        "bl_status": blStatus,
        "bl_createdAt": blCreatedAt?.toIso8601String(),
        "bl_creatorName": blCreatorName,
        "bl_creatorPic": blCreatorPic,
        "showComments": showComments,
        "isFetchComments": isFetchComments,
        "isLike": isLike,
        "isshowComments": isshowComments,
      };
}

class GrpParticipantsDetail {
  int? stId;
  String? stFullName;
  String? stProfilePic;

  GrpParticipantsDetail({
    this.stId,
    this.stFullName,
    this.stProfilePic,
  });

  factory GrpParticipantsDetail.fromJson(Map<String, dynamic> json) =>
      GrpParticipantsDetail(
        stId: json["st_id"],
        stFullName: json["st_fullName"],
        stProfilePic: json["st_profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "st_id": stId,
        "st_fullName": stFullName,
        "st_profilePic": stProfilePic,
      };
}
