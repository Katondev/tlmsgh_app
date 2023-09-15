import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart' as formData;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/training_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
import '../../../models/question_model.dart';
import '../../../models/school_filter_model/school_filter_model.dart';
import '../../../models/sign_in_model.dart';
import '../../../models/snackbar_datamodel.dart';
import '../../../models/training_detail_model.dart';
import '../../../services/snackbar_service.dart';
import '../../../utils/Routes/teacher_route_arguments.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/download_file.dart';
import '../../practice/assignment/model/answer_submit_model.dart';

class TrainingProvider extends ChangeNotifier {
  TrainingModel? trainingModel;
  TrainingDetailModel? trainingdetailModel;
  QuestionModel? questionModel;
  SchoolFilterModel schoolfilterModel = SchoolFilterModel();
  List<DropdownSchoolTeacher> schoolList = <DropdownSchoolTeacher>[];
  DropdownSchoolTeacher selectedSchoolValue = DropdownSchoolTeacher();
  Arguments? args;
  bool _isLoading = false;
  bool connections = false;
  String? radioGroupVal;
  bool get value => _isLoading;
  bool get connection => connections;
  int selectedTile = -1;
  int trainingProgramId = 0;
  int trainingOption = 0;
  int trainingStatus = 0;
  bool isStatus = false;
  Rx<Uint8List> imageFile = Uint8List(1).obs;
  File? downloadForm;
  File? downloadPdf;

  int tpsId = 0;
  String certificatePath = "";
  // int tpsuserId = 0;
  final signatureCnt = TextEditingController(
      text: AppPreference().getString(PreferencesKey.uName));
  String signatureVal = AppPreference().getString(PreferencesKey.uName);

  RxList<String> signatureFontfamily = [
    "Autography",
    "Betterlett",
    "Darlington",
    "Flighty",
    "HealingFairyBoldItalic",
    "KimberlySignature",
    "Pontgraph",
    "Reinatha",
  ].obs;
  int selectedSign = 0;

