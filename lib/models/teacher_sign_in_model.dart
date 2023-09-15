// import 'package:katon/models/sign_in_model.dart';

// class TeacherSignInModel {
//   TeacherSignInModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   TeacherSignInModel.fromJson(dynamic json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? TeacherData.fromJson(json['data']) : null;
//   }

//   bool? status;
//   String? message;
//   TeacherData? data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     if (data != null) {
//       map['data'] = data?.toJson();
//     }
//     return map;
//   }
// }

// class TeacherData {
//   TeacherData({
//     this.teacher,
//     this.token,
//     this.classes,
//     this.divisions,
//     this.bloodGroups,
//     this.categories,
//     this.certificateList,
//     this.levelsList,
//     this.languagesList,
//   });

//   TeacherData.fromJson(dynamic json) {
//     teacher =
//         json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
//     token = json['token'];
//     if (json['classes'] != null) {
//       classes = [];
//       json['classes'].forEach((v) {
//         classes?.add(Classes.fromJson(v));
//       });
//     }
//     divisions =
//         json['divisions'] != null ? json['divisions'].cast<String>() : [];
//     bloodGroups =
//         json['bloodGroups'] != null ? json['bloodGroups'].cast<String>() : [];

//     if (json['categories'] != null) {
//       categories = [];
//       json['categories'].forEach((v) {
//         categories?.add(Categories.fromJson(v));
//       });
//     }
//     if (json['certificateList'] != null) {
//       certificateList = [];
//       json['certificateList'].forEach((v) {
//         certificateList?.add(CertificateList.fromJson(v));
//       });
//     }
//     if (json['levels'] != null) {
//       levelsList = [];
//       json['levels'].forEach((v) {
//         levelsList?.add(CertificateList.fromJson(v));
//       });
//     }
//     if (json['languages'] != null) {
//       languagesList = [];
//       json['languages'].forEach((v) {
//         languagesList?.add(CertificateList.fromJson(v));
//       });
//     }
//   }
//   Teacher? teacher;
//   String? token;
//   List<Classes>? classes;
//   List<String>? divisions;
//   List<String>? bloodGroups;
//   List<Categories>? categories;
//   List<CertificateList>? certificateList;
//   List<CertificateList>? levelsList;
//   List<CertificateList>? languagesList;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (teacher != null) {
//       map['teacher'] = teacher?.toJson();
//     }
//     map['token'] = token;
//     if (classes != null) {
//       map['classes'] = classes?.map((v) => v.toJson()).toList();
//     }
//     map['divisions'] = divisions;
//     map['bloodGroups'] = bloodGroups;

//     if (categories != null) {
//       map['categories'] = categories?.map((v) => v.toJson()).toList();
//     }
//     if (certificateList != null) {
//       map['certificateList'] = certificateList?.map((v) => v.toJson()).toList();
//     }
//     if (this.levelsList != null) {
//       map['levels'] = this.certificateList!.map((v) => v.toJson()).toList();
//     }
//     if (this.languagesList != null) {
//       map['languages'] = this.languagesList!.map((v) => v.toJson()).toList();
//     }

//     return map;
//   }
// }

// class Teacher {
//   int? tcId;
//   String? tcFullName;
//   String? tcEmail;
//   String? tcStaffId;
//   int? isFirstTimeLogin;
//   int? tcSchoolId;
//   String? tcEducation;
//   String? tcPhoneNumber;
//   String? tcAltPhoneNumber;
//   String? tcAddress;
//   String? tcProfilePic;
//   Null tcDegreeCertificate;
//   int? tcStatus;
//   String? tcCreatedAt;
//   String? tcBloodGroup;
//   Null tcDateOfBirth;
//   String? tcCountry;
//   String? tcPincode;
//   String? tcRegion;
//   String? tcDistrict;
//   String? tcCircuit;
//   String? tcAltEmail;
//   int? tcCountryCode;

