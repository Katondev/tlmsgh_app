import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:katon/models/assignment_model.dart';
import 'package:katon/models/assignment_result_model.dart';
import 'package:katon/models/practice/practice_subject_model.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/practice/assignment/model/answer_submit_model.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';

import '../../../models/past_paper_model.dart';
import '../../../res.dart';

class PracticePrv extends ChangeNotifier {
  SignInModel signInM = SignInModel();
  AssignmentModel? assignmentModel;
  AssignmentResultModel? assignmentResult;
  AssignmentResultModel? answerSubmitModel;
  AnswerSubmit? answerModel;
  List<AnswerSubmit> answerList = [];
  bool connections = false;
  bool _isLoading = false;

  int currentIndex = -1;
  int SelectedIndex = 1;
  String subCategoryName = "";
  List<Map<String, dynamic>> subjectList = [
    {
      "title": "English",
      "icon": AppAssets.ic_subject1,
      "subList": ["Assignment", "Past Questions", "Self Assessment"],
      "isExpanded": false,
    },
    {
      "title": "Mathematics",
      "icon": AppAssets.ic_subject2,
      "subList": ["Assignment", "Past Questions", "Self Assessment"],
      "isExpanded": false,
    },
    {
      "title": "Science",
      "icon": AppAssets.ic_subject3,
      "subList": ["Assignment", "Past Questions", "Self Assessment"],
      "isExpanded": false,
    },
    {
      "title": "Social Studies",
      "icon": AppAssets.ic_subject4,
      "subList": ["Assignment", "Past Questions", "Self Assessment"],
      "isExpanded": false,
    },
    {
      "title": "Computer",
      "icon": AppAssets.ic_subject5,
      "subList": ["Assignment", "Past Questions", "Self Assessment"],
      "isExpanded": false,
    },
    {
      "title": "Creative Art",
      "icon": AppAssets.ic_subject6,
      "subList": ["Assignment", "Past Questions", "Self Assessment"],
      "isExpanded": false,
    },
  ];
  List<Map<String, dynamic>> subjectTeacherList = [
    {
      "title": "English",
      "icon": AppAssets.ic_subject1,
      "subList": ["Assignment review", "Past Questions"],
      "isExpanded": false,
    },
    {
      "title": "Mathematics",
      "icon": AppAssets.ic_subject2,
      "subList": ["Assignment review", "Past Questions"],
      "isExpanded": false,
    },
    {
      "title": "Science",
      "icon": AppAssets.ic_subject3,
      "subList": ["Assignment review", "Past Questions"],
      "isExpanded": false,
    },
    {
      "title": "Social Studies",
      "icon": AppAssets.ic_subject4,
      "subList": ["Assignment review", "Past Questions"],
      "isExpanded": false,
    },
    {
      "title": "Computer",
      "icon": AppAssets.ic_subject5,
      "subList": ["Assignment review", "Past Questions"],
      "isExpanded": false,
    },
    {
      "title": "Creative Art",
      "icon": AppAssets.ic_subject6,
      "subList": ["Assignment review", "Past Questions"],
      "isExpanded": false,
    },
  ];

  List<String> selfAssessmentList = [
    "Listening and Speaking",
    "Grammer",
    "Reading",
    "Composition",
    "Literature/ Library",
    "Writing",
    "Pronunciation",
    "Comprehension",
  ];

  List<Map<String, dynamic>> practiceStudentList = [
    {
      "image": AppAssets.ic_assignment,
      "title": "Assignments",
    },
    {
      "image": AppAssets.ic_pastQuestion,
      "title": "Past Questions",
    },
    {
      "image": AppAssets.ic_selfAssessment,
      "title": "Self Assessment",
    },
  ];
  List<Map<String, dynamic>> practiceTeacherList = [
    {
      "image": AppAssets.ic_assignment,
      "title": "Assignment Review",
    },
    {
      "image": AppAssets.ic_pastQuestion,
      "title": "Past Questions",
    },
  ];

  bool get value => _isLoading;

  bool get connection => connections;

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  List<Map<String, dynamic>> map = [];