  List<Map<String, dynamic>> trainingOptionList = <Map<String, dynamic>>[
    {
      "Recorded Training": [
        "Participants should ensure that they have received by email or SMS their default login password for KATon and have logged in and change their password. The login mails are usually sent to participant’s ges.gov.gh or personal email as may be expedient.",
        "Participant will require a computer (eg TM1 laptop) for this training.",
        "Participant in areas with connectivity challenges should download the KATon desktop application when at areas with modest connectivity",
        "After downloading the desktop application, log in and go to “Courses” and select the training on “ICT Skills Acquisition for Teachers”",
        "Try to access the training resources that are in PDF and also play the training videos while still connected to internet.",
        "Go off the internet and test that you can access all the training materials. You can reconnect to internet and re-access any materials you were unable to access while offline.",
        "Participants should access the training materials and start the learning process. Study the PDF training content and watch the training videos. Then practice with your PC as you study.",
        "You can pause and repeat videos multiple times and make sure you have learned and practiced well.",
      ],
    },
    {
      "Online Live Training": [
        "Participants should ensure that they have received by email or SMS their default login password for KATon and have logged in and change their password. The login mails are usually sent to participant’s ges.gov.gh or personal email as may be expedient.",
        "This training will happen on Microsoft Teams. The Microsoft Team link will be shared at least 4-5 days before the training.",
        "Participant will require a computer (eg TM1 laptop) for this training. Microsoft Team is already installed on your TM1 laptop.",
        "The training will be in 2 Hours sessions for 3-4 consecutive working days from the date of commencement of your training at the same training time slot.",
        "Participants, in extreme cases, may request for a change in the assigned class or time slot minimum of three working days before the training start date.",
        "Each session will last a maximum of 2:00 hours facilitated by one of our expert trainers. Make sure you are logged in and have registered minimum of 10 minutes to the commencement of your class. During this live class, you can learn and practice on your TM1 laptop. Please make sure you have internet connection ready for the duration of the training."
            "To further aid your study during and off the training time, participants in areas with connectivity challenges should download the KATon desktop application when at areas with modest connectivity.",
        "After downloading the desktop application, log in and go to “Courses” and select the training on “ICT Skills Acquisition for Teachers” Try to access the training resources that are in PDF and also play the training videos while still connected to internet.",
      ],
    },
    {
      "Physical Training": [
        "Participants should ensure that they have received by email or SMS their default login password for KATon and have logged in and change their password. The login mails are usually sent to participant’s ges.gov.gh or personal email as may be expedient.",
        "This training will happen on Microsoft Teams. The Microsoft Team link will be shared at least 4-5 days before the training.",
        "Participant will require a computer (eg TM1 laptop) for this training. Microsoft Team is already installed on your TM1 laptop.",
        "The training will be in 2 Hours sessions for 3-4 consecutive working days from the date of commencement of your training at the same training time slot.",
      ],
    }
  ];
  List<String> recordedTrainingList = [
    "Participants should ensure that they have received by email or SMS their default login password for KATon and have logged in and change their password. The login mails are usually sent to participant’s ges.gov.gh or personal email as may be expedient.",
    "Participant will require a computer (eg TM1 laptop) for this training.",
    "Participant in areas with connectivity challenges should download the KATon desktop application when at areas with modest connectivity",
    "After downloading the desktop application, log in and go to “Courses” and select the training on “ICT Skills Acquisition for Teachers”",
  ];
  List<String> onlineTrainingList = [
    "Participants should ensure that they have received by email or SMS their default login password for KATon and have logged in and change their password. The login mails are usually sent to participant’s ges.gov.gh or personal email as may be expedient.",
    "This training will happen on Microsoft Teams. The Microsoft Team link will be shared at least 4-5 days before the training.",
    "Participant will require a computer (eg TM1 laptop) for this training. Microsoft Team is already installed on your TM1 laptop.",
    "The training will be in 2 Hours sessions for 3-4 consecutive working days from the date of commencement of your training at the same training time slot.",
  ];
  List<String> physicalTrainingList = [
    "Welcome to the physical training option.",
    "Participants should ensure that they have received by email or SMS their default login password for KATon and have logged in and change their password. The login mails are usually sent to participant’s ges.gov.gh or personal email as may be expedient.",
    "This training venue and date as well as time will be communicated to each participants via SMS and email 3-5 days before the scheduled training date.",
    "Participant will require a computer (eg TM1 laptop) for this training. Please ensure your laptop is well charged.",
  ];

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> setImageInFile() async {
    String token = AppPreference().getString(PreferencesKey.token);
    try {
      _setLoading(true);
      // connections = true;
      print("object---${token}");
      var imageUpload = formData.FormData.fromMap({
        "tc_profilePic": await formData.MultipartFile.fromBytes(
          imageFile.value.buffer.asUint8List(),
          filename: "tlms_form",
          contentType: MediaType("image", 'png'),
        ),
      });
      await ApiService.instance
          .putHTTP(
        url:
            "${ApiRoutes.updateProfilePicTeacher}${AppPreference().getInt(PreferencesKey.uId)}",
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': "application/json"
        },
        body: imageUpload,
      )
          .then((value) {
        print("dsdsdsds---------${value.data}");
        _setLoading(false);
      });
    } on Exception catch (e, r) {
      print("exception-------${e}----$r");
      if (e == "No Internet") {
        connections = true;
      }
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      // CustomLoadingIndicator.instance.hide();
      _setLoading(false);
    }
  }

  Future<void> convertImageToPDF() async {
    //Create the PDF document
    PdfDocument document = PdfDocument();
    document.pageSettings.size = PdfPageSize.a4;

    //Add the page
    PdfPage page = document.pages.add();

    //Load the image
    final PdfImage image = PdfBitmap(await downloadForm!.readAsBytes());

    //draw image to the first page
    page.graphics.drawImage(
        image,
        Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));

    //Save the document
    // List<int> bytes = await document.save();

    // print("saved bytes----${bytes}");

    //Save the file and launch/download

    var iosPath = "${(await getApplicationDocumentsDirectory()).path}";
    var androidPath = "/storage/emulated/0/Download";
    File? imgFile;
    if (Platform.isAndroid) {
      imgFile = File(androidPath);
      print("imagefile----1-${imgFile}---");
    } else if (Platform.isIOS) {
      imgFile = File(iosPath);
      print("imagefile----2-${imgFile}---");
    }
    downloadPdf = File("${imgFile?.path}/tlms_form.pdf");
    await downloadPdf?.writeAsBytes(await document.save());

    // Dispose the document
    document.dispose();

