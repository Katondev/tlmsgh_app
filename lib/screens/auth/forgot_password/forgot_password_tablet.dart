import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/screens/auth/login/login_cnt.dart';
import 'package:katon/screens/auth/login/widgets/type_of_login_widget.dart';
import 'package:katon/utils/validators.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../../../res.dart';
import '../../../widgets/responsive.dart';
import '../signup/signup_page.dart';
import 'controller/forgot_pass_cnt.dart';

class ForgotPasswordTabletPage extends StatefulWidget {
  ForgotPasswordTabletPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordTabletPage> createState() =>
      _ForgotPasswordTabletPageState();
}

class _ForgotPasswordTabletPageState extends State<ForgotPasswordTabletPage> {
  final cnt = Get.put(ForgotPassCnt());

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: onlyTopBottomLeft42,
              color: AppColors.white,
            ),
            width: Get.width / 2.5,
            padding: EdgeInsets.only(
                right: 76,
                left: 76,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formGlobalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot Password".tr,
                        style: AppTextStyle.normalBold20
                            .copyWith(color: AppColors.primaryYellow),
                      ),
                      h10,
                      Text(
                        "No worries, we’ll send you reset instructions.".tr,
                        style: AppTextStyle.normalRegular12
                            .copyWith(color: AppColors.textFieldhintColor),
                      ),
                      h20,
                      SizedBox(
                        height: 60,
                        width: Get.width,
                        child: textFormField(
                          controller: cnt.emailCnt.value,
                          hintText: "Enter Email",
                          maxLines: 1,
                          // validator: (value) => Validators.validateEmail(value),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 18, 35, 18),
                            child: SizedBox(
                              height: 25,
                              child: Image.asset(
                                AppAssets.ic_mail,
                                color: AppColors.textFieldhintColor,
                                // height: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      h30,
                      Center(
                          child: LargeButton(
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            cnt.forgetPassword();
                          }
                        },
                        width: Responsive.isMobile(context) ? Get.width : 300,
                        height: Responsive.isMobile(context) ? 45 : 50,
                        child: Text(
                          'submit'.tr,
                          style: FontStyleUtilities.h6(
                              fontWeight: FWT.medium,
                              fontColor: AppColors.white),
                        ),
                      )),
                      h16,
                      Center(
                          child: LargeButton(
                        color: AppColors.white,
                        onPressed: () => Get.back(),
                        width:
                            Responsive.isMobilenew(context) ? Get.width : 300,
                        borderWidth: 1,
                        height: Responsive.isMobilenew(context) ? 45 : 50,
                        borderColor: AppColors.primary,
                        child: Text(
                          'Back_to_login'.tr,
                          style: FontStyleUtilities.h6(
                              fontWeight: FWT.medium,
                              fontColor: AppColors.primary),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
