class SelfAssessMentList {
  bool? status;
  String? message;
  Data? data;

  SelfAssessMentList({this.status, this.message, this.data});

  SelfAssessMentList.fromJson(Map<String, dynamic> json) {
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
  List<SelfAssessmentList>? selfAssessment;

  Data({this.selfAssessment});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['selfAssessment'] != null) {
      selfAssessment = <SelfAssessmentList>[];
      json['selfAssessment'].forEach((v) {
        selfAssessment!.add(new SelfAssessmentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.selfAssessment != null) {
      data['selfAssessment'] =
          this.selfAssessment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelfAssessmentList {
  int? saId;
  String? saTitle;
  String? saCategory;
  String? saSubCategory;
  String? saTopic;
  int? saScore;
  List<int>? saQuestions;
  int? stId;
  int? saDuration;
  int? saPassingMarks;
  int? saTotalMarks;
  String? saDateTime;
  String? saCreatedAt;

  SelfAssessmentList(
      {this.saId,
        this.saTitle,
        this.saCategory,
        this.saSubCategory,
        this.saTopic,
        this.saScore,
        this.saQuestions,
        this.stId,
        this.saDuration,
        this.saPassingMarks,
        this.saTotalMarks,
        this.saDateTime,
        this.saCreatedAt});

  SelfAssessmentList.fromJson(Map<String, dynamic> json) {
    saId = json['sa_id'];
    saTitle = json['sa_title'];
    saCategory = json['sa_category'];
    saSubCategory = json['sa_subCategory'];
    saTopic = json['sa_topic'];
    saScore = json['sa_score'];
    saQuestions = json['sa_questions'].cast<int>();
    stId = json['st_id'];
    saDuration = json['sa_duration'];
    saPassingMarks = json['sa_passingMarks'];
    saTotalMarks = json['sa_totalMarks'];
    saDateTime = json['sa_date_time'];
    saCreatedAt = json['sa_createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sa_id'] = this.saId;
    data['sa_title'] = this.saTitle;
    data['sa_category'] = this.saCategory;
    data['sa_subCategory'] = this.saSubCategory;
    data['sa_topic'] = this.saTopic;
    data['sa_score'] = this.saScore;
    data['sa_questions'] = this.saQuestions;
    data['st_id'] = this.stId;
    data['sa_duration'] = this.saDuration;
    data['sa_passingMarks'] = this.saPassingMarks;
    data['sa_totalMarks'] = this.saTotalMarks;
    data['sa_date_time'] = this.saDateTime;
    data['sa_createdAt'] = this.saCreatedAt;
    return data;
  }
}