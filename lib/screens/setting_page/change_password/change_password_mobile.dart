import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/res.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/textfiled_with_title.dart';

import '../../../components/app_text_style.dart';
import '../../../utils/validators.dart';
import '../../../widgets/connection_manager.dart';
import '../../../widgets/no_internet.dart';
import 'change_password_cnt.dart';
import 'common_widgets.dart';

class ChangePasswordMobilePage extends StatefulWidget {
  final Arguments arguments;

  ChangePasswordMobilePage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<ChangePasswordMobilePage> createState() =>
      _ChangePasswordMobilePageState();
}

class _ChangePasswordMobilePageState extends State<ChangePasswordMobilePage> {
  final cnt = Get.put(ChangePasswordCnt());

  final connection = Get.put(ConnectionManagerController());

  final changePasstabKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.boxgreyColor,
        // endDrawer: endDrawer(),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppBar2(
                isshowback: true,
                title: widget.arguments.title,
                description: widget.arguments.description,
              ),
              customHeight(35),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 12, 0, 12),
                                child: Text(
                                  "${widget.arguments.description}",
                                  style: AppTextStyle.normalSemiBold15.copyWith(
                                    color: AppColors.primaryBlack,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors.dividerColor,
                              thickness: 2,
                              height: 0,
                            ),
                            Form(
                              key: changePasstabKey,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextfieldwithTitle(
                                      height: 50,
                                      iconPadding: EdgeInsets.all(16),
                                      controller: cnt.currentPasswordCnt,
                                      hint: "enter_old_password".tr,
                                      title: "old_password".tr,
                                      onChanged: (value) {
                                        if (value!.length > 0) {
                                          cnt.isCurrentTextEmpty.value = true;
                                        } else {
                                          cnt.isCurrentTextEmpty.value = false;
                                        }
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s')),
                                      ],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "please_enter_old_password".tr;
                                        } else if (value !=
                                            cnt.currentPasswordCnt.text) {
                                          return "old_password_not_valid".tr;
                                        }
                                        return null;
                                      },
                                      icon: Image.asset(AppAssets.ic_lock_fill),
                                    ),
                                    h20,
                                    TextfieldwithTitle(
                                      height: 50,
                                      iconPadding: EdgeInsets.all(16),
                                      controller: cnt.newPasswordCnt,
                                      title: "new_password".tr,
                                      hint: "enter_new_password".tr,
                                      onChanged: (value) {
                                        if (value!.length > 0) {
                                          cnt.isNewTextEmpty.value = true;
                                        } else {
                                          cnt.isNewTextEmpty.value = false;
                                        }
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s')),
                                      ],
                                      validator: (value) =>
                                          Validators.validatePassword(value),
                                      icon: Image.asset(AppAssets.ic_lock_fill),
                                    ),
                                    h20,
                                    TextfieldwithTitle(
                                      height: 50,
                                      iconPadding: EdgeInsets.all(16),
                                      title: "confirm_password".tr,
                                      hint: "enter_confirm_password".tr,
                                      controller: cnt.confirmPasswordCnt,
                                      onChanged: (value) {
                                        if (value!.length > 0) {
                                          cnt.isConfirmTextEmpty.value = true;
                                        } else {
                                          cnt.isConfirmTextEmpty.value = false;
                                        }
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s')),
                                      ],
                                      validator: (value) =>
                                          Validators.validateSamePassword(
                                              value, cnt.newPasswordCnt.text),
                                      icon: Image.asset(AppAssets.ic_lock_fill),
                                    ),
                                    customHeight(50),
                                    LargeButton(
                                      onPressed: () {
                                        if (changePasstabKey.currentState!
                                            .validate()) {
                                          cnt.changePassword();
                                        }
                                      },
                                      height: 44,
                                      width: 300,
                                      child: Text(
                                        "Save",
                                        style: AppTextStyle.normalBold14,
                                      ),
                                      color: cnt.isConfirmTextEmpty.value ||
                                              cnt.isCurrentTextEmpty.value ||
                                              cnt.isNewTextEmpty.value
                                          ? AppColors.primaryYellow
                                          : AppColors.gray909090,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
