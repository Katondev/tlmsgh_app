import 'dart:convert';

class FilterCategoryModel {
  int? categoryId;
  String? maincategoryName;
  String? categoryName;
  int? subcategoryId;
  bool? isenabled;

  FilterCategoryModel({
    this.categoryId,
    this.maincategoryName,
    this.categoryName,
    this.subcategoryId,
    this.isenabled,
  });

  factory FilterCategoryModel.fromJson(Map<String, dynamic> json_) =>
      FilterCategoryModel(
        categoryId: json_["categoryId"],
        categoryName: json_["categoryName"],
        maincategoryName: json_["categoryTypeName"],
        subcategoryId: json_["subcategory"],
        isenabled: json_["isenabled"],
      );
  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "categoryTypeName": maincategoryName,
        "subcategory": subcategoryId,
        "isenabled": isenabled,
      };
  static Map<String, dynamic> toMap(FilterCategoryModel mCategory) => {
        "categoryId": mCategory.categoryId,
        "categoryName": mCategory.categoryName,
        "categoryTypeName": mCategory.maincategoryName,
        "subcategory": mCategory.subcategoryId,
        "isenabled": mCategory.isenabled,
      };

  static String encode(List<FilterCategoryModel> mainCategoryModel) =>
      json.encode(
        mainCategoryModel
            .map<Map<String, dynamic>>(
                (mainCategory) => FilterCategoryModel.toMap(mainCategory))
            .toList(),
      );

  static List<FilterCategoryModel> decode(String mainCategoryModel) => (json
          .decode(mainCategoryModel) as List<dynamic>)
      .map<FilterCategoryModel>((item) => FilterCategoryModel.fromJson(item))
      .toList();
}
// To parse this JSON data, do
//
//     final dropDownList = dropDownListFromJson(jsonString);


DropDownList dropDownListFromJson(String str) => DropDownList.fromJson(json.decode(str));

String dropDownListToJson(DropDownList data) => json.encode(data.toJson());

class DropDownList {
    bool status;
    String message;
    Data data;

    DropDownList({
        required this.status,
        required this.message,
        required this.data,
    });

    factory DropDownList.fromJson(Map<String, dynamic> json) => DropDownList(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    List<DataTopic> topics;

    Data({
        required this.topics,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        topics: List<DataTopic>.from(json["topics"].map((x) => DataTopic.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
    };
}

class DataTopic {
    int? levelId;
    String? level;
    List<Class>? classes;

    DataTopic({
      this.levelId,
       this.level,
     this.classes,
    });

    factory DataTopic.fromJson(Map<String, dynamic> json) => DataTopic(
        levelId: json["levelId"],
        level: json["level"],
        classes: List<Class>.from(json["classes"].map((x) => Class.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "levelId": levelId,
        "level": level,
        "classes": List<dynamic>.from(classes!.map((x) => x.toJson())),
    };
}

class Class {
    int? classId;
    String? classClass;
    List<Subjectt>? subjects;

    Class({
        this.classId,
         this.classClass,
        this.subjects,
    });

    factory Class.fromJson(Map<String, dynamic> json) => Class(
        classId: json["classId"],
        classClass: json["class"],
        subjects: List<Subjectt>.from(json["subjects"].map((x) => Subjectt.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "classId": classId,
        "class": classClass,
        "subjects": List<dynamic>.from(subjects!.map((x) => x.toJson())),
    };
}

class Subjectt {
    int? subjectId;
    String? subject;
    List<SubjectTopic>? topics;

    Subjectt({
        this.subjectId,
         this.subject,
        this.topics,
    });

    factory Subjectt.fromJson(Map<String, dynamic> json) => Subjectt(
        subjectId: json["subjectId"],
        subject: json["subject"],
        topics: List<SubjectTopic>.from(json["topics"].map((x) => SubjectTopic.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "subjectId": subjectId,
        "subject": subject,
        "topics": List<dynamic>.from(topics!.map((x) => x.toJson())),
    };
}

class SubjectTopic {
    int? topicId;
    String? topic;

    SubjectTopic({
         this.topicId,
        this.topic,
    });

    factory SubjectTopic.fromJson(Map<String, dynamic> json) => SubjectTopic(
        topicId: json["topicId"],
        topic: json["topic"],
    );

    Map<String, dynamic> toJson() => {
        "topicId": topicId,
        "topic": topic,
    };
}
