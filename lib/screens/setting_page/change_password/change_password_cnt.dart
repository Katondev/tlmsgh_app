import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/loading_indicator.dart';

class ChangePasswordCnt extends GetxController {
  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController confirmPasswordCnt = TextEditingController();
  TextEditingController newPasswordCnt = TextEditingController();
  TextEditingController currentPasswordCnt = TextEditingController();
  RxBool isConfirmTextEmpty = false.obs;
  RxBool isNewTextEmpty = false.obs;
  RxBool isCurrentTextEmpty = false.obs;
  RxBool connection = false.obs;

  Future changePassword() async {
    String token = AppPreference().getString(PreferencesKey.token);
    CustomLoadingIndicator.instance.show();
    connection.value = true;
    try {
      await ApiService.instance.putHTTP(
        url: ApiRoutes.changePassword,
        body: {
          "oldPassword": currentPasswordCnt.value.text.trim(),
          "newPassword": newPasswordCnt.value.text.trim(),
          "userId": AppPreference().getInt(PreferencesKey.uId),
          "userType": AppPreference().getString(PreferencesKey.uType),
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': "application/json"
        },
      );
      CustomLoadingIndicator.instance.hide();
      Get.offAllNamed(RoutesConst.loginPage);
    } catch (e) {
      if (e == "No Internet") {
        connection.value = false;
      }
      CustomLoadingIndicator.instance.hide();
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
    }
  }
}