//   Teacher(
//       {this.tcId,
//       this.tcFullName,
//       this.tcEmail,
//       this.tcStaffId,
//       this.isFirstTimeLogin,
//       this.tcSchoolId,
//       this.tcEducation,
//       this.tcPhoneNumber,
//       this.tcAltPhoneNumber,
//       this.tcAddress,
//       this.tcProfilePic,
//       this.tcDegreeCertificate,
//       this.tcStatus,
//       this.tcCreatedAt,
//       this.tcBloodGroup,
//       this.tcDateOfBirth,
//       this.tcCountry,
//       this.tcPincode,
//       this.tcRegion,
//       this.tcDistrict,
//       this.tcCircuit,
//       this.tcAltEmail,
//       this.tcCountryCode});

//   Teacher.fromJson(Map<String, dynamic> json) {
//     tcId = json['tc_id'];
//     tcFullName = json['tc_fullName'];
//     tcEmail = json['tc_email'];
//     tcStaffId = json['tc_staffId'];
//     isFirstTimeLogin = json['isFirstTimeLogin'];
//     tcSchoolId = json['tc_schoolId'];
//     tcEducation = json['tc_education'];
//     tcPhoneNumber = json['tc_phoneNumber'];
//     tcAltPhoneNumber = json['tc_altPhoneNumber'];
//     tcAddress = json['tc_address'];
//     tcProfilePic = json['tc_profilePic'];
//     tcDegreeCertificate = json['tc_degreeCertificate'];
//     tcStatus = json['tc_status'];
//     tcCreatedAt = json['tc_createdAt'];
//     tcBloodGroup = json['tc_bloodGroup'];
//     tcDateOfBirth = json['tc_dateOfBirth'];
//     tcCountry = json['tc_country'];
//     tcPincode = json['tc_pincode'];
//     tcRegion = json['tc_region'];
//     tcDistrict = json['tc_district'];
//     tcCircuit = json['tc_circuit'];
//     tcAltEmail = json['tc_altEmail'];
//     tcCountryCode = json['tc_countryCode'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['tc_id'] = this.tcId;
//     data['tc_fullName'] = this.tcFullName;
//     data['tc_email'] = this.tcEmail;
//     data['tc_staffId'] = this.tcStaffId;
//     data['isFirstTimeLogin'] = this.isFirstTimeLogin;
//     data['tc_schoolId'] = this.tcSchoolId;
//     data['tc_education'] = this.tcEducation;
//     data['tc_phoneNumber'] = this.tcPhoneNumber;
//     data['tc_altPhoneNumber'] = this.tcAltPhoneNumber;
//     data['tc_address'] = this.tcAddress;
//     data['tc_profilePic'] = this.tcProfilePic;
//     data['tc_degreeCertificate'] = this.tcDegreeCertificate;
//     data['tc_status'] = this.tcStatus;
//     data['tc_createdAt'] = this.tcCreatedAt;
//     data['tc_bloodGroup'] = this.tcBloodGroup;
//     data['tc_dateOfBirth'] = this.tcDateOfBirth;
//     data['tc_country'] = this.tcCountry;
//     data['tc_pincode'] = this.tcPincode;
//     data['tc_region'] = this.tcRegion;
//     data['tc_district'] = this.tcDistrict;
//     data['tc_circuit'] = this.tcCircuit;
//     data['tc_altEmail'] = this.tcAltEmail;
//     data['tc_countryCode'] = this.tcCountryCode;
//     return data;
//   }
// }

// class Country {
//   String? label;
//   int? value;

//   Country({this.label, this.value});

//   Country.fromJson(Map<String, dynamic> json) {
//     label = json['label'];
//     value = json['value'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['label'] = this.label;
//     data['value'] = this.value;
//     return data;
//   }
// }

// class Region {
//   int? arId;
//   String? arTitle;
//   String? arType;

//   Region({this.arId, this.arTitle, this.arType});

//   Region.fromJson(Map<String, dynamic> json) {
//     arId = json['ar_id'];
//     arTitle = json['ar_title'];
//     arType = json['ar_type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ar_id'] = this.arId;
//     data['ar_title'] = this.arTitle;
//     data['ar_type'] = this.arType;
//     return data;
//   }
// }

