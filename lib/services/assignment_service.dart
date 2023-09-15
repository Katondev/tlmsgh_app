import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/practice/assignment/model/AssignmentQSetMoel.dart';
import 'package:katon/screens/practice/assignment/model/assignment_result.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';

class AssignmentServices {
  Future<AssignmentQSetModel> getAssignmentQSet(int ansId) async {
    try {
      Response questionSet = await ApiService.instance.get(
        "${ApiRoutes.getQsetByAssign}$ansId",
      );

      AssignmentQSetModel asnqs =
          AssignmentQSetModel.fromJson(questionSet.data);
      return asnqs;
    } catch (e) {
      rethrow;
    }
  }

  Future<AssignmentResultDetails> submitResult(
      {required Map<String, dynamic> answer}) async {
    try {
      Response result = await ApiService.instance.postHTTP(
          url: "${ApiRoutes.assignmentResult}",
          body: json.encode(answer),
          headers: {
            'Authorization':
                'Bearer ${AppPreference().getString(PreferencesKey.token)}',
            'Content-Type': "application/json"
          });

      // SnackBarService().showSnackBar(
      //     message: "Assignment Submitted", type: SnackBarType.success);
      return AssignmentResultDetails.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }
}
