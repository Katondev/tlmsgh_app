import 'package:dio/dio.dart';
import 'package:katon/models/Teacher_profile_update_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';

class TeacherProfileUpdateServices {
  Future<Response?> updateTeacherProfile({
    int? tcId,
    String? fullName,
    String? emailId,
    String? altEmail,
    String? mobileNo,
    String? tcalsoKnownAs,
    String? tcBriefProfile,
    String? tcCertificate,
    String? tcexperience,
    String? tcstaffId,
    String? tclevel,
    String? tcregion,
    String? tcdistrict,
    int? tcschoolId,
    String? tclanguageSpoken,
    String? isFirstTimeLogin,
  }) async {
    // TeacherProfileUpdateModel? teacherProfileUpdateModel;
    Response<dynamic>? response;
    String token = AppPreference().getString(PreferencesKey.token);
    try {
      Response updateTeacherData = await ApiService.instance
          .putHTTP(url: ApiRoutes.updateTeacherProfile, body: {
        "tc_id": "$tcId",
        "tc_fullName": "$fullName",
        "tc_email": "$emailId",
        "tc_phoneNumber": "$mobileNo",
        "tc_altEmail": "$altEmail",
        "tc_alsoKnownAs": "$tcalsoKnownAs",
        "tc_briefProfile": "$tcBriefProfile",
        "tc_certificate": "$tcCertificate",
        "tc_experience": "$tcexperience",
        "tc_staffId": "$tcstaffId",
        "tc_level": "$tclevel",
        "tc_region": "$tcregion",
        "tc_district": "$tcdistrict",
        "tc_schoolId": tcschoolId,
        "tc_languageSpoken": "$tclanguageSpoken",
        if (AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeT) != 1)
          "isFirstTimeLogin": 1,
      }, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': "application/json"
      }).then((value) => response = value);
      // teacherProfileUpdateModel =
      //     TeacherProfileUpdateModel.fromJson(updateTeacherData.data);

      return response;
    } catch (e) {
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      rethrow;
    }
  }
}