// import 'package:katon/models/sign_in_model.dart';

// class TeacherProfileModel {
//   TeacherProfileModel({
//     bool? status,
//     String? message,
//     TeacherData? data,
//   }) {
//     _status = status;
//     _message = message;
//     _data = data;
//   }

//   TeacherProfileModel.fromJson(dynamic json) {
//     _status = json['status'];
//     _message = json['message'];
//     _data = json['data'] != null ? TeacherData.fromJson(json['data']) : null;
//   }
//   bool? _status;
//   String? _message;
//   TeacherData? _data;

//   bool? get status => _status;
//   String? get message => _message;
//   TeacherData? get data => _data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = _status;
//     map['message'] = _message;
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     return map;
//   }
// }

// class TeacherData {
//   // TeacherData({
//   TeacherProfile? teacherProfile;
//   List<CertificateList>? certificateList;
//   List<CertificateList>? levelsList;
//   List<CertificateList>? languagesList;

//   TeacherData({
//     this.teacherProfile,
//     this.certificateList,
//     this.levelsList,
//     this.languagesList,
//   });

//   // }) {
//   //   _teacherProfile = teacherProfile;
//   //   _certificateList = certificateList;
//   //   _levelsList = levelsList;
//   //   _languagesList = languagesList;
//   // }

//   TeacherData.fromJson(dynamic json) {
//     _teacherProfile = json['teacherProfile'] != null
//         ? TeacherProfile.fromJson(json['teacherProfile'])
//         : null;

//     if (json['certificateList'] != null) {
//       _certificateList = [];
//       json['certificateList'].forEach((v) {
//         _certificateList?.add(CertificateList.fromJson(v));
//       });
//     }
//     if (json['levels'] != null) {
//       _levelsList = [];
//       json['levels'].forEach((v) {
//         _levelsList?.add(CertificateList.fromJson(v));
//       });
//     }
//     if (json['languages'] != null) {
//       _languagesList = [];
//       json['languages'].forEach((v) {
//         _languagesList?.add(CertificateList.fromJson(v));
//       });
//     }
//   }
//   TeacherProfile? _teacherProfile;
//   List<CertificateList>? _certificateList;
//   List<CertificateList>? _levelsList;
//   List<CertificateList>? _languagesList;

//   // TeacherProfile? get teacherProfile => _teacherProfile;
//   // List<CertificateList>? get certificateList => _certificateList;
//   // List<CertificateList>? get levelsList => _levelsList;
//   // List<CertificateList>? get languagesList => _languagesList;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_teacherProfile != null) {
//       map['teacherProfile'] = _teacherProfile?.toJson();
//     }
//     if (this._certificateList != null) {
//       map['certificateList'] =
//           this._certificateList!.map((v) => v.toJson()).toList();
//     }
//     if (this._levelsList != null) {
//       map['levels'] = this._levelsList!.map((v) => v.toJson()).toList();
//     }
//     if (this._languagesList != null) {
//       map['languages'] = this._languagesList!.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

