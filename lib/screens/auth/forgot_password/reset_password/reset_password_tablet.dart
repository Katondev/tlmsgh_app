import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/font_style.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/textfiled_with_title.dart';
import '../controller/forgot_pass_cnt.dart';

class ResetPasswordTablet extends StatefulWidget {
  const ResetPasswordTablet({super.key});

  @override
  State<ResetPasswordTablet> createState() => _ResetPasswordTabletState();
}

class _ResetPasswordTabletState extends State<ResetPasswordTablet> {
  final forgetPassCnt = Get.find<ForgotPassCnt>();
  GlobalKey<FormState> resetpassKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SizedBox(
            width: Get.width,
            child: ListView(
              children: [
                Form(
                  key: resetpassKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Reset Password",
                          textAlign: TextAlign.center,
                          style: FontStyleUtilities.h1(fontWeight: FWT.bold)
                              .copyWith(fontSize: 32)),
                      h50,
                      Obx(
                        () => SizedBox(
                          width: 500,
                          child: TextFiledWithTitle(
                            hint: "Enter Password",
                            title: "Password",
                            obscureText: forgetPassCnt.isobsPass.value,
                            controller: forgetPassCnt.resetPassCnt.value,
                            validator: (value) =>
                                Validators.validatePassword(value),
                                  inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            icon: GestureDetector(
                              onTap: () => forgetPassCnt.isobsPass.value =
                                  !forgetPassCnt.isobsPass.value,
                              child: !forgetPassCnt.isobsPass.value
                                  ? Icon(Icons.visibility_off,
                                      color: AppColors.iconGrey, size: 20)
                                  : const Icon(Icons.visibility,
                                      color: AppColors.iconGrey, size: 20),
                            ),
                            // scrollPadding: true,
                          ),
                        ),
                      ),
                      h20,
                      Obx(
                        () => SizedBox(
                          width: 500,
                          child: TextFiledWithTitle(
                            obscureText: forgetPassCnt.isobscPass.value,
                            controller: forgetPassCnt.resetcPassCnt.value,
                            hint: "Enter Confirm Password",
                            title: "Confirm Password",
                            validator: (value) =>
                                Validators.validateSamePassword(
                              value,
                              forgetPassCnt.resetPassCnt.value.text,
                            ),
                              inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            icon: GestureDetector(
                              onTap: () => forgetPassCnt.isobscPass.value =
                                  !forgetPassCnt.isobscPass.value,
                              child: !forgetPassCnt.isobscPass.value
                                  ? Icon(Icons.visibility_off,
                                      color: AppColors.iconGrey, size: 20)
                                  : const Icon(Icons.visibility,
                                      color: AppColors.iconGrey, size: 20),
                            ),
                            // scrollPadding: true,
                          ),
                        ),
                      ),
                      // Spacer(),
                      h40,
                      LargeButton(
                        width: 400,
                        onPressed: () async {
                          // signupCnt.otpType.value = 1;
                          // await forgetpassCnt.verifyForgotPassword();
                          if (resetpassKey.currentState!.validate()) {
                            await forgetPassCnt.resetPassword();
                          }
                        },
                        child: Text(
                          'Reset Password'.tr,
                          style: FontStyleUtilities.h6(
                              fontWeight: FWT.medium,
                              fontColor: AppColors.white),
                        ),
                      ),
                    ],
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
