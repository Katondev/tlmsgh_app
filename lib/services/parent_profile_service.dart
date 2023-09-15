
import 'package:dio/dio.dart';
import 'package:katon/models/parent_profile_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';

class ParentProfileServices {
  Future<ParentProfileModel?> getParentProfile() async {
    ParentProfileModel? parentProfileModel;
    try {
      Response profileData = await ApiService.instance.get(
        ApiRoutes.parentProfile,
      );
      parentProfileModel = ParentProfileModel.fromJson(profileData.data);
      return parentProfileModel;
    } catch (e) {
      rethrow;
    }
  }
}
