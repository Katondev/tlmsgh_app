// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

import '../sign_in_model.dart';

StaticDataModel temperaturesFromJson(String str) =>
    StaticDataModel.fromJson(json.decode(str));

String temperaturesToJson(StaticDataModel data) => json.encode(data.toJson());

class StaticDataModel {
  bool? status;
  String? message;
  Data? data;

  StaticDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory StaticDataModel.fromJson(Map<String, dynamic> json) =>
      StaticDataModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  List<String>? divisions;
  List<String>? bloodGroups;
  List<CertificateList>? subjectsMaster;
  List<CertificateList>? certificateList;
  List<CertificateList>? levels;
  List<CertificateList>? languages;
  List<Class>? classes;
  List<CertificateList>? yearsOfExperience;

  Data({
    this.divisions,
    this.bloodGroups,
    this.subjectsMaster,
    this.certificateList,
    this.levels,
    this.languages,
    this.classes,
    this.yearsOfExperience,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        divisions: List<String>.from(json["divisions"].map((x) => x)),
        bloodGroups: List<String>.from(json["bloodGroups"].map((x) => x)),
        subjectsMaster: List<CertificateList>.from(
            json["subjectsMaster"].map((x) => CertificateList.fromJson(x))),
        certificateList: List<CertificateList>.from(
            json["certificateList"].map((x) => CertificateList.fromJson(x))),
        levels: List<CertificateList>.from(
            json["levels"].map((x) => CertificateList.fromJson(x))),
        languages: List<CertificateList>.from(
            json["languages"].map((x) => CertificateList.fromJson(x))),
        classes:
            List<Class>.from(json["classes"].map((x) => Class.fromJson(x))),
        yearsOfExperience: List<CertificateList>.from(
            json["yearsOfExperience"].map((x) => CertificateList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "divisions": List<dynamic>.from(divisions!.map((x) => x)),
        "bloodGroups": List<dynamic>.from(bloodGroups!.map((x) => x)),
        "subjectsMaster":
            List<dynamic>.from(subjectsMaster!.map((x) => x.toJson())),
        "certificateList":
            List<dynamic>.from(certificateList!.map((x) => x.toJson())),
        "levels": List<dynamic>.from(levels!.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
        "classes": List<dynamic>.from(classes!.map((x) => x.toJson())),
        "yearsOfExperience":
            List<dynamic>.from(yearsOfExperience!.map((x) => x.toJson())),
      };
}

// class CertificateList {
//   String? label;
//   String? value;

//   CertificateList({
//     this.label,
//     this.value,
//   });

//   factory CertificateList.fromJson(Map<String, dynamic> json) =>
//       CertificateList(
//         label: json["label"],
//         value: json["value"],
//       );

//   Map<String, dynamic> toJson() => {
//         "label": label,
//         "value": value,
//       };
// }

class Class {
  String? label;
  List<CertificateList>? options;

  Class({
    this.label,
    this.options,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        label: json["label"],
        options: List<CertificateList>.from(
            json["options"].map((x) => CertificateList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}
