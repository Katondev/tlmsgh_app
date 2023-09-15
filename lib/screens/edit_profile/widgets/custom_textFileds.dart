import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/screens/edit_profile/controller/edit_profile_cnt.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/svgIcon.dart';
import 'package:katon/widgets/textfiled_with_title.dart';

class CustomTextFiledS extends StatelessWidget {
  CustomTextFiledS({Key? key}) : super(key: key);

  final cnt = Get.put(EditProfileCnt());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text("student_details".tr,
        //     style: FontStyleUtilities.h6(fontColor: AppColors.grey500)),
        // h18,
        TextfieldwithTitle(
          onChanged: (val) {
            if (!cnt.textChanged.value) {
              cnt.textChanged.value = true;
            }
            cnt.checkColor();
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "require_fullname".tr;
            }
            return null;
          },
          hint: "bratund_russell".tr,
          title: 'full_name'.tr,
          controller: cnt.fullName.value,
          isrequired: true,
        ),

        h12,
        TextfieldwithTitle(
          onChanged: (val) {
            if (!cnt.textChanged.value) {
              cnt.textChanged.value = true;
            }
            cnt.checkColor();
          },
          hint: "email_id".tr,
          title: 'email_id'.tr,
          isrequired: true,
          controller: cnt.emailCnt.value,
          validator: (value) {
            String pattern =
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]+.com"
                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?)*$";
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!)) {
              return 'valid_email'.tr;
            } else {
              return null;
            }
          },
          copyOnTap: () {
            FocusScope.of(context).unfocus();
            if (cnt.emailCnt.value.text != "") {
              Clipboard.setData(ClipboardData(text: cnt.emailCnt.value.text));
              SnackBarService().showSnackBar(
                message: "copy_successfully".tr,
                type: SnackBarType.success,
              );
            } else {
              SnackBarService().showSnackBar(
                message: "please_enter_email".tr,
                type: SnackBarType.error,
              );
            }
          },
          icon: SvgIcon(Images.copy),
        ),
        h12,
        TextfieldwithTitle(
          onChanged: (val) {
            if (!cnt.textChanged.value) {
              cnt.textChanged.value = true;
            }
            cnt.checkColor();
          },
          hint: "enter_alternative_email".tr,
          title: "${'alternative_email'.tr} ${'alternative_email_ideal'.tr}",
          controller: cnt.altemailCnt.value,
          // validator: (value) {
          //   String pattern =
          //       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]+.com"
          //       r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          //       r"{0,253}[a-zA-Z0-9])?)*$";
          //   RegExp regex = RegExp(pattern);
          //   if (!regex.hasMatch(value!)) {
          //     return 'valid_email'.tr;
          //   } else {
          //     return null;
          //   }
          // },
          copyOnTap: () {
            FocusScope.of(context).unfocus();
            if (cnt.altemailCnt.value.text != "") {
              Clipboard.setData(
                  ClipboardData(text: cnt.altemailCnt.value.text));
              SnackBarService().showSnackBar(
                message: "copy_successfully".tr,
                type: SnackBarType.success,
              );
            } else {
              SnackBarService().showSnackBar(
                message: "please_enter_email".tr,
                type: SnackBarType.error,
              );
            }
          },
          icon: SvgIcon(Images.copy),
        ),
        h12,
        TextfieldwithTitle(
          onChanged: (val) {
            if (!cnt.textChanged.value) {
              cnt.textChanged.value = true;
            }
            cnt.checkColor();
          },
          hint: "enter_student_id".tr,
          title: 'student_id'.tr,
          controller: cnt.stIdCnt.value,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
