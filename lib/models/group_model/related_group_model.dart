// To parse this JSON data, do
//
//     final relatedGroupModel = relatedGroupModelFromJson(jsonString);

import 'dart:convert';

RelatedGroupModel relatedGroupModelFromJson(String str) =>
    RelatedGroupModel.fromJson(json.decode(str));

String relatedGroupModelToJson(RelatedGroupModel data) =>
    json.encode(data.toJson());

class RelatedGroupModel {
  bool? status;
  String? message;
  Data? data;

  RelatedGroupModel({
    this.status,
    this.message,
    this.data,
  });

  factory RelatedGroupModel.fromJson(Map<String, dynamic> json) =>
      RelatedGroupModel(
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
  List<RelatedGroup>? group;

  Data({
    this.group,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        group: json["group"] == null
            ? []
            : List<RelatedGroup>.from(
                json["group"]!.map((x) => RelatedGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group": group == null
            ? []
            : List<dynamic>.from(group!.map((x) => x.toJson())),
      };
}

class RelatedGroup {
  int? grpId;
  String? grpName;
  String? grpDesc;
  List<int>? grpParticipants;
  int? stId;
  int? scId;
  String? grpClass;
  bool? grpStatus;
  DateTime? grpCreatedAt;

  RelatedGroup({
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

  factory RelatedGroup.fromJson(Map<String, dynamic> json) => RelatedGroup(
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
