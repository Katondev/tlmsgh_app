import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:katon/models/teacher_profile_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';

class TeacherProfileServices {
  Future<TeacherProfileModel?> getTeacherProfile() async {
    TeacherProfileModel? teacherProfileModel;
    try {
      Response profileData =
          await ApiService.instance.get(ApiRoutes.teacherProfile);
      teacherProfileModel = TeacherProfileModel.fromJson(profileData.data);
      log(teacherProfileModel.data.toString());
      return teacherProfileModel;
    } catch (e) {
      rethrow;
    }
  }
}
