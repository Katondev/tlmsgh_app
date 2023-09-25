import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/elearning_model/sub_category_model.dart';
import 'package:katon/models/filter_category_model/filter_category_model.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/practice/assignment/model/answer_submit_model.dart';
import 'package:katon/screens/self_assessment/model/self_assessment_list_model.dart';
import 'package:katon/screens/self_assessment/model/self_assessment_que_model.dart';
import 'package:katon/screens/self_assessment/self_test_assignment.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/widgets/custom_dialog.dart';

class SelfAssessmentController extends ChangeNotifier {
  List<String> list = ["Maths", "Science"];

  bool _isLoading = false;
  bool _isLoading1 = false;
  bool connections = false;
  int paperId = 0;
  SelfAssessMentQueModel? selfAssessMentQueModel;
  SelfAssessment? _selfAssessMentModel;
  String selfAssessmntcat = "";

  bool get value => _isLoading;

  bool get value1 => _isLoading1;

  bool get connection => connections;

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void _setLoading1(bool val) {
    _isLoading1 = val;
    notifyListeners();
  }

  List<FilterCategoryModel> mainCategoryMList = <FilterCategoryModel>[];
  List<Subject> subjectList = <Subject>[];
  List<SubCategoryModel> subCategoryList = <SubCategoryModel>[];
  List<SubCategoryModel> subCategoryListFilter = <SubCategoryModel>[];
  List<Topics> topicListFilter = <Topics>[];
  List<Topics> topicList = <Topics>[];
  List<SubCategoryTopic> topicListNew = <SubCategoryTopic>[];
  List<Topic> topicFilt = <Topic>[];
  SubCategoryModel? selectedSubCat = SubCategoryModel();
  Topic? topic = Topic();
  Rx<FilterCategoryModel> selectedMainCat = FilterCategoryModel().obs;
  Rx<Subject> selectedSubject = Subject().obs;

  /// Select Main Category Drop down
  ///
  SignInModel signInM = SignInModel();

  void selectMainCategory({FilterCategoryModel? value}) {
    selectedMainCat.value = value!;
    subCategoryListFilter.clear();
    subCategoryList.forEach((mainCategory) {
      if (mainCategory.categoryId == selectedMainCat.value.categoryId) {
        subCategoryListFilter.add(SubCategoryModel(
          categoryId: mainCategory.categoryId,
          categoryName: mainCategory.categoryName,
          subCategoryId: mainCategory.subCategoryId,
        ));
        selectedSubCat = subCategoryListFilter.first;
      }
    });

    notifyListeners();
  }

