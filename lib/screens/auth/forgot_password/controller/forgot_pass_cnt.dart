import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/home/dash_board.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/widgets/loading_indicator.dart';

class ForgotPassCnt extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Rx<TextEditingController> emailCnt = TextEditingController().obs;
  Rx<TextEditingController> OtpCnt = TextEditingController().obs;
  Rx<TextEditingController> resetPassCnt = TextEditingController().obs;
  Rx<TextEditingController> resetcPassCnt = TextEditingController().obs;
  RxBool isobsPass = true.obs;
  RxBool isobscPass = true.obs;

  // Future forgotPassword() async {
  //   if (formGlobalKey.currentState?.validate() ?? false) {
  //     CustomLoadingIndicator.instance.show();
  //     try {
  //       await ApiService.instance
  //           .postHTTP(url: ApiRoutes.forgotPassword, body: {
  //         'forgotPassword': emailCnt.text,
  //       });
  //       CustomLoadingIndicator.instance.hide();
  //       Get.to(() => DashBoard(
  //           arguments:
  //               Arguments(title: "title".tr, description: "description".tr)));
  //     } catch (e) {
  //       SnackBarService()
  //           .showSnackBar(message: e.toString(), type: SnackBarType.success);
  //       CustomLoadingIndicator.instance.hide();
  //     }
  //   }
  // }
  Future forgetPassword() async {
    CustomLoadingIndicator.instance.show();
    try {
      await ApiService.instance
          .getHTTP(ApiRoutes.forgotPassword, queryParameters: {
        'email': emailCnt.value.text.trim(),
        'userType': AppPreference().getString(PreferencesKey.uType),
      });
      CustomLoadingIndicator.instance.hide();
      SnackBarService().showSnackBar(
          message: "Verification code has been sent",
          type: SnackBarType.success);

      Get.toNamed(RoutesConst.forgetPasswordVerification);
    } catch (e) {
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }

  Future verifyForgotPassword() async {
    CustomLoadingIndicator.instance.show();
    try {
      await ApiService.instance
          .getHTTP(ApiRoutes.verifyforgotPassword, queryParameters: {
        'emailOrPhone': emailCnt.value.text.trim(),
        'userType': AppPreference().getString(PreferencesKey.uType),
        'otp': OtpCnt.value.text.trim(),
        'verifyType': 1,
      });
      CustomLoadingIndicator.instance.hide();
      OtpCnt.value.clear();
      Get.toNamed(RoutesConst.resetPassword);
      // Get.to(() => DashBoard(
      //     arguments:
      //         Arguments(title: "title".tr, description: "description".tr)));
    } catch (e) {
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }

  Future resetPassword() async {
    CustomLoadingIndicator.instance.show();
    try {
      await ApiService.instance
          .getHTTP(ApiRoutes.resetPassword, queryParameters: {
        'emailOrPhone': emailCnt.value.text.trim(),
        'userType': AppPreference().getString(PreferencesKey.uType),
        'password': resetcPassCnt.value.text.trim(),
        'verifyType': 1,
      });
      CustomLoadingIndicator.instance.hide();
      emailCnt.value.clear();
      OtpCnt.value.clear();
      resetPassCnt.value.clear();
      resetcPassCnt.value.clear();
      Get.offAllNamed(RoutesConst.loginPage);
      // Get.to(() => DashBoard(
      //     arguments:
      //         Arguments(title: "title".tr, description: "description".tr)));
    } catch (e) {
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }
}
