import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:katon/utils/constants.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/loader.dart';

class PastMultipleQuestionsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<AssignmentQuestion> questions = [];
  List<String> selectedAnswers = [];
   List<String>? correctAnswerList;
  List<Map<String, Color>> resultColors = [];
  bool viewResult = false;
  bool isCorrect = false;

  Future<void> fetchDataFromApi(BuildContext context, int ppId) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          "https://user.api.tlmsghdev.in/api/v1/student/all-Questions/getAll?pp_id=${ppId.toString()}"));
          // print(ppId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        print(ppId);

        final List<dynamic> questionList = data['data']['assignmentQuestions'];
        questions = questionList.map((json) => AssignmentQuestion.fromJson(json)).toList();
        selectedAnswers = List.filled(questions.length, '');

        resultColors = List.generate(questions.length, (index) {
          return {
            'option1': Colors.white,
            'option2': Colors.white,
            'option3': Colors.white,
            'option4': Colors.white,
            'option5': Colors.white,
          };
        });

        isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      print(error);
      isLoading = false;
      notifyListeners();
    }
  }

  void handleRadioValueChanged(int questionIndex, String selectedOption) {
    selectedAnswers[questionIndex] = selectedOption;
    notifyListeners();
  }

  void submitAnswers(BuildContext context) {
    if (selectedAnswers.contains('')) {
      Fluttertoast.showToast(
        msg: "Please attempt all questions",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.black,
        textColor: AppColors.white,
        fontSize: 16.0,
      );
    } else {
      int correctAnswersCount = 0;

      for (int i = 0; i < questions.length; i++) {
        isCorrect = false;
        String correctAnswers = questions[i]
            .aqCorrentAns
            .join(', ')
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll(RegExp(r'\s+'), ' ');

        String userAnswer = selectedAnswers[i];
        userAnswer = userAnswer.replaceAll('aq', '').replaceAll('O', 'o');

        correctAnswerList = correctAnswers.split(',').map((e) => e.trim()).toList();

        if (correctAnswerList!.contains(userAnswer)) {
          isCorrect = true;
          resultColors[i][userAnswer] = Colors.green;
        } else {
          resultColors[i][correctAnswerList![0]] = Colors.green;
          resultColors[i][userAnswer] = Colors.red;
        }

        if (isCorrect) {
          correctAnswersCount++;
        }
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Your Score:',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    "$correctAnswersCount",
                    style: TextStyle(
                      color: correctAnswersCount == 5 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    correctAnswersCount == 5 ? "You have passed" : "You Failed",
                    style: TextStyle(
                      color: correctAnswersCount == 5 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      viewResult = true;
                      notifyListeners();
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "View Result",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
}

class PastMultipleQuestions extends StatefulWidget {
  final ppId;

  PastMultipleQuestions({Key? key, required this.ppId}) : super(key: key);

  @override
  _PastMultipleQuestionsState createState() => _PastMultipleQuestionsState();
}

class _PastMultipleQuestionsState extends State<PastMultipleQuestions> {
  @override
  void initState() {
    Provider.of<PastMultipleQuestionsProvider>(context, listen: false)
        .fetchDataFromApi(context, widget.ppId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PastMultipleQuestionsProvider>(context);

    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.boxgreyColor,
          appBar: AppBar(
            titleSpacing: 0.20,
            elevation: 0,
            title: Text("Practice Questions"),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
              ),
            ),
          ),
          body: provider.isLoading
              ? Center(child: Loader(message: "loading_wait".tr))
              : SingleChildScrollView(
                  child: Column(
                    
                    children: <Widget>[
                       if (provider.questions.isEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          h102,
                          NoDataFound(message: 'No questions found.',),
                        ],
                      )
                      else
                      for (int i = 0; i < provider.questions.length; i++)
                      ListView(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      provider.questions[i].aqTitle,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      for (int j = 1; j <= 4; j++)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: provider.resultColors[i]['option$j'],
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: RadioListTile(
                                              selectedTileColor: provider.resultColors[i]['option$j'],
                                              value: 'aqOption$j',
                                              groupValue: provider.selectedAnswers[i],
                                              onChanged: (String? value) {
                                                provider.handleRadioValueChanged(i, value!);
                                                setState(() {});
                                                print(provider.isCorrect);
                                              },
                                              title: Text(
                                                provider.questions[i].getOption(j)!,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    provider.viewResult
                        ? Text("")
                        :  provider.questions.isEmpty?Text(""):ElevatedButton(
                            onPressed: () {
                              provider.submitAnswers(context);
                            },
                            child: Text('Submit'),
                          ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}

class Temperatures {
  bool status;
  String message;
  Data data;

  Temperatures({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Temperatures.fromJson(Map<String, dynamic> json) => Temperatures(
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
  List<AssignmentQuestion> assignmentQuestions;

  Data({
    required this.assignmentQuestions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        assignmentQuestions: List<AssignmentQuestion>.from(
            json["assignmentQuestions"]
                .map((x) => AssignmentQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assignmentQuestions":
            List<dynamic>.from(assignmentQuestions.map((x) => x.toJson())),
      };
}

class AssignmentQuestion {
  int aqId;
  dynamic asnId;
  dynamic tcId;
  String aqTitle;
  int aqType;
  String aqAnswerType;
  String aqOption1;
  String aqOption2;
  String aqOption3;
  String aqOption4;
  String aqOption5;
  String aqCategory;
  String aqSubCategory;
  String aqTopic;
  dynamic aqImage;
  String aqQuestionStatement;
  List<String> aqCorrentAns;
  int ppId;
  String aqQuestionType;
  int aqMark;
  bool aqStatus;
  DateTime aqCreatedAt;

  AssignmentQuestion({
    required this.aqId,
    required this.asnId,
    required this.tcId,
    required this.aqTitle,
    required this.aqType,
    required this.aqAnswerType,
    required this.aqOption1,
    required this.aqOption2,
    required this.aqOption3,
    required this.aqOption4,
    required this.aqOption5,
    required this.aqCategory,
    required this.aqSubCategory,
    required this.aqTopic,
    required this.aqImage,
    required this.aqQuestionStatement,
    required this.aqCorrentAns,
    required this.ppId,
    required this.aqQuestionType,
    required this.aqMark,
    required this.aqStatus,
    required this.aqCreatedAt,
  });

  factory AssignmentQuestion.fromJson(Map<String, dynamic> json) => AssignmentQuestion(
        aqId: json["aq_id"],
        asnId: json["asn_id"],
        tcId: json["tc_id"],
        aqTitle: json["aq_title"],
        aqType: json["aq_type"],
        aqAnswerType: json["aq_answerType"],
        aqOption1: json["aq_option1"],
        aqOption2: json["aq_option2"],
        aqOption3: json["aq_option3"],
        aqOption4: json["aq_option4"],
        aqOption5: json["aq_option5"],
        aqCategory: json["aq_category"],
        aqSubCategory: json["aq_subCategory"],
        aqTopic: json["aq_topic"],
        aqImage: json["aq_image"],
        aqQuestionStatement: json["aq_questionStatement"],
        aqCorrentAns: List<String>.from(json["aq_correntAns"].map((x) => x)),
        ppId: json["pp_id"],
        aqQuestionType: json["aq_questionType"],
        aqMark: json["aq_mark"],
        aqStatus: json["aq_status"],
        aqCreatedAt: DateTime.parse(json["aq_createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "aq_id": aqId,
        "asn_id": asnId,
        "tc_id": tcId,
        "aq_title": aqTitle,
        "aq_type": aqType,
        "aq_answerType": aqAnswerType,
        "aq_option1": aqOption1,
        "aq_option2": aqOption2,
        "aq_option3": aqOption3,
        "aq_option4": aqOption4,
        "aq_option5": aqOption5,
        "aq_category": aqCategory,
        "aq_subCategory": aqSubCategory,
        "aq_topic": aqTopic,
        "aq_image": aqImage,
        "aq_questionStatement": aqQuestionStatement,
        "aq_correntAns": List<dynamic>.from(aqCorrentAns.map((x) => x)),
        "pp_id": ppId,
        "aq_questionType": aqQuestionType,
        "aq_mark": aqMark,
        "aq_status": aqStatus,
        "aq_createdAt": aqCreatedAt.toIso8601String(),
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

 