//  SaveFile.saveAndLaunchFile(bytes, 'output.pdf');
  }

  // training Resources
  int currentVideoIndex = 0;
  String videoUrl = "";
  double uploadProgress = 0;

  //online Exam
  Timer? timer;
  String timerText = '00:00:00';
  Duration totalDuration = Duration(minutes: 10);
  int? index = 0;
  int result = 0;
  bool isPassed = false;
  int unAnswerCounter = 0;
  int answerCounter = 0;
  List<Map<String, dynamic>> answerList = [];
  final PageController controller = PageController();
  List<AnswerSubmit> answerSubmitServer = [];
  AnswerSubmit anser = AnswerSubmit();

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

  void cancelTimer() {
    timer!.cancel();
    timerText = "00:00:00";
  }

  getUnansweredCount() {
    unAnswerCounter =
        answerList.where((element) => element["isAnswered"] == false).length;
    answerCounter =
        answerList.where((element) => element["isAnswered"] == true).length;
    notifyListeners();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      const reduceSecondsBy = 1;
      final seconds = totalDuration.inSeconds - reduceSecondsBy;
      notifyListeners();
      if (seconds < 0) {
        cancelTimer();
        // resultChecker(false);
      } else {
        totalDuration = Duration(seconds: seconds);
        notifyListeners();
      }
      String strDigits(int n) => n.toString().padLeft(2, '0');
      final hour = strDigits(totalDuration.inHours.remainder(24));
      final minute = strDigits(totalDuration.inMinutes.remainder(60));
      final second = strDigits(totalDuration.inSeconds.remainder(60));

      timerText = '$hour:$minute:$second';
      //log("+++++++++++++++++++$timerText");
      // '$hour:${((timerMaxSeconds - counter.value) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - counter.value) % 60).toString().padLeft(2, '0')}';
      notifyListeners();
    });
  }

  answerChecker(
      {required String ans,
      required String correctAnswer,
      int? index,
      List<String>? option,
      int? question}) {
    if (answerSubmitServer.isEmpty) {
      answerSubmitServer.add(AnswerSubmit(
          question: questionModel!.data!.questionData![question!].question,
          selectedOption: correctAnswer,
          answer: ans,
          option: option));
    } else {
      String questions =
          questionModel!.data!.questionData![question!].question!;
      AnswerSubmit indexs = answerSubmitServer.firstWhere(
          (element) => element.question == questions,
          orElse: () => anser);

      if (indexs.question != null) {
        if (questions == indexs.question) {
          int select =
              answerSubmitServer.indexWhere((element) => element == indexs);
          answerSubmitServer[select] = AnswerSubmit(
              question: questionModel!.data!.questionData![question].question,
              selectedOption: correctAnswer,
              answer: ans,
              option: option);
        }
      } else {
        answerSubmitServer.add(AnswerSubmit(
            question: questionModel!.data!.questionData![question].question,
            selectedOption: correctAnswer,
            answer: ans,
            option: option));
      }

      print(result);
    }

    notifyListeners();
  }

  resultChecker(bool isFrom, BuildContext context) async {
    if (isFrom == true) {
      cancelTimer();
    }
    for (int i = 0; i < answerSubmitServer.length; i++) {
      if (answerSubmitServer[i].selectedOption ==
          answerSubmitServer[i].answer) {
        result = result + questionModel!.data!.marksPerQuestion!;
      }
    }

    if (result >= questionModel!.data!.passingMarks!) {
      isPassed = true;
      log("passed");
    } else {
      isPassed = false;
      log("failed");
    }
    if (isPassed == true) {
      await showDialog(
          context: Get.context!,
          builder: (BuildContext context) => CustomDialog(
                title1: "ok".tr,
                onFirstButtonTap: () {
                  getExamResult(context);

                  // submitAssignment(context);
                },
                message: "pass_message".tr + result.toString(),
              ));
    } else {
      await showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
                title1: "ok".tr,
                onFirstButtonTap: () {
                  answerSubmitServer.clear();
                  // navigatorKey.currentState?..pop();
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
                message: "failed_message".tr + result.toString(),
              ));
    }

    notifyListeners();
  }

  submitAssignment(BuildContext context) async {
    try {
      connections = false;
      _setLoading(true);
      notifyListeners();

      int id = await AppPreference().getInt(PreferencesKey.uId);
      // QuestionModel resultModel =
      //     await AssignmentServices().submitResult(answer: {
      //   "st_id": id,
      //   "asn_id": globalAssignmentId,
      //   "ar_answerKeys": json.encode(answerSubmitServer),
      //   "ar_score": result,
      //   "ar_unanswered": unAnswerCounter,
      //   "ar_submitTime": questionModel!.data!.duration,
      //   "ar_dateTime": DateTime.now().toString(),
      //   "ar_totalQuestion": questionModel!.data!.questionData!.length
      // });
      notifyListeners();
      // await getAssignmentQSetDetails(globalAssignmentId!);
      index = 0;
      answerSubmitServer.clear();
      Navigator.of(context).pop();
      _setLoading(false);
      // return resultModel;
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> getAllTrainings() async {
    try {
      _setLoading(true);
      await ApiService.instance.get(ApiRoutes.getAllTrainings,
          queryParameters: {
            "userType": "${AppPreference().uType}"
          }).then((value) {
        trainingModel = TrainingModel.fromJson(value.data);

        connections = false;
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  Future<void> getExamQuestions() async {
    try {
      _setLoading(true);
      await ApiService.instance
          .get(ApiRoutes.getExamQuestions, queryParameters: {
        "tp_id": trainingProgramId,
      }).then((value) {
        // trainingModel = TrainingModel.fromJson(value.data);
        questionModel = QuestionModel.fromJson(value.data);
        if (questionModel!.data!.questionData!.isNotEmpty) {
          totalDuration =
              Duration(minutes: int.parse(questionModel!.data!.duration!));
          startTimer();
        }
        answerList = List.generate(
            questionModel!.data!.questionData!.length,
            (index) => {
                  "index": index,
                  "isAnswered": false,
                  "answer": "",
                  "answerIndex": null
                });
        getUnansweredCount();
        connections = false;
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  Future<void> downloadCertificate(
      {required String path, String? filetype}) async {
    log("${ApiRoutes.imageURL}${path}");
    await DownloadGeoJsonFile().downloadFile(
      url: "${ApiRoutes.imageURL}${path}",
      filename: path,
      uploadprogress: (prg) {
        uploadProgress = double.parse(prg.toString());
      },
      isshowSnackbar: true,
      fileType: filetype,
    );
  }

  Future<void> getExamResult(BuildContext context) async {
    try {
      _setLoading(true);
      await ApiService.instance
          .putHTTP(url: "${ApiRoutes.getExamResult}/$tpsId", body: {
        "tps_score": 20,
        "tps_trainingStatus": 4,
        "tps_examDate":
            "${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}",
      }).then((value) {
        trainingStatus = value.data["data"]["trainingParticipants"][1][0]
            ["tps_trainingStatus"];
        // certificatePath =
        //     value.data["data"]["trainingParticipants"][1][0]["tps_certificate"];
        Navigator.of(context)
          ..pop()
          ..pop();
        connections = false;
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  Future<void> getTrainingDetails() async {
    try {
      _setLoading(true);
      await ApiService.instance
          .postHTTP(url: ApiRoutes.getTrainingsdetails, body: {
        "tps_tp_id": trainingProgramId,
        "tps_userType": AppPreference().getString(PreferencesKey.uType),
        "tps_userId": AppPreference().getInt(PreferencesKey.uId)
      }, headers: {
        'Authorization':
            'Bearer ${AppPreference().getString(PreferencesKey.token)}',
        'Content-Type': "application/json"
      }).then((value) {
        print("training details----${value.data}");
        trainingdetailModel = TrainingDetailModel.fromJson(value.data);
        if (trainingdetailModel!.data!.trainingParticipants != null) {
          AppPreference().setInt(PreferencesKey.tpId,
              trainingdetailModel!.data!.trainingParticipants!.tpsTpId!);
          trainingStatus = trainingdetailModel!
              .data!.trainingParticipants!.tpsTrainingStatus!;

          if (trainingdetailModel!.data!.trainingParticipants!.tpsCertificate !=
              null) {
            certificatePath =
                trainingdetailModel!.data!.trainingParticipants!.tpsCertificate;
          }
          tpsId = trainingdetailModel!.data!.trainingParticipants!.tpsId!;
        } else {
          trainingStatus = 0;
          log(trainingStatus.toString());
        }
        connections = false;
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  // Future<void> generateSignedForm(BuildContext context) async {
  //   try {
  //     // _setLoading(true);
  //     var data = {
  //       "fullName": AppPreference().getString(PreferencesKey.uName),
  //       "staffId": AppPreference().getString(PreferencesKey.staffId),
  //       "schoolName": selectedSchoolValue.tcSchoolName.toString().trim(),
  //       "signatureFontStyle": signatureFontfamily[selectedSign],
  //       "signatureText": signatureCnt.text.trim(),
  //       "userId": AppPreference().getInt(PreferencesKey.uId),
  //       "tp_id": trainingProgramId,
  //       "tps_id": tpsId,
  //       "tps_signedForm": "",
  //     };
  //     print("generate signed form-------${data}");
  //     CustomLoadingIndicator.instance.show();
  //     await ApiService.instance
  //         .postHTTP(url: ApiRoutes.generateSignedForm, body: data, headers: {
  //       'Authorization':
  //           'Bearer ${AppPreference().getString(PreferencesKey.token)}',
  //       'Content-Type': "application/json"
  //     }).then((value) {
  //       // trainingdetailModel = TrainingDetailModel.fromJson(value.data);
  //       trainingStatus = value.data["data"]["trainingParticipants"][1][0]
  //           ["tps_trainingStatus"];

  //       certificatePath =
  //           value.data["data"]["trainingParticipants"][1][0]["tps_signedForm"];
  //       connections = false;
  //     });
  //     CustomLoadingIndicator.instance.hide();
  //     if (trainingStatus == 3 || trainingStatus == 2 && isStatus) {
  //       Navigator.of(context)
  //         ..pop()
  //         ..pop()
  //         ..pop();
  //       getTrainingDetails();
  //       notifyListeners();
  //     } else {
  //       Navigator.of(context)
  //         ..pop()
  //         ..pop();
  //       getTrainingDetails();
  //       notifyListeners();
  //     }
  //   } on Exception catch (e) {
  //     if (e.toString() == "No Internet") {
  //       connections = true;
  //     }
  //     CustomLoadingIndicator.instance.hide();
  //   }
  // }

  Future<void> generateSignedForm(BuildContext context) async {
    try {
      // _setLoading(true);
      print("dsdsdsdswwwewewe");
      // var mutipart = await formData.MultipartFile.fromFile(
      //   "${downloadForm?.path}/tlms_form.pdf",
      //   filename: "signed_form",
      //   contentType: MediaType("image", 'pdf'),
      // );
      var mutipart = formData.MultipartFile.fromBytes(
        downloadPdf!.readAsBytesSync(),
        filename: "${downloadPdf.toString().split("/").last}",
      );
      print(
          "data0-----------55---${downloadForm!.path}------${mutipart.filename}");
      var data = formData.FormData.fromMap({
        "tps_signFontFamily": signatureFontfamily[selectedSign],
        "tps_signText": signatureCnt.value.text.trim(),
        "tps_attentionFormDate": "2023-09-13T12:26:37.270Z",
        "tps_trainingStatus": 3,
        "tps_signedForm": mutipart,
      });
      CustomLoadingIndicator.instance.show();
      await ApiService.instance.putHTTP(
        url: "${ApiRoutes.updateSignedForm}${tpsId}",
        body: data,
        queryParams: {
          "from": "studentApp",
          "key": "xsv321sa2ds4235reuy354FE4rsd",
        },
        headers: {
          'Authorization':
              'Bearer ${AppPreference().getString(PreferencesKey.token)}',
          'Content-Type': "application/json"
        },
      ).then((value) {
        print("------->->====${value.data}");
        // trainingdetailModel = TrainingDetailModel.fromJson(value.data);
        trainingStatus = value.data["data"]["trainingParticipants"][1][0]
            ["tps_trainingStatus"];

        certificatePath =
            value.data["data"]["trainingParticipants"][1][0]["tps_signedForm"];
        connections = false;
      });
      CustomLoadingIndicator.instance.hide();
      if (trainingStatus == 2 && isStatus) {
        Navigator.of(context)
          ..pop()
          ..pop()
          ..pop();
        getTrainingDetails();
        notifyListeners();
      } else {
        Navigator.of(context)
          ..pop()
          ..pop();
        getTrainingDetails();
        notifyListeners();
      }
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      CustomLoadingIndicator.instance.hide();
    }
  }

  Future<void> getTrainingParticipants(BuildContext context) async {
    try {
      _setLoading(true);
      await ApiService.instance
          .postHTTP(url: ApiRoutes.getTrainingParticipants, body: {
        "tps_tp_id": trainingProgramId,
        "tps_userType": AppPreference().getString(PreferencesKey.uType),
        "tps_userId": AppPreference().getInt(PreferencesKey.uId),
        "tps_trainingOption": trainingOption,
      }, headers: {
        'Authorization':
            'Bearer ${AppPreference().getString(PreferencesKey.token)}',
        'Content-Type': "application/json"
      }).then((value) {
        // trainingdetailModel = TrainingDetailModel.fromJson(value.data);

        tpsId = value.data["data"]["trainingParticipants"]["tps_id"];
        // tpsuserId = value.data["data"]["trainingParticipants"]["tps_userId"];
        if (value.data["data"]["trainingParticipants"]["tps_trainingStatus"] ==
            1) {
          isStatus = true;
        }
        trainingStatus =
            value.data["data"]["trainingParticipants"]["tps_trainingStatus"];
        connections = false;
      });
      _setLoading(false);
      if (trainingStatus == 1) {
        Navigator.of(context).pushNamed(
          RoutesConst.trainingSignature,
          arguments: TeacherRouteArguments()
              .getTeacherArgument(RoutesConst.trainingSignature),
        );
      } else {
        Navigator.of(context).popUntil((route) => route.isFirst);
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil(RoutesConst.training, (route) => false);
      }
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  Future<void> getAllschoolData(
      {required String region, required String district}) async {
    try {
      // CustomLoadingIndicator.instance.show();
      _setLoading(true);
      log("region---$region------$district");
      await ApiService.instance
          .getHTTP("${ApiRoutes.getAllschooldata}", queryParameters: {
        "sc_region": region,
        "sc_district": district,
      }).then((value) {
        schoolfilterModel = SchoolFilterModel.fromJson(value.data);
        schoolList.clear();
        if (schoolList.isEmpty) {
          schoolfilterModel.data?.schools?.forEach((element) {
            schoolList.add(DropdownSchoolTeacher(
                tcSchoolId: element.scId.toString(),
                tcSchoolName: element.scSchoolName));
          });
          notifyListeners();
          log("added----${schoolList.length}");
        }

        selectedSchoolValue = schoolList.firstWhere((element) {
          log("ddsdsd    ${element.tcSchoolId.toString()} ${AppPreference().getInt(PreferencesKey.schoolId).toString()}");
          return element.tcSchoolId.toString() ==
              AppPreference().getInt(PreferencesKey.schoolId).toString();
        });
        notifyListeners();
        // log(selectedSchoolValue.tcSchoolName.toString());
        // } catch (e) {
        //   log("asas---" + e.toString());
        // }

        // log("data fetched---${teacherProfileModel.data?.teacher?.tcSchoolId}");
        //  regionValue.value = regionList[1];
      });
      _setLoading(false);
    } on Exception catch (e) {
      log("error----" + e.toString());
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      _setLoading(false);
    }
  }
}
