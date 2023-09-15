import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/forgot_password/controller/forgot_pass_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/svgIcon.dart';
import 'package:katon/widgets/text_field.dart';

class PasswordFiled extends StatefulWidget {
  PasswordFiled({Key? key}) : super(key: key);

  @override
  State<PasswordFiled> createState() => _PasswordFiledState();
}

class _PasswordFiledState extends State<PasswordFiled> {
  final cnt = Get.put(ForgotPassCnt());

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key:formGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text("forgot_password".tr,
                      style: FontStyleUtilities.h1(fontWeight: FWT.bold)
                          .copyWith(fontSize: 32))),
              h4,
              Center(
                  child: Text("reset_instruction".tr,
                      style:
                          FontStyleUtilities.h6(fontColor: AppColors.textGrey))),
              h54,
              Text("email".tr,
                  style: FontStyleUtilities.h6(fontWeight: FWT.semiBold)),
              h8,
              TextBox(
                hint: 'email'.tr,
                controller: cnt.emailCnt.value,
                // controller: cnt.loginCnt,
                prefix: SvgIcon(Images.smsSvg),
                validator: (String? email) {
                  String pattern =
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                  RegExp regExp = RegExp(pattern);
                  if (email?.isEmpty ?? false) {
                    return 'Email address is required';
                  } else if (!regExp.hasMatch(email ?? "")) {
                    return 'Please enter valid email address';
                  }
                  return null;
                },
              ),
              h64,
              Center(
                  child: LargeButton(
                onPressed: () {
                  if (formGlobalKey.currentState!.validate()) {
                    cnt.forgetPassword();
                  }
                },
                width: Responsive.isMobile(context) ? Get.width : 448,
                height: Responsive.isMobile(context) ? 45 : 56,
                child: Text(
                  'submit'.tr,
                  style: FontStyleUtilities.h6(
                      fontWeight: FWT.medium, fontColor: AppColors.white),
                ),
              )),
              h16,
              Center(
                  child: LargeButton(
                color: AppColors.white,
                onPressed: () => Get.back(),
                width: Responsive.isMobile(context) ? Get.width : 448,
                borderWidth: 1,
                height: Responsive.isMobile(context) ? 45 : 56,
                borderColor: AppColors.primary,
                child: Text(
                  'Back_to_login'.tr,
                  style: FontStyleUtilities.h6(
                      fontWeight: FWT.medium, fontColor: AppColors.primary),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
