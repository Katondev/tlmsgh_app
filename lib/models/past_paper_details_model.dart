class PastPaperDetailModel {
  bool? status;
  String? message;
  Data? data;

  PastPaperDetailModel({this.status, this.message, this.data});

  PastPaperDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<QuestionData>? questionData;
  PastPaperData? pastPaperData;

  Data({this.questionData, this.pastPaperData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['question_data'] != null) {
      questionData = <QuestionData>[];
      json['question_data'].forEach((v) {
        questionData!.add(new QuestionData.fromJson(v));
      });
    }
    pastPaperData = json['pastPaperData'] != null
        ? new PastPaperData.fromJson(json['pastPaperData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionData != null) {
      data['question_data'] =
          this.questionData!.map((v) => v.toJson()).toList();
    }
    if (this.pastPaperData != null) {
      data['pastPaperData'] = this.pastPaperData!.toJson();
    }
    return data;
  }
}

class QuestionData {
  String? answer;
  List<String>? option;
  String? question;
  String? subjectId;
  int? iId;

  QuestionData(
      {this.answer, this.option, this.question, this.subjectId, this.iId});

  QuestionData.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    option = json['option'].cast<String>();
    question = json['question'];
    subjectId = json['subjectId'];
    iId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['option'] = this.option;
    data['question'] = this.question;
    data['subjectId'] = this.subjectId;
    data['_id'] = this.iId;
    return data;
  }
}

class PastPaperData {
  int? ppYear;
  String? ppBody;
  int? ppId;
  String? ppTitle;
  String? ppCategory;
  String? ppSubCategory;
  String? ppTopic;
  int? ppTotalMarks;

  PastPaperData(
      {this.ppYear,
      this.ppBody,
      this.ppId,
      this.ppTitle,
      this.ppCategory,
      this.ppSubCategory,
      this.ppTopic,
      this.ppTotalMarks});

  PastPaperData.fromJson(Map<String, dynamic> json) {
    ppYear = json['pp_year'];
    ppBody = json['pp_body'];
    ppId = json['pp_id'];
    ppTitle = json['pp_title'];
    ppCategory = json['pp_category'];
    ppSubCategory = json['pp_subCategory'];
    ppTopic = json['pp_topic'];
    ppTotalMarks = json['pp_totalMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pp_year'] = this.ppYear;
    data['pp_body'] = this.ppBody;
    data['pp_id'] = this.ppId;
    data['pp_title'] = this.ppTitle;
    data['pp_category'] = this.ppCategory;
    data['pp_subCategory'] = this.ppSubCategory;
    data['pp_topic'] = this.ppTopic;
    data['pp_totalMarks'] = this.ppTotalMarks;
    return data;
  }
}
