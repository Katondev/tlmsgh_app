import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/utils/validators.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/font_style.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/textfiled_with_title.dart';
import '../controller/forgot_pass_cnt.dart';

class ResetPasswordMobile extends StatefulWidget {
  const ResetPasswordMobile({super.key});

  @override
  State<ResetPasswordMobile> createState() => _ResetPasswordMobileState();
}

class _ResetPasswordMobileState extends State<ResetPasswordMobile> {
  final forgetPassCnt = Get.find<ForgotPassCnt>();
  GlobalKey<FormState> resetpassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: resetpassKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Reset Password",
                    textAlign: TextAlign.center,
                    style: FontStyleUtilities.h1(fontWeight: FWT.bold)
                        .copyWith(fontSize: 32)),
                h50,
                Obx(
                  () => TextFiledWithTitle(
                    hint: "Enter Password",
                    title: "Password",
                    obscureText: forgetPassCnt.isobsPass.value,
                    controller: forgetPassCnt.resetPassCnt.value,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    validator: (value) => Validators.validatePassword(value),
                    icon: GestureDetector(
                      onTap: () => forgetPassCnt.isobsPass.value =
                          !forgetPassCnt.isobsPass.value,
                      child: !forgetPassCnt.isobsPass.value
                          ? Icon(Icons.visibility_off,
                              color: AppColors.iconGrey, size: 20)
                          : const Icon(Icons.visibility,
                              color: AppColors.iconGrey, size: 20),
                    ),
                    scrollPadding: true,
                  ),
                ),
                h20,
                Obx(
                  () => TextFiledWithTitle(
                    obscureText: forgetPassCnt.isobscPass.value,
                    controller: forgetPassCnt.resetcPassCnt.value,
                    hint: "Enter Confirm Password",
                    title: "Confirm Password",
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    validator: (value) => Validators.validateSamePassword(
                      value,
                      forgetPassCnt.resetPassCnt.value.text,
                    ),
                    icon: GestureDetector(
                      onTap: () => forgetPassCnt.isobscPass.value =
                          !forgetPassCnt.isobscPass.value,
                      child: !forgetPassCnt.isobscPass.value
                          ? Icon(Icons.visibility_off,
                              color: AppColors.iconGrey, size: 20)
                          : const Icon(Icons.visibility,
                              color: AppColors.iconGrey, size: 20),
                    ),
                    scrollPadding: true,
                  ),
                ),
                Spacer(),
                h20,
                LargeButton(
                  onPressed: () async {
                    // signupCnt.otpType.value = 1;
                    // await forgetpassCnt.verifyForgotPassword();
                    if (resetpassKey.currentState!.validate()) {
                      await forgetPassCnt.resetPassword();
                    }
                  },
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Reset Password'.tr,
                    style: FontStyleUtilities.h6(
                        fontWeight: FWT.medium, fontColor: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
