class AssignmentModel {
  AssignmentModel({
      this.status, 
      this.message, 
      this.data,});

  AssignmentModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;

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

class Data {
  Data({
      this.assignment,});

  Data.fromJson(dynamic json) {
    if (json['assignment'] != null) {
      assignment = [];
      json['assignment'].forEach((v) {
        assignment?.add(Assignment.fromJson(v));
      });
    }
  }
  List<Assignment>? assignment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (assignment != null) {
      map['assignment'] = assignment?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Assignment {
  Assignment({
      this.asnId, 
      this.tcId, 
      this.asnTitle, 
      this.asnTotalMarks, 
      this.asnDuration, 
      this.asnMarkPerQue, 
      this.asnMainCategory, 
      this.asnCategory, 
      this.asnSubCategory, 
      this.asnIsDateRange, 
      this.asnStartDate, 
      this.asnEndDate, 
      this.asnPassingMarks, 
      this.asnQuestionSetType, 
      this.asnStatus, 
      this.asnCreatedAt, 
      this.asnTeacher,});

  Assignment.fromJson(dynamic json) {
    asnId = json['asn_id'];
    tcId = json['tc_id'];
    asnTitle = json['asn_title'];
    asnTotalMarks = json['asn_totalMarks'];
    asnDuration = json['asn_duration'];
    asnMarkPerQue = json['asn_markPerQue'];
    asnMainCategory = json['asn_mainCategory'];
    asnCategory = json['asn_category'];
    asnSubCategory = json['asn_subCategory'];
    asnIsDateRange = json['asn_isDateRange'];
    asnStartDate = json['asn_startDate'];
    asnEndDate = json['asn_endDate'];
    asnPassingMarks = json['asn_passingMarks'];
    asnQuestionSetType = json['asn_questionSetType'];
    asnStatus = json['asn_status'];
    asnCreatedAt = json['asn_createdAt'];
    asn_isCheckResult = json['asn_isCheckResult'];
    asnTeacher = json['asn_teacher'] != null ? AsnTeacher.fromJson(json['asn_teacher']) : null;
  }
  int? asnId;
  int? tcId;
  String? asnTitle;
  int? asnTotalMarks;
  String? asnDuration;
  int? asnMarkPerQue;
  String? asnMainCategory;
  String? asnCategory;
  String? asnSubCategory;
  bool? asnIsDateRange;
  String? asnStartDate;
  String? asnEndDate;
  int? asnPassingMarks;
  String? asnQuestionSetType;
  bool? asnStatus;
  String? asnCreatedAt;
  bool? asn_isCheckResult;
  AsnTeacher? asnTeacher;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asn_id'] = asnId;
    map['tc_id'] = tcId;
    map['asn_title'] = asnTitle;
    map['asn_totalMarks'] = asnTotalMarks;
    map['asn_duration'] = asnDuration;
    map['asn_markPerQue'] = asnMarkPerQue;
    map['asn_mainCategory'] = asnMainCategory;
    map['asn_category'] = asnCategory;
    map['asn_subCategory'] = asnSubCategory;
    map['asn_isDateRange'] = asnIsDateRange;
    map['asn_startDate'] = asnStartDate;
    map['asn_endDate'] = asnEndDate;
    map['asn_passingMarks'] = asnPassingMarks;
    map['asn_questionSetType'] = asnQuestionSetType;
    map['asn_status'] = asnStatus;
    map['asn_isCheckResult'] = asn_isCheckResult;
    map['asn_createdAt'] = asnCreatedAt;
    if (asnTeacher != null) {
      map['asn_teacher'] = asnTeacher?.toJson();
    }
    return map;
  }

}

class AsnTeacher {
  AsnTeacher({
      this.tcFullName, 
      this.tcProfilePic,});

  AsnTeacher.fromJson(dynamic json) {
    tcFullName = json['tc_fullName'];
    tcProfilePic = json['tc_profilePic'];
  }
  String? tcFullName;
  String? tcProfilePic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tc_fullName'] = tcFullName;
    map['tc_profilePic'] = tcProfilePic;
    return map;
  }

}