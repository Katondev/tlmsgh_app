import 'dart:convert';

class SignInModel {
  SignInModel({
    this.status,
    this.message,
    this.data,
  });

  SignInModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SignInData.fromJson(json['data']) : null;
  }

  bool? status;
  String? message;
  SignInData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class SignInData {
  Student? student;
  String? token;
  List<Classes>? classes;
  List<String>? divisions;
  List<String>? bloodGroups;
  List<Categories>? categories;
  List<Topics>? topics;
  List<CertificateList>? certificateList;
  List<CertificateList>? levelsList;
  List<CertificateList>? languagesList;
  List<Subject>? subjectList;
  SignInData({
    this.student,
    this.token,
    this.classes,
    this.divisions,
    this.bloodGroups,
    this.categories,
    this.topics,
    this.certificateList,
    this.levelsList,
    this.languagesList,
    this.subjectList,
  });

  SignInData.fromJson(dynamic json) {
    student =
        json['student'] != null ? Student.fromJson(json['student']) : null;
    token = json['token'];
    if (json['classes'] != null) {
      classes = [];
      json['classes'].forEach((v) {
        classes?.add(Classes.fromJson(v));
      });
    }

    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(new Topics.fromJson(v));
      });
    }
    divisions =
        json['divisions'] != null ? json['divisions'].cast<String>() : [];
    bloodGroups =
        json['bloodGroups'] != null ? json['bloodGroups'].cast<String>() : [];

    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    if (json['certificateList'] != null) {
      certificateList = [];
      json['certificateList'].forEach((v) {
        certificateList?.add(CertificateList.fromJson(v));
      });
    }
    if (json['levels'] != null) {
      levelsList = [];
      json['levels'].forEach((v) {
        levelsList?.add(CertificateList.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languagesList = [];
      json['languages'].forEach((v) {
        languagesList?.add(CertificateList.fromJson(v));
      });
    }
    if (json['subjects'] != null) {
      subjectList = [];
      json['subjects'].forEach((v) {
        subjectList?.add(Subject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (student != null) {
      map['student'] = student?.toJson();
    }
    map['token'] = token;
    if (classes != null) {
      map['classes'] = classes?.map((v) => v.toJson()).toList();
    }
    map['divisions'] = divisions;
    map['bloodGroups'] = bloodGroups;

    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }

    if (this.topics != null) {
      map['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    if (this.certificateList != null) {
      map['certificateList'] =
          this.certificateList!.map((v) => v.toJson()).toList();
    }
    if (this.levelsList != null) {
      map['levels'] = this.certificateList!.map((v) => v.toJson()).toList();
    }
    if (this.languagesList != null) {
      map['languages'] = this.languagesList!.map((v) => v.toJson()).toList();
    }
    if (this.subjectList != null) {
      map['subjects'] = this.subjectList!.map((v) => v.toJson()).toList();
    }

    return map;
  }
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

class StSchool {
  String? scSchoolName;

  StSchool({this.scSchoolName});

  StSchool.fromJson(Map<String, dynamic> json) {
    scSchoolName = json['sc_schoolName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sc_schoolName'] = this.scSchoolName;
    return data;
  }
}

class Classes {
  String? label;
  List<Options>? options;

  Classes({this.label, this.options});

  Classes.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String? label;
  String? value;

  Options({this.label, this.value});

  Options.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class Subject {
  String? label;
  String? value;

  Subject({
    this.label,
    this.value,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };

  static Map<String, dynamic> toMap(Subject mSub) => {
        "label": mSub.label,
        "value": mSub.value,
      };

  static String encode(List<Subject> subCategoryModel) => json.encode(
        subCategoryModel
            .map<Map<String, dynamic>>(
                (mainCategory) => Subject.toMap(mainCategory))
            .toList(),
      );

  static List<Subject> decode(String mainCategoryModel) =>
      (json.decode(mainCategoryModel) as List<dynamic>)
          .map<Subject>((item) => Subject.fromJson(item))
          .toList();
}

class Categories {
  int? categoryId;
  int? categoryType;
  String? categoryTypeName;
  String? categoryName;
  List<MainCategory>? category;

  Categories(
      {this.categoryId,
      this.categoryType,
      this.categoryTypeName,
      this.categoryName,
      this.category});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryType = json['categoryType'];
    categoryTypeName = json['categoryTypeName'];
    categoryName = json['categoryName'];
    if (json['category'] != null) {
      category = <MainCategory>[];
      json['category'].forEach((v) {
        category!.add(MainCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryType'] = categoryType;
    data['categoryTypeName'] = categoryTypeName;
    data['categoryName'] = categoryName;
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainCategory {
  int? categoryId;
  String? categoryTypeName;
  String? categoryName;
  List<SubCategory>? subCategory;

  MainCategory(
      {this.categoryId,
      this.categoryTypeName,
      this.categoryName,
      this.subCategory});

  MainCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryTypeName = json['categoryTypeName'];
    categoryName = json['categoryName'];
    if (json['subCategory'] != null) {
      subCategory = <SubCategory>[];
      json['subCategory'].forEach((v) {
        subCategory!.add(SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryTypeName'] = categoryTypeName;
    data['categoryName'] = categoryName;
    if (subCategory != null) {
      data['subCategory'] = subCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  int? subCateId;
  String? subCateName;

  SubCategory({this.subCateId, this.subCateName});

  SubCategory.fromJson(Map<String, dynamic> json) {
    subCateId = json['subCateId'];
    subCateName = json['subCateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subCateId'] = subCateId;
    data['subCateName'] = subCateName;
    return data;
  }
}

class Topics {
  int? ccId;
  int? ccCategoryType;
  String? ccCategoryTypeName;
  String? ccCategoryName;
  List<Category>? category;

  Topics(
      {this.ccId,
      this.ccCategoryType,
      this.ccCategoryTypeName,
      this.ccCategoryName,
      this.category});

  Topics.fromJson(Map<String, dynamic> json) {
    ccId = json['cc_id'];
    ccCategoryType = json['cc_categoryType'];
    ccCategoryTypeName = json['cc_categoryTypeName'];
    ccCategoryName = json['cc_categoryName'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cc_id'] = this.ccId;
    data['cc_categoryType'] = this.ccCategoryType;
    data['cc_categoryTypeName'] = this.ccCategoryTypeName;
    data['cc_categoryName'] = this.ccCategoryName;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? categoryId;
  String? categoryTypeName;
  String? categoryName;
  List<SubCategoryTopic>? subCategory;

  Category(
      {this.categoryId,
      this.categoryTypeName,
      this.categoryName,
      this.subCategory});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryTypeName = json['categoryTypeName'];
    categoryName = json['categoryName'];
    if (json['subCategory'] != null) {
      subCategory = <SubCategoryTopic>[];
      json['subCategory'].forEach((v) {
        subCategory!.add(new SubCategoryTopic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryTypeName'] = this.categoryTypeName;
    data['categoryName'] = this.categoryName;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryTopic {
  int? subCateId;
  String? subCateName;
  List<Topic>? topics;

  SubCategoryTopic({this.subCateId, this.subCateName, this.topics});

  SubCategoryTopic.fromJson(Map<String, dynamic> json) {
    subCateId = json['subCateId'];
    subCateName = json['subCateName'];
    if (json['topics'] != null) {
      topics = <Topic>[];
      json['topics'].forEach((v) {
        topics!.add(new Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCateId'] = this.subCateId;
    data['subCateName'] = this.subCateName;
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topic {
  int? topicId;
  String? topicName;

  Topic({this.topicId, this.topicName});

  Topic.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId'];
    topicName = json['topicName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicId'] = this.topicId;
    data['topicName'] = this.topicName;
    return data;
  }
}

class DropdownClasses {
  String? label;
  bool? enable;

  DropdownClasses({this.label, this.enable});
}

class DropdownRegion {
  String? region;
  String? district;
  bool? enable;

  DropdownRegion({this.region, this.district, this.enable});
}

class DropdownSchool {
  String? scSchoolId;
  String? scSchoolName;
  bool? enable;

  DropdownSchool({this.scSchoolId, this.scSchoolName, this.enable});
}

class DropdownSchoolTeacher {
  String? tcSchoolId;
  String? tcSchoolName;
  bool? enable;

  DropdownSchoolTeacher({this.tcSchoolId, this.tcSchoolName, this.enable});
}

class CertificateList {
  String? label;
  String? value;

  CertificateList({
    this.label,
    this.value,
  });

  CertificateList.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;

    return data;
  }
}

class DropdownCountrycode {
  String? countrycode;
  String? country;

  DropdownCountrycode({
    this.countrycode,
    this.country,
  });
}
