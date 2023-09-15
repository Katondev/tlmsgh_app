// To parse this JSON data, do
//
//     final studentSignupModel = studentSignupModelFromJson(jsonString);

import 'dart:convert';

StudentSignupModel studentSignupModelFromJson(String str) =>
    StudentSignupModel.fromJson(json.decode(str));

String studentSignupModelToJson(StudentSignupModel data) =>
    json.encode(data.toJson());

class StudentSignupModel {
  bool? status;
  String? message;
  StudentSignupData? data;

  StudentSignupModel({
    this.status,
    this.message,
    this.data,
  });

  factory StudentSignupModel.fromJson(Map<String, dynamic> json) =>
      StudentSignupModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : StudentSignupData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class StudentSignupData {
  Student? student;

  StudentSignupData({
    this.student,
  });

  factory StudentSignupData.fromJson(Map<String, dynamic> json) => StudentSignupData(
        student:
            json["student"] == null ? null : Student.fromJson(json["student"]),
      );

  Map<String, dynamic> toJson() => {
        "student": student?.toJson(),
      };
}

class Student {
  int? stStatus;
  DateTime? stCreatedAt;
  bool? stIsEmailVerified;
  bool? stIsPhoneVerified;
  int? stId;
  String? stFullName;
  String? stEmail;
  String? stPhoneNumber;
  int? stCountryCode;
  String? stPassword;
  int? stSchoolId;
  int? stStudentType;
  int? stUserType;
  String? stClass;
  String? stParentName;
  String? stParentPhoneNumber;
  int? stParentCountryCode;
  String? stParentEmail;
  String? stRegion;
  String? stDistrict;
  dynamic stCircuit;
  int? isFirstTimeLogin;
  String? stLevel;
  String? stEmailOtp;
  dynamic stDivision;
  dynamic stAltPhoneNumber;
  dynamic stProfilePic;
  dynamic stBloodGroup;
  dynamic stDateOfBirth;
  dynamic stAddress;
  dynamic stClassRoomId;
  dynamic stStudentId;
  dynamic stAltEmail;
  dynamic stAreaOfStudy;
  dynamic stCurricularActivities;
  dynamic forgotPasswordOtp;
  dynamic forgotPasswordPhoneOtp;
  dynamic stPhoneOtp;

  Student({
    this.stStatus,
    this.stCreatedAt,
    this.stIsEmailVerified,
    this.stIsPhoneVerified,
    this.stId,
    this.stFullName,
    this.stEmail,
    this.stPhoneNumber,
    this.stCountryCode,
    this.stPassword,
    this.stSchoolId,
    this.stStudentType,
    this.stUserType,
    this.stClass,
    this.stParentName,
    this.stParentPhoneNumber,
    this.stParentCountryCode,
    this.stParentEmail,
    this.stRegion,
    this.stDistrict,
    this.stCircuit,
    this.isFirstTimeLogin,
    this.stLevel,
    this.stEmailOtp,
    this.stDivision,
    this.stAltPhoneNumber,
    this.stProfilePic,
    this.stBloodGroup,
    this.stDateOfBirth,
    this.stAddress,
    this.stClassRoomId,
    this.stStudentId,
    this.stAltEmail,
    this.stAreaOfStudy,
    this.stCurricularActivities,
    this.forgotPasswordOtp,
    this.forgotPasswordPhoneOtp,
    this.stPhoneOtp,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        stStatus: json["st_status"],
        stCreatedAt: json["st_createdAt"] == null
            ? null
            : DateTime.parse(json["st_createdAt"]),
        stIsEmailVerified: json["st_isEmailVerified"],
        stIsPhoneVerified: json["st_isPhoneVerified"],
        stId: json["st_id"],
        stFullName: json["st_fullName"],
        stEmail: json["st_email"],
        stPhoneNumber: json["st_phoneNumber"],
        stCountryCode: json["st_countryCode"],
        stPassword: json["st_password"],
        stSchoolId: json["st_schoolId"],
        stStudentType: json["st_studentType"],
        stUserType: json["st_userType"],
        stClass: json["st_class"],
        stParentName: json["st_parentName"],
        stParentPhoneNumber: json["st_parentPhoneNumber"],
        stParentCountryCode: json["st_parentCountryCode"],
        stParentEmail: json["st_parentEmail"],
        stRegion: json["st_region"],
        stDistrict: json["st_district"],
        stCircuit: json["st_circuit"],
        isFirstTimeLogin: json["isFirstTimeLogin"],
        stLevel: json["st_level"],
        stEmailOtp: json["st_emailOtp"],
        stDivision: json["st_division"],
        stAltPhoneNumber: json["st_altPhoneNumber"],
        stProfilePic: json["st_profilePic"],
        stBloodGroup: json["st_bloodGroup"],
        stDateOfBirth: json["st_dateOfBirth"],
        stAddress: json["st_address"],
        stClassRoomId: json["st_classRoomId"],
        stStudentId: json["st_studentId"],
        stAltEmail: json["st_altEmail"],
        stAreaOfStudy: json["st_areaOfStudy"],
        stCurricularActivities: json["st_curricularActivities"],
        forgotPasswordOtp: json["forgotPasswordOtp"],
        forgotPasswordPhoneOtp: json["forgotPasswordPhoneOtp"],
        stPhoneOtp: json["st_phoneOtp"],
      );

  Map<String, dynamic> toJson() => {
        "st_status": stStatus,
        "st_createdAt": stCreatedAt?.toIso8601String(),
        "st_isEmailVerified": stIsEmailVerified,
        "st_isPhoneVerified": stIsPhoneVerified,
        "st_id": stId,
        "st_fullName": stFullName,
        "st_email": stEmail,
        "st_phoneNumber": stPhoneNumber,
        "st_countryCode": stCountryCode,
        "st_password": stPassword,
        "st_schoolId": stSchoolId,
        "st_studentType": stStudentType,
        "st_userType": stUserType,
        "st_class": stClass,
        "st_parentName": stParentName,
        "st_parentPhoneNumber": stParentPhoneNumber,
        "st_parentCountryCode": stParentCountryCode,
        "st_parentEmail": stParentEmail,
        "st_region": stRegion,
        "st_district": stDistrict,
        "st_circuit": stCircuit,
        "isFirstTimeLogin": isFirstTimeLogin,
        "st_level": stLevel,
        "st_emailOtp": stEmailOtp,
        "st_division": stDivision,
        "st_altPhoneNumber": stAltPhoneNumber,
        "st_profilePic": stProfilePic,
        "st_bloodGroup": stBloodGroup,
        "st_dateOfBirth": stDateOfBirth,
        "st_address": stAddress,
        "st_classRoomId": stClassRoomId,
        "st_studentId": stStudentId,
        "st_altEmail": stAltEmail,
        "st_areaOfStudy": stAreaOfStudy,
        "st_curricularActivities": stCurricularActivities,
        "forgotPasswordOtp": forgotPasswordOtp,
        "forgotPasswordPhoneOtp": forgotPasswordPhoneOtp,
        "st_phoneOtp": stPhoneOtp,
      };
}
