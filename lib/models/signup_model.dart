// To parse this JSON data, do
//
//     final teacherSignupModel = teacherSignupModelFromJson(jsonString);

import 'dart:convert';

TeacherSignupModel teacherSignupModelFromJson(String str) =>
    TeacherSignupModel.fromJson(json.decode(str));

String teacherSignupModelToJson(TeacherSignupModel data) =>
    json.encode(data.toJson());

class TeacherSignupModel {
  bool? status;
  String? message;
  Data? data;

  TeacherSignupModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherSignupModel.fromJson(Map<String, dynamic> json) =>
      TeacherSignupModel(
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
  FreelanceTeacher? freelanceTeacher;

  Data({
    this.freelanceTeacher,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        freelanceTeacher: FreelanceTeacher.fromJson(json["freelanceTeacher"]),
      );

  Map<String, dynamic> toJson() => {
        "freelanceTeacher": freelanceTeacher!.toJson(),
      };
}

class FreelanceTeacher {
  int? tcStatus;
  String? tcCreatedAt;
  bool? tcIsEmailVerified;
  bool? tcIsPhoneVerified;
  bool? canCreateLiveClass;
  String? tcFullName;
  String? tcEmail;
  String? tcPhoneNumber;
  String? tcPassword;
  String? tcCountry;
  int? tcCountryCode;
  String? tcLevel;
  String? tcExperience;
  String? tcCertificate;
  String? tcBriefProfile;
  String? tcRegion;
  String? tcDistrict;
  dynamic tcCircuit;
  List<String>? tcLanguageSpoken;
  List<String>? tcSubject;
  String? tcStaffId;
  int? tcSchoolId;
  int? tcUserType;
  int? isFirstTimeLogin;
  String? tcEmailOtp;
  int? tcId;
  dynamic tcEducation;
  dynamic tcAltPhoneNumber;
  dynamic tcAddress;
  dynamic tcProfilePic;
  dynamic tcDegreeCertificate;
  dynamic tcBloodGroup;
  dynamic tcDateOfBirth;
  dynamic tcPincode;
  dynamic tcAltEmail;
  dynamic tcOldDbId;
  dynamic tcRegisterPassword;
  dynamic tcPhoneOtp;
  dynamic forgotPasswordOtp;
  dynamic forgotPasswordPhoneOtp;
  dynamic tcClassRoomId;
  dynamic tcAlsoKnownAs;

  FreelanceTeacher({
    this.tcStatus,
    this.tcCreatedAt,
    this.tcIsEmailVerified,
    this.tcIsPhoneVerified,
    this.canCreateLiveClass,
    this.tcFullName,
    this.tcEmail,
    this.tcPhoneNumber,
    this.tcPassword,
    this.tcCountry,
    this.tcCountryCode,
    this.tcLevel,
    this.tcExperience,
    this.tcCertificate,
    this.tcBriefProfile,
    this.tcRegion,
    this.tcDistrict,
    this.tcCircuit,
    this.tcLanguageSpoken,
    this.tcSubject,
    this.tcStaffId,
    this.tcSchoolId,
    this.tcUserType,
    this.isFirstTimeLogin,
    this.tcEmailOtp,
    this.tcId,
    this.tcEducation,
    this.tcAltPhoneNumber,
    this.tcAddress,
    this.tcProfilePic,
    this.tcDegreeCertificate,
    this.tcBloodGroup,
    this.tcDateOfBirth,
    this.tcPincode,
    this.tcAltEmail,
    this.tcOldDbId,
    this.tcRegisterPassword,
    this.tcPhoneOtp,
    this.forgotPasswordOtp,
    this.forgotPasswordPhoneOtp,
    this.tcClassRoomId,
    this.tcAlsoKnownAs,
  });

  factory FreelanceTeacher.fromJson(Map<String, dynamic> json) =>
      FreelanceTeacher(
        tcStatus: json["tc_status"],
        tcCreatedAt: json["tc_createdAt"],
        tcIsEmailVerified: json["tc_isEmailVerified"],
        tcIsPhoneVerified: json["tc_isPhoneVerified"],
        canCreateLiveClass: json["canCreateLiveClass"],
        tcFullName: json["tc_fullName"],
        tcEmail: json["tc_email"],
        tcPhoneNumber: json["tc_phoneNumber"],
        tcPassword: json["tc_password"],
        tcCountry: json["tc_country"],
        tcCountryCode: json["tc_countryCode"],
        tcLevel: json["tc_level"],
        tcExperience: json["tc_experience"],
        tcCertificate: json["tc_certificate"],
        tcBriefProfile: json["tc_briefProfile"],
        tcRegion: json["tc_region"],
        tcDistrict: json["tc_district"],
        tcCircuit: json["tc_circuit"],
        tcLanguageSpoken:
            List<String>.from(json["tc_languageSpoken"].map((x) => x)),
        tcSubject: List<String>.from(json["tc_subject"].map((x) => x)),
        tcStaffId: json["tc_staffId"],
        tcSchoolId: json["tc_schoolId"],
        tcUserType: json["tc_userType"],
        isFirstTimeLogin: json["isFirstTimeLogin"],
        tcEmailOtp: json["tc_emailOtp"],
        tcId: json["tc_id"],
        tcEducation: json["tc_education"],
        tcAltPhoneNumber: json["tc_altPhoneNumber"],
        tcAddress: json["tc_address"],
        tcProfilePic: json["tc_profilePic"],
        tcDegreeCertificate: json["tc_degreeCertificate"],
        tcBloodGroup: json["tc_bloodGroup"],
        tcDateOfBirth: json["tc_dateOfBirth"],
        tcPincode: json["tc_pincode"],
        tcAltEmail: json["tc_altEmail"],
        tcOldDbId: json["tc_oldDBId"],
        tcRegisterPassword: json["tc_register_password"],
        tcPhoneOtp: json["tc_phoneOtp"],
        forgotPasswordOtp: json["forgotPasswordOtp"],
        forgotPasswordPhoneOtp: json["forgotPasswordPhoneOtp"],
        tcClassRoomId: json["tc_classRoomId"],
        tcAlsoKnownAs: json["tc_alsoKnownAs"],
      );

  Map<String, dynamic> toJson() => {
        "tc_status": tcStatus,
        "tc_createdAt": tcCreatedAt,
        "tc_isEmailVerified": tcIsEmailVerified,
        "tc_isPhoneVerified": tcIsPhoneVerified,
        "canCreateLiveClass": canCreateLiveClass,
        "tc_fullName": tcFullName,
        "tc_email": tcEmail,
        "tc_phoneNumber": tcPhoneNumber,
        "tc_password": tcPassword,
        "tc_country": tcCountry,
        "tc_countryCode": tcCountryCode,
        "tc_level": tcLevel,
        "tc_experience": tcExperience,
        "tc_certificate": tcCertificate,
        "tc_briefProfile": tcBriefProfile,
        "tc_region": tcRegion,
        "tc_district": tcDistrict,
        "tc_circuit": tcCircuit,
        "tc_languageSpoken":
            List<dynamic>.from(tcLanguageSpoken!.map((x) => x)),
        "tc_subject": List<dynamic>.from(tcSubject!.map((x) => x)),
        "tc_staffId": tcStaffId,
        "tc_schoolId": tcSchoolId,
        "tc_userType": tcUserType,
        "isFirstTimeLogin": isFirstTimeLogin,
        "tc_emailOtp": tcEmailOtp,
        "tc_id": tcId,
        "tc_education": tcEducation,
        "tc_altPhoneNumber": tcAltPhoneNumber,
        "tc_address": tcAddress,
        "tc_profilePic": tcProfilePic,
        "tc_degreeCertificate": tcDegreeCertificate,
        "tc_bloodGroup": tcBloodGroup,
        "tc_dateOfBirth": tcDateOfBirth,
        "tc_pincode": tcPincode,
        "tc_altEmail": tcAltEmail,
        "tc_oldDBId": tcOldDbId,
        "tc_register_password": tcRegisterPassword,
        "tc_phoneOtp": tcPhoneOtp,
        "forgotPasswordOtp": forgotPasswordOtp,
        "forgotPasswordPhoneOtp": forgotPasswordPhoneOtp,
        "tc_classRoomId": tcClassRoomId,
        "tc_alsoKnownAs": tcAlsoKnownAs,
      };
}
