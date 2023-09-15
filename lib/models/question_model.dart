// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

QuestionModel questionModelFromJson(String str) =>
    QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  bool? status;
  String? message;
  Data? data;

  QuestionModel({
    this.status,
    this.message,
    this.data,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
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
  List<QuestionDatum>? questionData;
  int? totalMarks;
  int? passingMarks;
  int? marksPerQuestion;
  String? duration;
  List<TrainingQuestion>? trainingQuestions;
  String? title;

  Data({
    this.questionData,
    this.totalMarks,
    this.passingMarks,
    this.marksPerQuestion,
    this.duration,
    this.trainingQuestions,
    this.title,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        questionData: List<QuestionDatum>.from(
            json["question_data"].map((x) => QuestionDatum.fromJson(x))),
        totalMarks: json["total_marks"],
        passingMarks: json["passingMarks"],
        marksPerQuestion: json["marksPerQuestion"],
        duration: json["duration"],
        trainingQuestions: List<TrainingQuestion>.from(
            json["trainingQuestions"].map((x) => TrainingQuestion.fromJson(x))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "question_data":
            List<dynamic>.from(questionData!.map((x) => x.toJson())),
        "total_marks": totalMarks,
        "passingMarks": passingMarks,
        "marksPerQuestion": marksPerQuestion,
        "duration": duration,
        "trainingQuestions":
            List<dynamic>.from(trainingQuestions!.map((x) => x.toJson())),
        "title": title,
      };
}

class QuestionDatum {
  String? answer;
  List<String>? option;
  String? question;
  String? subject;
  String? subjectId;
  int? id;

  QuestionDatum({
    this.answer,
    this.option,
    this.question,
    this.subject,
    this.subjectId,
    this.id,
  });

  factory QuestionDatum.fromJson(Map<String, dynamic> json) => QuestionDatum(
        answer: json["answer"],
        option: List<String>.from(json["option"].map((x) => x)),
        question: json["question"],
        subject: json["subject"],
        subjectId: json["subjectId"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "option": List<dynamic>.from(option!.map((x) => x)),
        "question": question,
        "subject": subject,
        "subjectId": subjectId,
        "_id": id,
      };
}

class TrainingQuestion {
  int? atqId;
  dynamic teId;
  String? atqTitle;
  dynamic atqType;
  String? atqAnswerType;
  String? atqOption1;
  String? atqOption2;
  String? atqOption3;
  String? atqOption4;
  String? atqOption5;
  String? atqCategory;
  String? atqSubCategory;
  String? atqTopic;
  dynamic atqImage;
  String? atqQuestionStatement;
  List<String>? atqCorrentAns;
  String? atqQuestionType;
  int? atqMark;
  bool? atqStatus;
  String? atqCreatedAt;
  String? atqSection;
  int? tpId;

  TrainingQuestion({
    this.atqId,
    this.teId,
    this.atqTitle,
    this.atqType,
    this.atqAnswerType,
    this.atqOption1,
    this.atqOption2,
    this.atqOption3,
    this.atqOption4,
    this.atqOption5,
    this.atqCategory,
    this.atqSubCategory,
    this.atqTopic,
    this.atqImage,
    this.atqQuestionStatement,
    this.atqCorrentAns,
    this.atqQuestionType,
    this.atqMark,
    this.atqStatus,
    this.atqCreatedAt,
    this.atqSection,
    this.tpId,
  });

  factory TrainingQuestion.fromJson(Map<String, dynamic> json) =>
      TrainingQuestion(
        atqId: json["atq_id"],
        teId: json["te_id"],
        atqTitle: json["atq_title"],
        atqType: json["atq_type"],
        atqAnswerType: json["atq_answerType"],
        atqOption1: json["atq_option1"],
        atqOption2: json["atq_option2"],
        atqOption3: json["atq_option3"],
        atqOption4: json["atq_option4"],
        atqOption5: json["atq_option5"],
        atqCategory: json["atq_category"],
        atqSubCategory: json["atq_subCategory"],
        atqTopic: json["atq_topic"],
        atqImage: json["atq_image"],
        atqQuestionStatement: json["atq_questionStatement"],
        atqCorrentAns: List<String>.from(json["atq_correntAns"].map((x) => x)),
        atqQuestionType: json["atq_questionType"],
        atqMark: json["atq_mark"],
        atqStatus: json["atq_status"],
        atqCreatedAt: json["atq_createdAt"],
        atqSection: json["atq_section"],
        tpId: json["tp_id"],
      );

  Map<String, dynamic> toJson() => {
        "atq_id": atqId,
        "te_id": teId,
        "atq_title": atqTitle,
        "atq_type": atqType,
        "atq_answerType": atqAnswerType,
        "atq_option1": atqOption1,
        "atq_option2": atqOption2,
        "atq_option3": atqOption3,
        "atq_option4": atqOption4,
        "atq_option5": atqOption5,
        "atq_category": atqCategory,
        "atq_subCategory": atqSubCategory,
        "atq_topic": atqTopic,
        "atq_image": atqImage,
        "atq_questionStatement": atqQuestionStatement,
        "atq_correntAns": List<dynamic>.from(atqCorrentAns!.map((x) => x)),
        "atq_questionType": atqQuestionType,
        "atq_mark": atqMark,
        "atq_status": atqStatus,
        "atq_createdAt": atqCreatedAt,
        "atq_section": atqSection,
        "tp_id": tpId,
      };
}
