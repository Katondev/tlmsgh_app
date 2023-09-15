class SelfAssessMentQueModel {
  bool? status;
  String? message;
  Data? data;

  SelfAssessMentQueModel({this.status, this.message, this.data});

  SelfAssessMentQueModel.fromJson(Map<String, dynamic> json) {
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
  List<SelfQuestionData>? questionData;
  int? duration;
  SelfAssessment? selfAssessment;

  Data({this.questionData, this.duration, this.selfAssessment});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['question_data'] != null) {
      questionData = <SelfQuestionData>[];
      json['question_data'].forEach((v) {
        questionData!.add(new SelfQuestionData.fromJson(v));
      });
    }
    duration = json['duration'];
    selfAssessment = json['selfAssessment'] != null
        ? new SelfAssessment.fromJson(json['selfAssessment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionData != null) {
      data['question_data'] =
          this.questionData!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    if (this.selfAssessment != null) {
      data['selfAssessment'] = this.selfAssessment!.toJson();
    }
    return data;
  }
}

class SelfQuestionData {
  String? answer;
  List<String>? option;
  String? question;
  String? subjectId;
  int? marksPerQuestion;
  int? iId;

  SelfQuestionData(
      {this.answer,
        this.option,
        this.question,
        this.subjectId,
        this.marksPerQuestion,
        this.iId});

  SelfQuestionData.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    option = json['option'].cast<String>();
    question = json['question'];
    subjectId = json['subjectId'];
    marksPerQuestion = json['marksPerQuestion'];
    iId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['option'] = this.option;
    data['question'] = this.question;
    data['subjectId'] = this.subjectId;
    data['marksPerQuestion'] = this.marksPerQuestion;
    data['_id'] = this.iId;
    return data;
  }
}

class SelfAssessment {
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

  SelfAssessment(
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

  SelfAssessment.fromJson(Map<String, dynamic> json) {
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