  /// Select Sub Category Drop down
  void selectSubcategory({SubCategoryModel? value}) {
    selectedSubCat = value!;
    topicFilt.clear();
    topicList.forEach((element) {
      element.category!.forEach((element) {
        element.subCategory!.forEach((element1) {
          if (element1.topics!.isNotEmpty)
            element1.topics!.forEach((element2) {
              if (selectedSubCat!.subCategoryId == element1.subCateId) {
                topicFilt.add(Topic(
                    topicId: element2.topicId, topicName: element2.topicName));
                log('sub category list:->${topicFilt.toString()}');
              }
            });
        });
      });
    });
    if (topicFilt.isNotEmpty) {
      log(topicFilt.first.topicName!);
      topic = topicFilt.first;
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.showSnackbar(GetSnackBar(
        message: 'choosen subject has no topics!',
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 400),
      ));
    }
    notifyListeners();
  }

  void selectSubject({Subject? value}) {
    selectedSubject.value = value!;
    // subCategoryListFilter.clear();
    // subCategoryList.forEach((mainCategory) {
    //   if (mainCategory.categoryId == selectedMainCat.value!.categoryId) {
    //     subCategoryListFilter.add(SubCategoryModel(
    //       categoryId: mainCategory.categoryId,
    //       categoryName: mainCategory.categoryName,
    //       subCategoryId: mainCategory.subCategoryId,
    //     ));
    //     selectedSubCat = subCategoryListFilter.first;
    //   }
    // });

    notifyListeners();
  }

  Future generatePaperApi(context) async {
    try {
      final int id =
          AppPreference().getInt(PreferencesKey.student_Id);
      connections = false;
      _setLoading(true);
      Map<String, dynamic> params = {
        "sa_category": selectedMainCat.value.categoryName,
        "sa_subCategory": selectedSubject.value.value,
        "sa_topic": "",

        // "sa_topic": topic!.topicName
      };
      print("url- daayaya-------${ApiRoutes.createSelfAssessment+"st_id=${id}"}");
      await ApiService.instance
          .postHTTP(url: ApiRoutes.createSelfAssessment+"st_id=${id}", body: params)
          .then((value) async {
        log("--paper------${value}");
        await getAllSelfAssessmentList();
        selectedMainCat.value = FilterCategoryModel();
        selectedSubject.value = Subject();
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  /// Get all main category
  Future getAllCategoryInfo() async {
    mainCategoryMList.clear();
    if (mainCategoryMList.isEmpty) {
      final String mainCategoryData =
          AppPreference().getString(PreferencesKey.mainCategory);
      log("list-----${mainCategoryData}");
      mainCategoryMList = FilterCategoryModel.decode(mainCategoryData);

      // mainCategoryMList.insert(
      //   0,
      //   FilterCategoryModel(
      //     maincategoryName: "Class/Garde",
      //     categoryId: 15250,
      //   ),
      // );
      // selectedMainCat.value = mainCategoryMList.first;
    }
    log("list---2--${mainCategoryMList}");

    /// get All sub Category
    subCategoryList.clear();
    if (subCategoryList.isEmpty) {
      final String subCategoryData =
          AppPreference().getString(PreferencesKey.subCategory);
      subCategoryList = SubCategoryModel.decode(subCategoryData);

      // subCategoryListFilter.insert(
      //   0,
      //   SubCategoryModel(
      //     categoryName: "Subject",
      //     subCategoryId: 15200,
      //     categoryId: 15250,
      //   ),
      // );
      // selectedSubCat = subCategoryListFilter.first;
    }
    subjectList.clear();
    if (subjectList.isEmpty) {
      final String subjectData =
          AppPreference().getString(PreferencesKey.subject);
      subjectList = Subject.decode(subjectData);
      log("subjects----${subjectList}");

      subjectList.insert(
        0,
        Subject(
          value: "Select Subject",
          label: "Select Subject",
        ),
      );
      selectedSubject.value = subjectList.first;
    }
    final String mainCategoryData1 =
        AppPreference().getString(PreferencesKey.topic);
//    Map<String, dynamic> valueMap = json.decode(mainCategoryData1);

    topicList = decode(mainCategoryData1);
    log("topic-----${mainCategoryData1}");
    topicFilt.insert(
      0,
      Topic(topicId: -0, topicName: "Topic"),
    );

    topic = topicFilt.first;
  }

  List<Topics> decode(String mainCategoryModel) =>
      (json.decode(mainCategoryModel) as List<dynamic>)
          .map<Topics>((item) => Topics.fromJson(item))
          .toList();

  selectedTopic(Topic topics) {
    topic = topics;
    notifyListeners();
  }

  int? globalSaId;

  Future<void> getAllSelfAssessment(int saId) async {
    try {
      globalSaId = saId;
      connections = false;
      _setLoading1(true);
      result = 0;
      await ApiService.instance.get(
          ApiRoutes.getSelfAssessment + "sa_id=${saId}",
          queryParameters: {"sa_id": "${saId}"}).then((value) async {
        selfAssessMentQueModel = SelfAssessMentQueModel.fromJson(value.data);
        answerList = List.generate(
            selfAssessMentQueModel!.data!.questionData!.length,
            (index) => {
                  "index": index,
                  "isAnswered": false,
                  "answer": "",
                  "answerIndex": null
                });
        getUnansweredCount();
        //log("answer list $answerList");
        notifyListeners();
        _setLoading1(false);
        if (selfAssessMentQueModel!
            .data!.selfAssessment!.saQuestions!.isNotEmpty) {
          totalDuration = Duration(
              minutes:
                  selfAssessMentQueModel!.data!.selfAssessment!.saDuration!);
          startTimer();
        }
        Get.to(() => SelfTestAssignment(
              questionData: selfAssessMentQueModel!.data!.selfAssessment!,
            ));
      });
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading1(false);
    }
  }

  SelfAssessMentList? selfAssessmentList;

  Future<void> getAllSelfAssessmentList() async {
    
   int id = await AppPreference().getInt(PreferencesKey.student_Id);
   
    try {
      connections = false;
      _setLoading(true);
      await ApiService.instance
          .get("https://user.api.tlmsghdev.in/api/v1/student/selfAssessment/getAll?st_id=$id&sa_subCategory=$selfAssessmntcat")
          .then((value) {
        selfAssessmentList = SelfAssessMentList.fromJson(value.data);
        log("self--------${value}");
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  Future<void> submitSelfAssessMent() async {
    try {
      connections = false;
      _setLoading(true);
      int id = await AppPreference().getInt(PreferencesKey.uId);
      Map<String, dynamic> params = {"sa_score": result, "st_id": id};
      await ApiService.instance
          .putHTTP(
        url: ApiRoutes.saveSelfAssessMent + "${globalSaId}",
        body: params,
      )
          .then((value) async {
        await getAllSelfAssessmentList();
        index = 0;
        answerSubmitServer.clear();
        Navigator.of(Get.context!).pop();
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  int? index = 0;
  int result = 0;
  int unAnswerCounter = 0;
  int answerCounter = 0;
  bool isPassed = false;
  var timer;
  List<AnswerSubmit> answerSubmitServer = [];
  String timerText = '00:00:00';
  List<Map<String, dynamic>> answerList = [];
  final PageController controller = PageController();

  //  AssignmentQSetModel questionDetail = AssignmentQSetModel();
  Duration totalDuration = Duration(minutes: 10);
  AnswerSubmit anser = AnswerSubmit();

  answerChecker(
      {required String ans,
      required String correctAnswer,
      int? index,
      List<String>? option,
      int? question}) {
    if (answerSubmitServer.isEmpty) {
      answerSubmitServer.add(AnswerSubmit(
          question:
              selfAssessMentQueModel!.data!.questionData![question!].question,
          selectedOption: correctAnswer,
          answer: ans,
          option: option));
    } else {
      String questions =
          selfAssessMentQueModel!.data!.questionData![question!].question!;
      AnswerSubmit indexs = answerSubmitServer.firstWhere(
          (element) => element.question == questions,
          orElse: () => anser);

      if (indexs.question != null) {
        if (questions == indexs.question) {
          int select =
              answerSubmitServer.indexWhere((element) => element == indexs);
          answerSubmitServer[select] = AnswerSubmit(
              question: selfAssessMentQueModel!
                  .data!.questionData![question].question,
              selectedOption: correctAnswer,
              answer: ans,
              option: option);
        }
      } else {
        answerSubmitServer.add(AnswerSubmit(
            question:
                selfAssessMentQueModel!.data!.questionData![question].question,
            selectedOption: correctAnswer,
            answer: ans,
            option: option));
      }
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
    print(answerSubmitServer.length);

    for (int i = 0; i < answerSubmitServer.length; i++) {
      if (answerSubmitServer[i].selectedOption ==
          answerSubmitServer[i].answer) {
        result = result +
            selfAssessMentQueModel!.data!.questionData![i].marksPerQuestion!;
      }
    }

    if (result >=
        selfAssessMentQueModel!.data!.selfAssessment!.saPassingMarks!) {
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
                  submitSelfAssessMent();
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