// class TeacherProfile {
//   TeacherProfile({
//     int? tcId,
//     String? tcFullName,
//     String? tcEmail,
//     String? tcStaffId,
//     int? tcSchoolId,
//     String? tcAlsoknownas,
//     String? tcbriefProfile,
//     String? tcEducation,
//     String? tcPhoneNumber,
//     String? tcAltPhoneNumber,
//     String? tcAddress,
//     String? tcProfilePic,
//     dynamic tcDegreeCertificate,
//     int? tcStatus,
//     String? tcCreatedAt,
//     String? tcBloodGroup,
//     dynamic tcDateOfBirth,
//     String? tcCountry,
//     String? tcPincode,
//     String? tcRegion,
//     String? tcDistrict,
//     String? tcCircuit,
//     String? tcAltEmail,
//     int? tcCountryCode,
//     dynamic tcClassRoomId,
//     dynamic tcSubject,
//   }) {
//     _tcId = tcId;
//     _tcFullName = tcFullName;
//     _tcEmail = tcEmail;
//     _tcStaffId = tcStaffId;
//     _tcSchoolId = tcSchoolId;
//     _tcAlsoknownas = tcAlsoknownas;
//     _tcbriefProfile = tcbriefProfile;
//     _tcEducation = tcEducation;
//     _tcPhoneNumber = tcPhoneNumber;
//     _tcAltPhoneNumber = tcAltPhoneNumber;
//     _tcAddress = tcAddress;
//     _tcProfilePic = tcProfilePic;
//     _tcDegreeCertificate = tcDegreeCertificate;
//     _tcStatus = tcStatus;
//     _tcCreatedAt = tcCreatedAt;
//     _tcBloodGroup = tcBloodGroup;
//     _tcDateOfBirth = tcDateOfBirth;
//     _tcCountry = tcCountry;
//     _tcPincode = tcPincode;
//     _tcRegion = tcRegion;
//     _tcDistrict = tcDistrict;
//     _tcCircuit = tcCircuit;
//     _tcAltEmail = tcAltEmail;
//     _tcCountryCode = tcCountryCode;
//     _tcClassRoomId = tcClassRoomId;
//     _tcSubject = tcSubject;
//   }

//   TeacherProfile.fromJson(dynamic json) {
//     _tcId = json['tc_id'];
//     _tcFullName = json['tc_fullName'];
//     _tcEmail = json['tc_email'];
//     _tcStaffId = json['tc_staffId'];
//     _tcSchoolId = json['tc_schoolId'];
//     _tcAlsoknownas = json['tc_alsoKnownAs'];
//     _tcbriefProfile = json['tc_briefProfile'];
//     _tcEducation = json['tc_education'];
//     _tcPhoneNumber = json['tc_phoneNumber'];
//     _tcAltPhoneNumber = json['tc_altPhoneNumber'];
//     _tcAddress = json['tc_address'];
//     _tcProfilePic = json['tc_profilePic'];
//     _tcDegreeCertificate = json['tc_degreeCertificate'];
//     _tcStatus = json['"tc_status": 1,'];
//     _tcCreatedAt = json['tc_createdAt'];
//     _tcBloodGroup = json['tc_bloodGroup'];
//     _tcDateOfBirth = json['tc_dateOfBirth'];
//     _tcCountry = json['tc_country'];
//     _tcPincode = json['tc_pincode'];
//     _tcRegion = json['tc_region'];
//     _tcDistrict = json['tc_district'];
//     _tcCircuit = json['tc_circuit'];
//     _tcAltEmail = json['tc_altEmail'];
//     _tcCountryCode = json['tc_countryCode'];
//     _tcClassRoomId = json['tc_classRoomId'];
//     _tcSubject = json['tc_subject'];
//   }
//   int? _tcId;
//   String? _tcFullName;
//   String? _tcEmail;
//   String? _tcStaffId;
//   int? _tcSchoolId;
//   String? _tcAlsoknownas;
//   String? _tcbriefProfile;
//   String? _tcEducation;
//   String? _tcPhoneNumber;
//   String? _tcAltPhoneNumber;
//   String? _tcAddress;
//   String? _tcProfilePic;
//   dynamic _tcDegreeCertificate;
//   int? _tcStatus;
//   String? _tcCreatedAt;
//   String? _tcBloodGroup;
//   dynamic _tcDateOfBirth;
//   String? _tcCountry;
//   String? _tcPincode;
//   String? _tcRegion;
//   String? _tcDistrict;
//   String? _tcCircuit;
//   String? _tcAltEmail;
//   int? _tcCountryCode;
//   dynamic _tcClassRoomId;
//   dynamic _tcSubject;