  // Future<void> getResult({int? ass_id}) async {
  //   answerList.clear();
  //   map.clear();
  //   try {
  //     connections = false;
  //     _setLoading(true);
  //     await ApiService.instance
  //         .get(
  //       ApiRoutes.assignmentResultNew + "/${ass_id}",
  //     )
  //         .then((value) {
  //       answerSubmitModel = AssignmentResultModel.fromJson(value.data);
  //       map = List<Map<String, dynamic>>.from(jsonDecode(
  //           answerSubmitModel!.data!.assignmentResult!.arAnswerKeys!));
  //     });
  //     _setLoading(false);
  //   } on Exception catch (e) {
  //     if (e.toString() == "No Internet") {
  //       connections = true;
  //     }
  //     _setLoading(false);
  //   }
  // }

  Future<void> getAllAssignment(
    
      {String? bkCategory,
      String? bkSubCategory,
      int? page,
      int? limit}) async {
    try {
     await subCategoryName;
     notifyListeners();
      connections = false;
      _setLoading(true);
      log("-------------");
      String id = await subCategoryName; 
      int uid = AppPreference().getInt(PreferencesKey.uId);
      await ApiService.instance.get(ApiRoutes.Subassignment, queryParameters: {
      "tc_id":uid,
      "userType":AppPreference().getString(PreferencesKey.uType),
      "asn_category":AppPreference().getString(PreferencesKey.level),
       "asn_subCategory": id
      }).then((value) {
        print("model---ddd--1-${uid}");
        assignmentModel = AssignmentModel.fromJson(value.data);
        print("model-----2-$assignmentModel");
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  List<String> practiceSubjectList = [];
  int selectedPractice = 0;

  Future<void> getSelfAssessmentSubject() async {
    int id = await AppPreference().getInt(PreferencesKey.student_Id);
    try {
      practiceSubjectList.clear();
      connections = false;
      _setLoading(true);
      log("-------------");
      // int id = await AppPreference().getInt(PreferencesKey.uId);
      await ApiService.instance
          .get(ApiRoutes.selfAssessmentSubject, queryParameters: {
        "st_id": id,
      }).then((value) {
        print("model-----1-$value");
        var data = PracticeSubjectModel.fromJson(value.data);

        practiceSubjectList = data.data!;
        print("model-----2-$assignmentModel");
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  } 
   Future<void> getAssessmentSubject() async {
   
    try {
      practiceSubjectList.clear();
      connections = false;
      _setLoading(true);
      log("-------------");
      // int id = await AppPreference().getInt(PreferencesKey.uId);
      await ApiService.instance
          .get(ApiRoutes.assignment, queryParameters: {
            "tc_id=":AppPreference().getString(PreferencesKey.tpId),
             "userType=":AppPreference().getString(PreferencesKey.uType),
        "asn_category": AppPreference().getString(PreferencesKey.level),
      }).then((value) {
        
        print("model-----1-$value");
        var data = PracticeSubjectModel.fromJson(value.data);
        

        practiceSubjectList = data.data!;
        print("model-----2-$assignmentModel");
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

    Future<void> getpastAssessmentSubject() async {
   
    try {
      practiceSubjectList.clear();
      connections = false;
      _setLoading(true);
      log("-------------");
      // int id = await AppPreference().getInt(PreferencesKey.uId);
      await ApiService.instance
          .get(ApiRoutes.pastAssessmentSubject, queryParameters: {
        "mainCategory": AppPreference().getString(PreferencesKey.level),
      }).then((value) {
        print("model-----1-$value");
        var data = PracticeSubjectModel.fromJson(value.data);

        practiceSubjectList = data.data!;
        print("model-----2-$assignmentModel");
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  Future<void> getAllAssignmentresult(context) async {
    
    try {
      connections = false;
      _setLoading(true);
      log("-------------");
      // int id = await AppPreference().getInt(PreferencesKey.uId);
      await ApiService.instance
          .get(
        "${ApiRoutes.assignmentResultbyId}41",
      )
          .then((value) {
        // print("model-----1-${value}");
        assignmentResult = AssignmentResultModel.fromJson(value.data);

        print("model-----2-$assignmentResult");
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  PastPaperModel? 
  pastPaperModel;

  Future<void> getAllPastQuestions(
      {String? bkCategory,
      String? bkSubCategory,
      int? page,
      int? limit}) async {
    try {
      connections = false;
      _setLoading(true);
      int id = await AppPreference().getInt(PreferencesKey.uId);
      await ApiService.instance.get(
        ApiRoutes.pastQuestions,
        // + "?st_id=${id}"
        queryParameters: {
          "pp_subcategory": subCategoryName.toString(),
        },
      ).then((value) {
        pastPaperModel = PastPaperModel.fromJson(value.data);
        print("---datataag----${subCategoryName}");
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }
}
