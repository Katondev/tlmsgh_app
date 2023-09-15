import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/screens/practice/assignment/model/AssignmentQSetMoel.dart';
import 'package:katon/screens/practice/assignment/model/answer_submit_model.dart';
import 'package:katon/screens/practice/assignment/model/assignment_result.dart';
import 'package:katon/services/assignment_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/widgets/custom_dialog.dart';

class AssignmentController extends ChangeNotifier {
  int? index = 0;
  int result = 0;
  int unAnswerCounter = 0;
  int answerCounter = 0;
  bool isPassed = false;
  bool connections = false;
  bool _isLoading = false;
  var timer;
  List<AnswerSubmit> answerSubmitServer = [];
  String timerText = '00:00:00';
  List<Map<String, dynamic>> answerList = [];
  final PageController controller = PageController();
  AssignmentQSetModel questionDetail = AssignmentQSetModel();
  Duration totalDuration = Duration(minutes: 10);

  bool get value => _isLoading;

  bool get connection => connections;

  Future<void> init(int assignmentId) async {
    globalAssignmentId = assignmentId;
    result = 0;
    await getAssignmentQSetDetails(assignmentId);
    //  _isLoading=false;
    // _isLoading=true;
    // if (arg?.title.isNotEmpty ?? false) {
    //   timer.cancel();
    //   timerText = "00:30:00";
    // }

    // arg = args[0];
    notifyListeners();
  }

  AnswerSubmit anser = AnswerSubmit();

  answerChecker(
      {required String ans,
      required String correctAnswer,
      int? index,
      List<String>? option,
      int? question}) {
    if (answerSubmitServer.isEmpty) {
      answerSubmitServer.add(AnswerSubmit(
          question: questionDetail.data!.questionData![question!].question,
          selectedOption: correctAnswer,
          answer: ans,
          option: option));
    } else {
      String questions =
          questionDetail.data!.questionData![question!].question!;
      AnswerSubmit indexs = answerSubmitServer.firstWhere(
          (element) => element.question == questions,
          orElse: () => anser);

      if (indexs.question != null) {
        if (questions == indexs.question) {
          int select =
              answerSubmitServer.indexWhere((element) => element == indexs);
          answerSubmitServer[select] = AnswerSubmit(
              question: questionDetail.data!.questionData![question].question,
              selectedOption: correctAnswer,
              answer: ans,
              option: option);
        }
      } else {
        answerSubmitServer.add(AnswerSubmit(
            question: questionDetail.data!.questionData![question].question,
            selectedOption: correctAnswer,
            answer: ans,
            option: option));
      }

      // for (int i = 0; i < answerSubmitServer.length; i++) {
      //   if (questionDetail.data!.questionData![question!].question!
      //           .toLowerCase() ==
      //       answerSubmitServer[i].question!.toLowerCase()) {
      //     answerSubmitServer.indexWhere((element) =>
      //         element ==
      //         AnswerSubmit(
      //             question:
      //                 questionDetail.data!.questionData![question].question,
      //             selectedOption: correctAnswer,
      //             answer: ans,
      //             option: option));
      //   } else {
      //     answerSubmitServer.add(AnswerSubmit(
      //         question: questionDetail.data!.questionData![question].question,
      //         selectedOption: correctAnswer,
      //         answer: ans,
      //         option: option));
      //   }
      // }
      print(result);
    }

    notifyListeners();
  }

  getUnansweredCount() {
    unAnswerCounter =
        answerList.where((element) => element["isAnswered"] == false).length;
    answerCounter =
        answerList.where((element) => element["isAnswered"] == true).length;
    notifyListeners();
  }

