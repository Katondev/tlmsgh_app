// To parse this JSON data, do
//
//     final groupListModel = groupListModelFromJson(jsonString);

import 'dart:convert';

GroupListModel groupListModelFromJson(String str) =>
    GroupListModel.fromJson(json.decode(str));

String groupListModelToJson(GroupListModel data) => json.encode(data.toJson());

class GroupListModel {
  bool? status;
  String? message;
  Data? data;

  GroupListModel({
    this.status,
    this.message,
    this.data,
  });

  factory GroupListModel.fromJson(Map<String, dynamic> json) => GroupListModel(
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
  List<Group>? group;

  Data({
    this.group,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        group: json["group"] == null
            ? []
            : List<Group>.from(json["group"]!.map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group": group == null
            ? []
            : List<dynamic>.from(group!.map((x) => x.toJson())),
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
      };
}
