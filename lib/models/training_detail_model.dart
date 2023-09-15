// To parse this JSON data, do
//
//     final trainingDetailModel = trainingDetailModelFromJson(jsonString);

import 'dart:convert';

TrainingDetailModel trainingDetailModelFromJson(String str) =>
    TrainingDetailModel.fromJson(json.decode(str));

String trainingDetailModelToJson(TrainingDetailModel data) =>
    json.encode(data.toJson());

class TrainingDetailModel {
  bool? status;
  String? message;
  Data? data;

  TrainingDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory TrainingDetailModel.fromJson(Map<String, dynamic> json) =>
      TrainingDetailModel(
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
  bool? found;
  TrainingParticipants? trainingParticipants;
  List<Content>? content;

  Data({
    this.found,
    this.trainingParticipants,
    this.content,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        found: json["found"],
        trainingParticipants: json["trainingParticipants"] == null
            ? null
            : TrainingParticipants.fromJson(json["trainingParticipants"]),
        content: json["content"] == null
            ? []
            : List<Content>.from(
                json["content"]!.map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "found": found,
        "trainingParticipants": trainingParticipants?.toJson(),
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class Content {
  int? cmId;
  String? cmContentTitle;
  String? cmReadingMaterial;
  String? cmVideo;
  List<String>? cmDescription;
  bool? cmStatus;
  DateTime? cmCreatedAt;
  int? tpId;

  Content({
    this.cmId,
    this.cmContentTitle,
    this.cmReadingMaterial,
    this.cmVideo,
    this.cmDescription,
    this.cmStatus,
    this.cmCreatedAt,
    this.tpId,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        cmId: json["cm_id"],
        cmContentTitle: json["cm_contentTitle"],
        cmReadingMaterial: json["cm_readingMaterial"],
        cmVideo: json["cm_video"],
        cmDescription: json["cm_description"] == null
            ? []
            : List<String>.from(json["cm_description"]!.map((x) => x)),
        cmStatus: json["cm_status"],
        cmCreatedAt: json["cm_createdAt"] == null
            ? null
            : DateTime.parse(json["cm_createdAt"]),
        tpId: json["tp_id"],
      );

  Map<String, dynamic> toJson() => {
        "cm_id": cmId,
        "cm_contentTitle": cmContentTitle,
        "cm_readingMaterial": cmReadingMaterial,
        "cm_video": cmVideo,
        "cm_description": cmDescription == null
            ? []
            : List<dynamic>.from(cmDescription!.map((x) => x)),
        "cm_status": cmStatus,
        "cm_createdAt": cmCreatedAt?.toIso8601String(),
        "tp_id": tpId,
      };
}

class TrainingParticipants {
  int? tpsId;
  int? tpsTpId;
  String? tpsUserType;
  int? tpsUserId;
  bool? tpsStatus;
  dynamic tpsCertificate;
  dynamic tpsOldDbId;
  int? tbId;
  int? tpsTrainingOption;
  String? tpsIsTrainingCompleted;
  int? tpsTrainingStatus;
  dynamic tpsSignedForm;
  dynamic tpsScore;
  dynamic tpsExamDate;
  DateTime? tpsCreatedAt;
  dynamic tpsUpdatedAt;
  dynamic tpsAttentionFormDate;
  dynamic tpsSignFontFamily;
  dynamic tpsSignText;
  dynamic tpTrainingBatch;

  TrainingParticipants({
    this.tpsId,
    this.tpsTpId,
    this.tpsUserType,
    this.tpsUserId,
    this.tpsStatus,
    this.tpsCertificate,
    this.tpsOldDbId,
    this.tbId,
    this.tpsTrainingOption,
    this.tpsIsTrainingCompleted,
    this.tpsTrainingStatus,
    this.tpsSignedForm,
    this.tpsScore,
    this.tpsExamDate,
    this.tpsCreatedAt,
    this.tpsUpdatedAt,
    this.tpsAttentionFormDate,
    this.tpsSignFontFamily,
    this.tpsSignText,
    this.tpTrainingBatch,
  });

  factory TrainingParticipants.fromJson(Map<String, dynamic> json) =>
      TrainingParticipants(
        tpsId: json["tps_id"],
        tpsTpId: json["tps_tp_id"],
        tpsUserType: json["tps_userType"],
        tpsUserId: json["tps_userId"],
        tpsStatus: json["tps_status"],
        tpsCertificate: json["tps_certificate"],
        tpsOldDbId: json["tps_OldDBId"],
        tbId: json["tb_id"],
        tpsTrainingOption: json["tps_trainingOption"],
        tpsIsTrainingCompleted: json["tps_isTrainingCompleted"],
        tpsTrainingStatus: json["tps_trainingStatus"],
        tpsSignedForm: json["tps_signedForm"],
        tpsScore: json["tps_score"],
        tpsExamDate: json["tps_examDate"],
        tpsCreatedAt: json["tps_createdAt"] == null
            ? null
            : DateTime.parse(json["tps_createdAt"]),
        tpsUpdatedAt: json["tps_updatedAt"],
        tpsAttentionFormDate: json["tps_attentionFormDate"],
        tpsSignFontFamily: json["tps_signFontFamily"],
        tpsSignText: json["tps_signText"],
        tpTrainingBatch: json["tp_trainingBatch"],
      );

  Map<String, dynamic> toJson() => {
        "tps_id": tpsId,
        "tps_tp_id": tpsTpId,
        "tps_userType": tpsUserType,
        "tps_userId": tpsUserId,
        "tps_status": tpsStatus,
        "tps_certificate": tpsCertificate,
        "tps_OldDBId": tpsOldDbId,
        "tb_id": tbId,
        "tps_trainingOption": tpsTrainingOption,
        "tps_isTrainingCompleted": tpsIsTrainingCompleted,
        "tps_trainingStatus": tpsTrainingStatus,
        "tps_signedForm": tpsSignedForm,
        "tps_score": tpsScore,
        "tps_examDate": tpsExamDate,
        "tps_createdAt": tpsCreatedAt?.toIso8601String(),
        "tps_updatedAt": tpsUpdatedAt,
        "tps_attentionFormDate": tpsAttentionFormDate,
        "tps_signFontFamily": tpsSignFontFamily,
        "tps_signText": tpsSignText,
        "tp_trainingBatch": tpTrainingBatch,
      };
}
