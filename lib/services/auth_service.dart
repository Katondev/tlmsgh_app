import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:katon/models/books_model.dart';
import 'package:katon/models/event_model.dart';
import 'package:katon/models/library_book_model.dart';
import 'package:katon/models/message_model.dart';
import 'package:katon/models/notification_model.dart';
import 'package:katon/models/past_paper_details_model.dart';
import 'package:katon/models/past_paper_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/config.dart';

class AuthServices {
  String token = AppPreference().getString(PreferencesKey.token);

  Future<BooksM?> getBooksList() async {
    BooksM? booksM;
    try {
      await ApiService.instance
          .getHTTP("${ApiRoutes.baseURL}book")
          .then((value) {
        booksM = BooksM.fromJson(value.data);
      });
      return booksM;
    } on Exception {
      rethrow;
    }
  }

  // Future<LibraryBookM?> getLibraryBook() async {
  //   LibraryBookM? booksM;
  //   try {
  //     await ApiService.instance
  //         .getHTTP(ApiRoutes.libraryBook, queryParameters: {
  //       "userType": "${AppPreference().uType}",
  //     }).then((value) {
  //       booksM = LibraryBookM.fromJson(value.data);
  //       log("dsdsdsdsdsdsdsdsd---${booksM}");
  //     });
  //     return booksM;
  //   } on Exception catch (e) {
  //     print("object>>${e.toString()}");
  //     rethrow;
  //   }
  // }

  Future<Response?> addLibrary(int bookId) async {
    Response<dynamic>? response;

    try {
      await ApiService.instance.postHTTP(
          url: "${ApiRoutes.addBookLibrary}",
          queryParameters: {
            "bk_id": "$bookId",
            "userType": "${AppPreference().uType}"
          },
          body: {},
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': "application/json"
          }).then((value) {
        response = value;
      });
      
      SnackBarService().showSnackBar(
          message: "Book Added to Library", type: SnackBarType.success);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response?> deleteLibrary(int bookId) async {
    Response<dynamic>? response;

    try {
      await ApiService.instance.deleteHTTP(
          url: "${ApiRoutes.deleteLibrary}",
          queryParameters: {
            "bk_id": "$bookId",
            "userType": "${AppPreference().uType}"
          },
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': "application/json"
          }).then((value) {
        response = value;
      });

      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<Response?> updateProfileAuth({
    required String st_fullName,
    required String st_email,
    required String st_region,
    required String st_district,
    required int sc_schoolId,
    // required String sc_schoolName,
    required String st_countrycode,
    required String st_phoneNumber,
    required String st_altEmail,
    required int st_id,
    required String st_address,
    required String st_class,
    required String st_division,
    required String st_parentName,
    required String st_parentPhoneNumber,
    required String st_parentEmail,
    int? isFirstTimeLogin,
  }) async {
    Response<dynamic>? response;

    try {
      log("scschool----->${sc_schoolId}");
      await ApiService.instance.putHTTP(url: ApiRoutes.updateProfile, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': "application/json"
      }, body: {
        'st_fullName': st_fullName,
        // 'st_email': st_email,
        'st_education': 'm.com',
        'st_region': st_region,
        'st_district': st_district,
        // 'sc_schoolName': sc_schoolName,
        "st_schoolId": sc_schoolId,
        'st_countryCode': st_countrycode,
        'st_circuit': 'surat',
        'st_phoneNumber': st_phoneNumber,
        'st_altEmail': st_altEmail,
        'st_id': st_id,
        'st_address': st_address,
        'st_class': st_class,
        'st_division': st_division,
        'st_parentName': st_parentName,
        'st_parentPhoneNumber': st_parentPhoneNumber,
        'st_parentEmail': st_parentEmail,
        if (AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeSt) != 1)
          "isFirstTimeLogin": 1,
      }).then((value) {
        response = value;
      });
      return response;
    } catch (e) {
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      rethrow;
    }
  }

  Future<NotificationResponseModel?> getNotificationDetail() async {
    NotificationResponseModel? notificationResponseModel;
    try {
      int schoolId = AppPreference().getInt(PreferencesKey.student_school_Id);
      String studentclass =
          AppPreference().getString(PreferencesKey.student_class);
      log("${ApiRoutes.baseURL}notification/get-------${schoolId}-----${studentclass}");
      await ApiService.instance.getHTTP(
        "${ApiRoutes.baseURL}notification/get",
        queryParameters: {"sc_id": schoolId, "st_class": studentclass},
      ).then((value) {
        log("object$value");
        notificationResponseModel =
            NotificationResponseModel.fromJson(value.data);
      });
      log(notificationResponseModel.toString());
      return notificationResponseModel;
    } on Exception {
      rethrow;
    }
  }

  Future<EventResponseModel?> getEventsDetail() async {
    EventResponseModel? eventResponseModel;
    try {
      int schoolId = AppPreference().getInt(PreferencesKey.student_school_Id);
      String studentclass =
          AppPreference().getString(PreferencesKey.student_class);
      await ApiService.instance.getHTTP(
        "${ApiRoutes.baseURL}eventCalender/get",
        queryParameters: {"sc_id": schoolId, "st_class": studentclass},
      ).then((value) {
        eventResponseModel = EventResponseModel.fromJson(value.data);
      });
      return eventResponseModel;
    } on Exception {
      rethrow;
    }
  }

  Future<MessageResponseModel?> getAllMessages() async {
    MessageResponseModel? messageResponseModel;
    try {
      int stClass = AppPreference().getInt(PreferencesKey.student_class_Id);
      int student = AppPreference().getInt(PreferencesKey.student_Id);
      int stSchool = AppPreference().getInt(PreferencesKey.student_school_Id);
      await ApiService.instance
          .get("${ApiRoutes.getAllMessages}", queryParameters: {
        "sm_student": student,
        "cr_id": stClass,
        "sc_id": stSchool,
      }).then((value) {
        messageResponseModel = MessageResponseModel.fromJson(value.data);
      });
      return messageResponseModel;
    } on Exception {
      rethrow;
    }
  }

  Future<PastPaperModel?> getAllPastPaper() async {
    PastPaperModel? pastPaperModel;
    try {
      await ApiService.instance
          .get("${ApiRoutes.getAllPastPaper}")
          .then((value) {
        pastPaperModel = PastPaperModel.fromJson(value.data);
      });
      return pastPaperModel;
    } on Exception {
      rethrow;
    }
  }

  Future<PastPaperDetailModel?> getPastPaperDetail({int? PaperId}) async {
    PastPaperDetailModel? pastPaperDetailModel;
    try {
      await ApiService.instance.get("${ApiRoutes.getPastPaperDetail}",
          queryParameters: {"pp_id": "$PaperId"}).then((value) {
        pastPaperDetailModel = PastPaperDetailModel.fromJson(value.data);
      });
      return pastPaperDetailModel;
    } on Exception {
      rethrow;
    }
  }
}
