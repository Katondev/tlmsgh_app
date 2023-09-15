class AssignmentResultModel {
  bool? status;
  String? message;
  Data? data;

  AssignmentResultModel({this.status, this.message, this.data});

  AssignmentResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  AssignmentResult? assignmentResult;

  Data({this.assignmentResult});

  Data.fromJson(Map<String, dynamic> json) {
    assignmentResult = json['assignmentResult'] != null
        ? new AssignmentResult.fromJson(json['assignmentResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assignmentResult != null) {
      data['assignmentResult'] = this.assignmentResult!.toJson();
    }
    return data;
  }
}

class AssignmentResult {
  int? arId;
  int? asnId;
  String? arAnswerKeys;
  int? arScore;
  int? stId;
  int? arTotalQuestion;
  int? arUnanswered;
  String? arSubmitTime;
  String? arDateTime;
  String? arCreatedAt;
  ArAssignment? arAssignment;

  AssignmentResult(
      {this.arId,
        this.asnId,
        this.arAnswerKeys,
        this.arScore,
        this.stId,
        this.arTotalQuestion,
        this.arUnanswered,
        this.arSubmitTime,
        this.arDateTime,
        this.arCreatedAt,
        this.arAssignment});

  AssignmentResult.fromJson(Map<String, dynamic> json) {
    arId = json['ar_id'];
    asnId = json['asn_id'];
    arAnswerKeys = json['ar_answerKeys'];
    arScore = json['ar_score'];
    stId = json['st_id'];
    arTotalQuestion = json['ar_totalQuestion'];
    arUnanswered = json['ar_unanswered'];
    arSubmitTime = json['ar_submitTime'];
    arDateTime = json['ar_dateTime'];
    arCreatedAt = json['ar_createdAt'];
    arAssignment = json['ar_assignment'] != null
        ? new ArAssignment.fromJson(json['ar_assignment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar_id'] = this.arId;
    data['asn_id'] = this.asnId;
    data['ar_answerKeys'] = this.arAnswerKeys;
    data['ar_score'] = this.arScore;
    data['st_id'] = this.stId;
    data['ar_totalQuestion'] = this.arTotalQuestion;
    data['ar_unanswered'] = this.arUnanswered;
    data['ar_submitTime'] = this.arSubmitTime;
    data['ar_dateTime'] = this.arDateTime;
    data['ar_createdAt'] = this.arCreatedAt;
    if (this.arAssignment != null) {
      data['ar_assignment'] = this.arAssignment!.toJson();
    }
    return data;
  }
}

class ArAssignment {
  int? asnId;
  String? asnTitle;
  int? asnTotalMarks;

  ArAssignment({this.asnId, this.asnTitle, this.asnTotalMarks});

  ArAssignment.fromJson(Map<String, dynamic> json) {
    asnId = json['asn_id'];
    asnTitle = json['asn_title'];
    asnTotalMarks = json['asn_totalMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asn_id'] = this.asnId;
    data['asn_title'] = this.asnTitle;
    data['asn_totalMarks'] = this.asnTotalMarks;
    return data;
  }
}