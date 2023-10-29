
import 'dart:convert';

QutionsAnswerModel qutionsAnswerModelFromJson(String str) =>
    QutionsAnswerModel.fromJson(json.decode(str));

String qutionsAnswerModelToJson(QutionsAnswerModel data) =>
    json.encode(data.toJson());

class QutionsAnswerModel {
  bool status;
  String message;
  List<Datum> data;

  QutionsAnswerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QutionsAnswerModel.fromJson(Map<String, dynamic> json) =>
      QutionsAnswerModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int aqId;
  String aqTitle;
  String aqOption1;
  String aqOption2;
  String aqOption3;
  String aqOption4;
  String aqOption5;
  List<String> aqCorrentAns;
  String aqAnswerType;

  Datum({
    required this.aqId,
    required this.aqTitle,
    required this.aqOption1,
    required this.aqOption2,
    required this.aqOption3,
    required this.aqOption4,
    required this.aqOption5,
    required this.aqCorrentAns,
    required this.aqAnswerType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        aqId: json["aq_id"],
        aqTitle: json["aq_title"],
        aqOption1: json["aq_option1"],
        aqOption2: json["aq_option2"],
        aqOption3: json["aq_option3"],
        aqOption4: json["aq_option4"],
        aqOption5: json["aq_option5"],
        aqCorrentAns: List<String>.from(json["aq_correntAns"].map((x) => x)),
        aqAnswerType: json["aq_answerType"],
      );

  Map<String, dynamic> toJson() => {
        "aq_id": aqId,
        "aq_title": aqTitle,
        "aq_option1": aqOption1,
        "aq_option2": aqOption2,
        "aq_option3": aqOption3,
        "aq_option4": aqOption4,
        "aq_option5": aqOption5,
        "aq_correntAns": List<dynamic>.from(aqCorrentAns.map((x) => x)),
        "aq_answerType": aqAnswerType,
      };

  String? getOption(int optionNumber) {
    switch (optionNumber) {
      case 1:
        return aqOption1;
      case 2:
        return aqOption2;
      case 3:
        return aqOption3;
      case 4:
        return aqOption4;
      case 5:
        return aqOption5;
      default:
        return null;
    }
  }
}
