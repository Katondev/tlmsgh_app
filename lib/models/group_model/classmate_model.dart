// To parse this JSON data, do
//
//     final classmateModel = classmateModelFromJson(jsonString);

import 'dart:convert';

ClassmateModel classmateModelFromJson(String str) =>
    ClassmateModel.fromJson(json.decode(str));

String classmateModelToJson(ClassmateModel data) => json.encode(data.toJson());

class ClassmateModel {
  bool? status;
  String? message;
  Data? data;

  ClassmateModel({
    this.status,
    this.message,
    this.data,
  });

  factory ClassmateModel.fromJson(Map<String, dynamic> json) => ClassmateModel(
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
  List<Student>? student;

  Data({
    this.student,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        student: json["student"] == null
            ? []
            : List<Student>.from(
                json["student"]!.map((x) => Student.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "student": student == null
            ? []
            : List<dynamic>.from(student!.map((x) => x.toJson())),
      };
}

class Student {
  int? stId;
  String? stFullName;
  String? stParentName;
  String? stPhoneNumber;
  String? stClass;
  String? stDivision;
  dynamic stAltPhoneNumber;
  String? stEmail;
  String? stRegion;
  String? stDistrict;
  String? stCircuit;
  String? stProfilePic;
  String? stBloodGroup;
  DateTime? stDateOfBirth;
  String? stAddress;
  int? stStatus;
  DateTime? stCreatedAt;
  dynamic stClassRoomId;
  int? stSchoolId;
  String? stStudentId;
  String? stAltEmail;
  String? stParentEmail;
  dynamic stAreaOfStudy;
  dynamic stCurricularActivities;
  int? stCountryCode;
  int? stParentCountryCode;
  int? stStudentType;
  dynamic forgotPasswordOtp;
  dynamic forgotPasswordPhoneOtp;
  int? isFirstTimeLogin;
  String? stLevel;
  String? stParentPhoneNumber;
  int? stUserType;
  bool? stIsEmailVerified;
  bool? stIsPhoneVerified;
  String? stEmailOtp;
  dynamic stPhoneOtp;

  Student({
    this.stId,
    this.stFullName,
    this.stParentName,
    this.stPhoneNumber,
    this.stClass,
    this.stDivision,
    this.stAltPhoneNumber,
    this.stEmail,
    this.stRegion,
    this.stDistrict,
    this.stCircuit,
    this.stProfilePic,
    this.stBloodGroup,
    this.stDateOfBirth,
    this.stAddress,
    this.stStatus,
    this.stCreatedAt,
    this.stClassRoomId,
    this.stSchoolId,
    this.stStudentId,
    this.stAltEmail,
    this.stParentEmail,
    this.stAreaOfStudy,
    this.stCurricularActivities,
    this.stCountryCode,
    this.stParentCountryCode,
    this.stStudentType,
    this.forgotPasswordOtp,
    this.forgotPasswordPhoneOtp,
    this.isFirstTimeLogin,
    this.stLevel,
    this.stParentPhoneNumber,
    this.stUserType,
    this.stIsEmailVerified,
    this.stIsPhoneVerified,
    this.stEmailOtp,
    this.stPhoneOtp,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        stId: json["st_id"],
        stFullName: json["st_fullName"],
        stParentName: json["st_parentName"],
        stPhoneNumber: json["st_phoneNumber"],
        stClass: json["st_class"],
        stDivision: json["st_division"],
        stAltPhoneNumber: json["st_altPhoneNumber"],
        stEmail: json["st_email"],
        stRegion: json["st_region"],
        stDistrict: json["st_district"],
        stCircuit: json["st_circuit"],
        stProfilePic: json["st_profilePic"],
        stBloodGroup: json["st_bloodGroup"],
        stDateOfBirth: json["st_dateOfBirth"] == null
            ? null
            : DateTime.parse(json["st_dateOfBirth"]),
        stAddress: json["st_address"],
        stStatus: json["st_status"],
        stCreatedAt: json["st_createdAt"] == null
            ? null
            : DateTime.parse(json["st_createdAt"]),
        stClassRoomId: json["st_classRoomId"],
        stSchoolId: json["st_schoolId"],
        stStudentId: json["st_studentId"],
        stAltEmail: json["st_altEmail"],
        stParentEmail: json["st_parentEmail"],
        stAreaOfStudy: json["st_areaOfStudy"],
        stCurricularActivities: json["st_curricularActivities"],
        stCountryCode: json["st_countryCode"],
        stParentCountryCode: json["st_parentCountryCode"],
        stStudentType: json["st_studentType"],
        forgotPasswordOtp: json["forgotPasswordOtp"],
        forgotPasswordPhoneOtp: json["forgotPasswordPhoneOtp"],
        isFirstTimeLogin: json["isFirstTimeLogin"],
        stLevel: json["st_level"],
        stParentPhoneNumber: json["st_parentPhoneNumber"],
        stUserType: json["st_userType"],
        stIsEmailVerified: json["st_isEmailVerified"],
        stIsPhoneVerified: json["st_isPhoneVerified"],
        stEmailOtp: json["st_emailOtp"],
        stPhoneOtp: json["st_phoneOtp"],
      );

  Map<String, dynamic> toJson() => {
        "st_id": stId,
        "st_fullName": stFullName,
        "st_parentName": stParentName,
        "st_phoneNumber": stPhoneNumber,
        "st_class": stClass,
        "st_division": stDivision,
        "st_altPhoneNumber": stAltPhoneNumber,
        "st_email": stEmail,
        "st_region": stRegion,
        "st_district": stDistrict,
        "st_circuit": stCircuit,
        "st_profilePic": stProfilePic,
        "st_bloodGroup": stBloodGroup,
        "st_dateOfBirth":
            "${stDateOfBirth!.year.toString().padLeft(4, '0')}-${stDateOfBirth!.month.toString().padLeft(2, '0')}-${stDateOfBirth!.day.toString().padLeft(2, '0')}",
        "st_address": stAddress,
        "st_status": stStatus,
        "st_createdAt": stCreatedAt?.toIso8601String(),
        "st_classRoomId": stClassRoomId,
        "st_schoolId": stSchoolId,
        "st_studentId": stStudentId,
        "st_altEmail": stAltEmail,
        "st_parentEmail": stParentEmail,
        "st_areaOfStudy": stAreaOfStudy,
        "st_curricularActivities": stCurricularActivities,
        "st_countryCode": stCountryCode,
        "st_parentCountryCode": stParentCountryCode,
        "st_studentType": stStudentType,
        "forgotPasswordOtp": forgotPasswordOtp,
        "forgotPasswordPhoneOtp": forgotPasswordPhoneOtp,
        "isFirstTimeLogin": isFirstTimeLogin,
        "st_level": stLevel,
        "st_parentPhoneNumber": stParentPhoneNumber,
        "st_userType": stUserType,
        "st_isEmailVerified": stIsEmailVerified,
        "st_isPhoneVerified": stIsPhoneVerified,
        "st_emailOtp": stEmailOtp,
        "st_phoneOtp": stPhoneOtp,
      };
}