//   int? get tcId => _tcId;
//   String? get tcFullName => _tcFullName;
//   String? get tcEmail => _tcEmail;
//   String? get tcStaffId => _tcStaffId;
//   int? get tcSchoolId => _tcSchoolId;
//   String? get tcAlsoknownas => _tcAlsoknownas;
//   String? get tcbriefProfile => _tcbriefProfile;
//   String? get tcEducation => _tcEducation;
//   String? get tcPhoneNumber => _tcPhoneNumber;
//   String? get tcAltPhoneNumber => _tcAltPhoneNumber;
//   String? get tcAddress => _tcAddress;
//   String? get tcProfilePic => _tcProfilePic;
//   dynamic get tcDegreeCertificate => _tcDegreeCertificate;
//   int? get tcStatus => _tcStatus;
//   String? get tcCreatedAt => _tcCreatedAt;
//   String? get tcBloodGroup => _tcBloodGroup;
//   dynamic get tcDateOfBirth => _tcDateOfBirth;
//   String? get tcCountry => _tcCountry;
//   String? get tcPincode => _tcPincode;
//   String? get tcRegion => _tcRegion;
//   String? get tcDistrict => _tcDistrict;
//   String? get tcCircuit => _tcCircuit;
//   String? get tcAltEmail => _tcAltEmail;
//   int? get tcCountryCode => _tcCountryCode;
//   dynamic get tcClassRoomId => _tcClassRoomId;
//   dynamic get tcSubject => _tcSubject;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['tc_id'] = _tcId;
//     map['tc_fullName'] = _tcFullName;
//     map['tc_email'] = _tcEmail;
//     map['tc_staffId'] = _tcStaffId;
//     map['tc_schoolId'] = _tcSchoolId;
//     map['tc_alsoKnownAs'] = _tcAlsoknownas;
//     map['tc_education'] = _tcEducation;
//     map['tc_phoneNumber'] = _tcPhoneNumber;
//     map['tc_altPhoneNumber'] = _tcAltPhoneNumber;
//     map['tc_address'] = _tcAddress;
//     map['tc_profilePic'] = _tcProfilePic;
//     map['tc_degreeCertificate'] = _tcDegreeCertificate;
//     map['tc_status'] = _tcStatus;
//     map['tc_createdAt'] = _tcCreatedAt;
//     map['tc_bloodGroup'] = _tcBloodGroup;
//     map['tc_dateOfBirth'] = _tcDateOfBirth;
//     map['tc_country'] = _tcCountry;
//     map['tc_pincode'] = _tcPincode;
//     map['tc_region'] = _tcRegion;
//     map['tc_district'] = _tcDistrict;
//     map['tc_circuit'] = _tcCircuit;
//     map['tc_altEmail'] = _tcAltEmail;
//     map['tc_countryCode'] = _tcCountryCode;
//     map['tc_classRoomId'] = _tcClassRoomId;
//     map['tc_subject'] = _tcSubject;
//     return map;
//   }
// }

// To parse this JSON data, do
//
//     final teacherProfileModel = teacherProfileModelFromJson(jsonString);

import 'dart:convert';

TeacherSignInModel teacherProfileModelFromJson(String str) =>
    TeacherSignInModel.fromJson(json.decode(str));

String teacherProfileModelToJson(TeacherSignInModel data) =>
    json.encode(data.toJson());

class TeacherSignInModel {
  bool? status;
  String? message;
  TeacherData? data;

  TeacherSignInModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherSignInModel.fromJson(Map<String, dynamic> json) =>
      TeacherSignInModel(
        status: json["status"],
        message: json["message"],
        data: TeacherData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class TeacherData {
  Teacher? teacher;
  String? token;
  List<String>? bloodGroups;
  List<CertificatesList>? certificateList;
  List<CertificatesList>? levels;
  List<CertificatesList>? languages;
  List<CertificatesList>? subjects;
  List<MainCategory>? mainCategories;
  List<SubCategoryElement>? categories;
  List<SubCategoryElement>? subCategories;

  TeacherData({
    this.teacher,
    this.token,
    this.bloodGroups,
    this.certificateList,
    this.levels,
    this.languages,
    this.subjects,
    this.mainCategories,
    this.categories,
    this.subCategories,
  });

  factory TeacherData.fromJson(Map<String, dynamic> json) => TeacherData(
        teacher: Teacher.fromJson(json["teacher"]),
        token: json["token"],
        bloodGroups: List<String>.from(json["bloodGroups"].map((x) => x)),
        certificateList: List<CertificatesList>.from(
            json["certificateList"].map((x) => CertificatesList.fromJson(x))),
        levels: List<CertificatesList>.from(
            json["levels"].map((x) => CertificatesList.fromJson(x))),
        languages: List<CertificatesList>.from(
            json["languages"].map((x) => CertificatesList.fromJson(x))),
        subjects: List<CertificatesList>.from(
            json["subjects"].map((x) => CertificatesList.fromJson(x))),
        mainCategories: List<MainCategory>.from(
            json["mainCategories"].map((x) => MainCategory.fromJson(x))),
        categories: List<SubCategoryElement>.from(
            json["categories"].map((x) => SubCategoryElement.fromJson(x))),
        subCategories: List<SubCategoryElement>.from(
            json["subCategories"].map((x) => SubCategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "teacher": teacher!.toJson(),
        "token": token,
        "bloodGroups": List<dynamic>.from(bloodGroups!.map((x) => x)),
        "certificateList":
            List<dynamic>.from(certificateList!.map((x) => x.toJson())),
        "levels": List<dynamic>.from(levels!.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects!.map((x) => x.toJson())),
        "mainCategories":
            List<dynamic>.from(mainCategories!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "subCategories":
            List<dynamic>.from(subCategories!.map((x) => x.toJson())),
      };
}

class SubCategoryElement {
  int categoryId;
  int categoryType;
  String categoryTypeName;
  String categoryName;
  List<CategoryCategory> category;

  SubCategoryElement({
    required this.categoryId,
    required this.categoryType,
    required this.categoryTypeName,
    required this.categoryName,
    required this.category,
  });

  factory SubCategoryElement.fromJson(Map<String, dynamic> json) =>
      SubCategoryElement(
        categoryId: json["categoryId"],
        categoryType: json["categoryType"],
        categoryTypeName: json["categoryTypeName"],
        categoryName: json["categoryName"],
        category: List<CategoryCategory>.from(
            json["category"].map((x) => CategoryCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryType": categoryType,
        "categoryTypeName": categoryTypeName,
        "categoryName": categoryName,
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class CategoryCategory {
  int categoryId;
  String categoryTypeName;
  String categoryName;
  List<SubCategory> subCategory;

  CategoryCategory({
    required this.categoryId,
    required this.categoryTypeName,
    required this.categoryName,
    required this.subCategory,
  });

  factory CategoryCategory.fromJson(Map<String, dynamic> json) =>
      CategoryCategory(
        categoryId: json["categoryId"],
        categoryTypeName: json["categoryTypeName"],
        categoryName: json["categoryName"],
        subCategory: List<SubCategory>.from(
            json["subCategory"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryTypeName": categoryTypeName,
        "categoryName": categoryName,
        "subCategory": List<dynamic>.from(subCategory.map((x) => x.toJson())),
      };
}

enum CategoryTypeName { CURRICULUM }

final categoryTypeNameValues =
    EnumValues({"curriculum": CategoryTypeName.CURRICULUM});

class SubCategory {
  int subCateId;
  String subCateName;

  SubCategory({
    required this.subCateId,
    required this.subCateName,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        subCateId: json["subCateId"],
        subCateName: json["subCateName"],
      );

  Map<String, dynamic> toJson() => {
        "subCateId": subCateId,
        "subCateName": subCateName,
      };
}

class CertificatesList {
  String? label;
  String? value;

  CertificatesList({
    this.label,
    this.value,
  });

  factory CertificatesList.fromJson(Map<String, dynamic> json) =>
      CertificatesList(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}

class MainCategory {
  int ccId;
  int ccCategoryType;
  CategoryTypeName ccCategoryTypeName;
  String ccCategoryTag;
  String ccCategoryName;

  MainCategory({
    required this.ccId,
    required this.ccCategoryType,
    required this.ccCategoryTypeName,
    required this.ccCategoryTag,
    required this.ccCategoryName,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
        ccId: json["cc_id"],
        ccCategoryType: json["cc_categoryType"],
        ccCategoryTypeName:
            categoryTypeNameValues.map[json["cc_categoryTypeName"]]!,
        ccCategoryTag: json["cc_categoryTag"],
        ccCategoryName: json["cc_categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "cc_id": ccId,
        "cc_categoryType": ccCategoryType,
        "cc_categoryTypeName":
            categoryTypeNameValues.reverse[ccCategoryTypeName],
        "cc_categoryTag": ccCategoryTag,
        "cc_categoryName": ccCategoryName,
      };
}

class Teacher {
  int? tcId;
  String? tcFullName;
  String? tcEmail;
  String? tcStaffId;
  int? tcSchoolId;
  dynamic tcEducation;
  String? tcPhoneNumber;
  dynamic tcAltPhoneNumber;
  dynamic tcAddress;
  dynamic tcProfilePic;
  dynamic tcDegreeCertificate;
  int? tcStatus;
  String? tcCreatedAt;
  dynamic tcBloodGroup;
  dynamic tcDateOfBirth;
  String? tcCountry;
  dynamic tcPincode;
  String? tcRegion;
  String? tcDistrict;
  dynamic tcCircuit;
  String? tcAltEmail;
  int? tcCountryCode;
  dynamic tcOldDbId;
  bool? tcIsEmailVerified;
  bool? tcIsPhoneVerified;
  dynamic tcRegisterPassword;
  dynamic tcEmailOtp;
  dynamic tcPhoneOtp;
  dynamic forgotPasswordOtp;
  dynamic forgotPasswordPhoneOtp;
  dynamic tcClassRoomId;
  dynamic tcSubject;
  bool? canCreateLiveClass;
  int? isFirstTimeLogin;
  dynamic tcAlsoKnownAs;
  dynamic tcExperience;
  dynamic tcBriefProfile;
  dynamic tcLanguageSpoken;
  dynamic tcCertificate;
  dynamic tcLevel;
  int? tcUserType;

  Teacher({
    this.tcId,
    this.tcFullName,
    this.tcEmail,
    this.tcStaffId,
    this.tcSchoolId,
    this.tcEducation,
    this.tcPhoneNumber,
    this.tcAltPhoneNumber,
    this.tcAddress,
    this.tcProfilePic,
    this.tcDegreeCertificate,
    this.tcStatus,
    this.tcCreatedAt,
    this.tcBloodGroup,
    this.tcDateOfBirth,
    this.tcCountry,
    this.tcPincode,
    this.tcRegion,
    this.tcDistrict,
    this.tcCircuit,
    this.tcAltEmail,
    this.tcCountryCode,
    this.tcOldDbId,
    this.tcIsEmailVerified,
    this.tcIsPhoneVerified,
    this.tcRegisterPassword,
    this.tcEmailOtp,
    this.tcPhoneOtp,
    this.forgotPasswordOtp,
    this.forgotPasswordPhoneOtp,
    this.tcClassRoomId,
    this.tcSubject,
    this.canCreateLiveClass,
    this.isFirstTimeLogin,
    this.tcAlsoKnownAs,
    this.tcExperience,
    this.tcBriefProfile,
    this.tcLanguageSpoken,
    this.tcCertificate,
    this.tcLevel,
    this.tcUserType,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        tcId: json["tc_id"],
        tcFullName: json["tc_fullName"],
        tcEmail: json["tc_email"],
        tcStaffId: json["tc_staffId"],
        tcSchoolId: json["tc_schoolId"],
        tcEducation: json["tc_education"],
        tcPhoneNumber: json["tc_phoneNumber"],
        tcAltPhoneNumber: json["tc_altPhoneNumber"],
        tcAddress: json["tc_address"],
        tcProfilePic: json["tc_profilePic"],
        tcDegreeCertificate: json["tc_degreeCertificate"],
        tcStatus: json["tc_status"],
        tcCreatedAt: json["tc_createdAt"],
        tcBloodGroup: json["tc_bloodGroup"],
        tcDateOfBirth: json["tc_dateOfBirth"],
        tcCountry: json["tc_country"],
        tcPincode: json["tc_pincode"],
        tcRegion: json["tc_region"],
        tcDistrict: json["tc_district"],
        tcCircuit: json["tc_circuit"],
        tcAltEmail: json["tc_altEmail"],
        tcCountryCode: json["tc_countryCode"],
        tcOldDbId: json["tc_oldDBId"],
        tcIsEmailVerified: json["tc_isEmailVerified"],
        tcIsPhoneVerified: json["tc_isPhoneVerified"],
        tcRegisterPassword: json["tc_register_password"],
        tcEmailOtp: json["tc_emailOtp"],
        tcPhoneOtp: json["tc_phoneOtp"],
        forgotPasswordOtp: json["forgotPasswordOtp"],
        forgotPasswordPhoneOtp: json["forgotPasswordPhoneOtp"],
        tcClassRoomId: json["tc_classRoomId"],
        tcSubject: json["tc_subject"],
        canCreateLiveClass: json["canCreateLiveClass"],
        isFirstTimeLogin: json["isFirstTimeLogin"],
        tcAlsoKnownAs: json["tc_alsoKnownAs"],
        tcExperience: json["tc_experience"],
        tcBriefProfile: json["tc_briefProfile"],
        tcLanguageSpoken: json["tc_languageSpoken"],
        tcCertificate: json["tc_certificate"],
        tcLevel: json["tc_level"],
        tcUserType: json["tc_userType"],
      );

  Map<String, dynamic> toJson() => {
        "tc_id": tcId,
        "tc_fullName": tcFullName,
        "tc_email": tcEmail,
        "tc_staffId": tcStaffId,
        "tc_schoolId": tcSchoolId,
        "tc_education": tcEducation,
        "tc_phoneNumber": tcPhoneNumber,
        "tc_altPhoneNumber": tcAltPhoneNumber,
        "tc_address": tcAddress,
        "tc_profilePic": tcProfilePic,
        "tc_degreeCertificate": tcDegreeCertificate,
        "tc_status": tcStatus,
        "tc_createdAt": tcCreatedAt,
        "tc_bloodGroup": tcBloodGroup,
        "tc_dateOfBirth": tcDateOfBirth,
        "tc_country": tcCountry,
        "tc_pincode": tcPincode,
        "tc_region": tcRegion,
        "tc_district": tcDistrict,
        "tc_circuit": tcCircuit,
        "tc_altEmail": tcAltEmail,
        "tc_countryCode": tcCountryCode,
        "tc_oldDBId": tcOldDbId,
        "tc_isEmailVerified": tcIsEmailVerified,
        "tc_isPhoneVerified": tcIsPhoneVerified,
        "tc_register_password": tcRegisterPassword,
        "tc_emailOtp": tcEmailOtp,
        "tc_phoneOtp": tcPhoneOtp,
        "forgotPasswordOtp": forgotPasswordOtp,
        "forgotPasswordPhoneOtp": forgotPasswordPhoneOtp,
        "tc_classRoomId": tcClassRoomId,
        "tc_subject": tcSubject,
        "canCreateLiveClass": canCreateLiveClass,
        "isFirstTimeLogin": isFirstTimeLogin,
        "tc_alsoKnownAs": tcAlsoKnownAs,
        "tc_experience": tcExperience,
        "tc_briefProfile": tcBriefProfile,
        "tc_languageSpoken": tcLanguageSpoken,
        "tc_certificate": tcCertificate,
        "tc_level": tcLevel,
        "tc_userType": tcUserType,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