  resultChecker(bool isFrom) async {
    if (isFrom == true) {
      cancelTimer();
    }
    for (int i = 0; i < answerSubmitServer.length; i++) {
      if (answerSubmitServer[i].selectedOption ==
          answerSubmitServer[i].answer) {
        result = result + questionDetail.data!.marksPerQuestion!;
      }
    }

    if (result >= questionDetail.data!.passingMarks!) {
      isPassed = true;
    } else {
      isPassed = false;
    }
    if (isPassed == true) {
      await showDialog(
          context: Get.context!,
          builder: (BuildContext context) => CustomDialog(
                title1: "ok".tr,
                onFirstButtonTap: () {
                  Navigator.of(context).pop();
                  submitAssignment();
                },
                message: "pass_message".tr + result.toString(),
              ));
    } else {
      await showDialog(
          context: Get.context!,
          builder: (BuildContext context) => CustomDialog(
                title1: "ok".tr,
                onFirstButtonTap: () {
                  answerSubmitServer.clear();
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
                message: "failed_message".tr + result.toString(),
              ));
    }

    notifyListeners();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  int? globalAssignmentId;

//call
  getAssignmentQSetDetails(int assignmentId) async {
    globalAssignmentId = assignmentId;
    try {
      connections = false;
      _setLoading(true);
      notifyListeners();
      questionDetail =
          await AssignmentServices().getAssignmentQSet(assignmentId);
      totalDuration =
          Duration(minutes: int.parse(questionDetail.data!.duration ?? "10"));
      answerList = List.generate(
          questionDetail.data!.questionData!.length,
          (index) => {
                "index": index,
                "isAnswered": false,
                "answer": "",
                "answerIndex": null
              });
      getUnansweredCount();
      if (questionDetail.data!.questionData!.isNotEmpty) {
        totalDuration =
            Duration(minutes: int.parse(questionDetail.data!.duration!));
        startTimer();
      }
      log("answer list $answerList");
      notifyListeners();
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
    notifyListeners();
  }

  //todo submission logic not implemented
  submitAssignment() async {
    try {
      connections = false;
      _setLoading(true);
      notifyListeners();

      int id = await AppPreference().getInt(PreferencesKey.uId);
      AssignmentResultDetails reslut =
          await AssignmentServices().submitResult(answer: {
        "st_id": id,
        "asn_id": globalAssignmentId,
        "ar_answerKeys": json.encode(answerSubmitServer),
        "ar_score": result,
        "ar_unanswered": unAnswerCounter,
        "ar_submitTime": questionDetail.data!.duration,
        "ar_dateTime": DateTime.now().toString(),
        "ar_totalQuestion": questionDetail.data!.questionData!.length
      });
      notifyListeners();
      await getAssignmentQSetDetails(globalAssignmentId!);
      index = 0;
      answerSubmitServer.clear();
      Navigator.of(Get.context!).pop();
      _setLoading(false);
      return reslut;
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
    notifyListeners();
  }

  void onNextPress() {
    index = (index ?? 0) + 1;
    controller.animateToPage(index ?? 0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubicEmphasized);
    notifyListeners();
  }

  void onPreviousPress() {
    index = (index ?? 0) - 1;

    controller.animateToPage(index ?? 0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubicEmphasized);
    notifyListeners();
  }

  void onPageChange(int value) {
    print(value);
    index = value;
    controller.jumpToPage(index!);
    // controller.animateToPage(index!,
    //     duration: const Duration(seconds: 1),
    //     curve: Curves.easeInOutCubicEmphasized);
    notifyListeners();
  }

  // String get timerText =>
  //     '${((timerMaxSeconds - counter) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - counter) % 60).toString().padLeft(2, '0')}';
  void cancelTimer() {
    timer!.cancel();
    timerText = "00:00:00";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cancelTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      const reduceSecondsBy = 1;
      final seconds = totalDuration.inSeconds - reduceSecondsBy;
      notifyListeners();
      if (seconds < 0) {
        cancelTimer();
        resultChecker(false);
      } else {
        totalDuration = Duration(seconds: seconds);
        notifyListeners();
      }
      String strDigits(int n) => n.toString().padLeft(2, '0');
      final hour = strDigits(totalDuration.inHours.remainder(24));
      final minute = strDigits(totalDuration.inMinutes.remainder(60));
      final second = strDigits(totalDuration.inSeconds.remainder(60));

      timerText = '$minute:$second';
      //log("+++++++++++++++++++$timerText");
      // '$hour:${((timerMaxSeconds - counter.value) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - counter.value) % 60).toString().padLeft(2, '0')}';
      notifyListeners();
    });
  }
}
