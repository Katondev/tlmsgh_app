import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/utils/validators.dart';
import 'package:katon/widgets/password_field.dart';

import 'change_password_cnt.dart';

class ConfirmPasswordField extends StatelessWidget {
  ConfirmPasswordField({Key? key}) : super(key: key);
  final cnt = Get.put(ChangePasswordCnt());

  @override
  Widget build(BuildContext context) {
    return PasswordField(
      hint: "enter_confirm_password".tr,
      width: 634,
      color: Colors.transparent,
      controller: cnt.confirmPasswordCnt,
      onChanged: (value) {
        if (value.length > 0) {
          cnt.isConfirmTextEmpty.value = true;
        } else {
          cnt.isConfirmTextEmpty.value = false;
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      validator: (value) =>
          Validators.validateSamePassword(value, cnt.newPasswordCnt.text),
      // validator: (value) {
      //   RegExp regex = RegExp(
      //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      //   if (value!.isEmpty) {
      //     return "please_enter_confirm_password".tr;
      //   } else if (cnt.newPasswordCnt.text != cnt.confirmPasswordCnt.text) {
      //     return "new_password_and_confirm_password_can't_match".tr;
      //   } else if (!regex.hasMatch(value)) {
      //     return "upper_lower".tr;
      //   } else {
      //     return null;
      //   }
      // },
    );
  }
}

class NewPasswordField extends StatelessWidget {
  NewPasswordField({Key? key}) : super(key: key);

  final cnt = Get.put(ChangePasswordCnt());
  @override
  Widget build(BuildContext context) {
    return PasswordField(
      hint: "enter_new_password".tr,
      width: 634,
      controller: cnt.newPasswordCnt,
      onChanged: (value) {
        if (value.length > 0) {
          cnt.isNewTextEmpty.value = true;
        } else {
          cnt.isNewTextEmpty.value = false;
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      // validator: (value) {
      //   RegExp regex = RegExp(
      //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      //   if (value!.isEmpty) {
      //     return "please_enter_new_password".tr;
      //   } else if (cnt.currentPasswordCnt.text == cnt.newPasswordCnt.text) {
      //     return "new_password_and_old_password_can't_same".tr;
      //   } else if (!regex.hasMatch(value)) {
      //     return "upper_lower".tr;
      //   } else {
      //     log("dsdsdsd");
      //     return null;
      //   }
      // },
      validator: (value) => Validators.validatePassword(value),
    );
  }
}

class OldPasswordField extends StatelessWidget {
  OldPasswordField({Key? key}) : super(key: key);

  final cnt = Get.put(ChangePasswordCnt());

  @override
  Widget build(BuildContext context) {
    return PasswordField(
      hint: "enter_old_password".tr,
      width: 634,
      onChanged: (value) {
        if (value.length > 0) {
          cnt.isCurrentTextEmpty.value = true;
        } else {
          cnt.isCurrentTextEmpty.value = false;
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return "please_enter_old_password".tr;
        } else if (value != cnt.currentPasswordCnt.text) {
          return "old_password_not_valid".tr;
        }
        return null;
      },
      controller: cnt.currentPasswordCnt,
    );
  }
}
