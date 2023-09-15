import 'package:dio/dio.dart';
import 'package:katon/models/parent_profile_update_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';

class ParentProfileUpdateServices {
  Future<ParentProfileUpdateModel?> updateParentProfile(
      {String? fullName, String? emailId, String? mobileNo}) async {
    ParentProfileUpdateModel? parentProfileUpdateModel;
    String token = AppPreference().getString(PreferencesKey.token);
    print("parent");
    try {
      Response updateParentData = await ApiService.instance
          .putHTTP(url: ApiRoutes.parentProfile, body: {
        "pt_id": 37,
        "pt_fullName": "$fullName",
        "pt_email": "$emailId",
        "pt_phoneNumber": "$mobileNo"
      }, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': "application/json"
      });
      parentProfileUpdateModel =
          ParentProfileUpdateModel.fromJson(updateParentData.data);
      if (updateParentData.statusCode == 200) {
        SnackBarService().showSnackBar(
            message: parentProfileUpdateModel.message,
            type: SnackBarType.success);
      }
      return parentProfileUpdateModel;
    } catch (e) {
      rethrow;
    }
  }
}
