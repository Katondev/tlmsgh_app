import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/screens/edit_profile/controller/edit_profile_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/dropdown.dart';
import 'package:katon/widgets/textfiled_with_title.dart';

import '../../../components/app_text_style.dart';
import '../../../widgets/drawer/drawer_cnt.dart';
import '../../home_page.dart';

class ClassDropDown extends StatelessWidget {
  ClassDropDown({Key? key}) : super(key: key);
  final cnt = Get.put(EditProfileCnt());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'class'.tr,
              style: AppTextStyle.normalBold12.copyWith(
                color: AppColors.primaryBlack,
              ),
            ),
            w4,
            Text(
              "*",
              style: AppTextStyle.normalBold12.copyWith(
                color: AppColors.appbarRed,
              ),
            ),
          ],
        ),
        h8,
        DropDownCustom<DropdownClasses>(
          onChange: (value) {
            cnt.classValue.value = value!;
            cnt.checkColor();
          },
          validator: (value) {
            if (value!.label!.isEmpty) {
              return "require_class".tr;
            }
            return null;
          },
          selectedValue:
              (cnt.classValue.value.label == null) ? null : cnt.classValue,
          items: cnt.classList
              .map((e) => DropdownMenuItem<DropdownClasses>(
                  enabled: e.enable ?? true,
                  value: e,
                  child: Text(
                    "${e.label}",
                    style: e.enable!
                        ? AppTextStyle.normalRegular12
                        : AppTextStyle.normalRegular12
                            .copyWith(color: Colors.black54),
                  )))
              .toList(),
        ),
      ],
    );
  }
}

class BirthDateTextFiled extends StatelessWidget {
  BirthDateTextFiled({Key? key}) : super(key: key);
  final cnt = Get.put(EditProfileCnt());

  @override
  Widget build(BuildContext context) {
    return TextFiledWithTitle(
      hint: "2022-08-11",
      title: 'date_of_birth'.tr,
      controller: cnt.dateCnt.value,
      readOnly: true,
      onChanged: (p0) => cnt.checkColor(),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          cnt.selectedDatePick = picked;
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          cnt.dateCnt.value.text = formatter.format(cnt.selectedDatePick);
        }
        cnt.checkColor();
      },
    );
  }
}

class CancelButton extends StatelessWidget {
  final double width;
  final double height;
  const CancelButton({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LargeButton(
      width: width,
      height: height,
      onPressed: () {},
      borderWidth: 2,
      textColor: AppColors.primaryColor,
      color: AppColors.primary,
      // color: const Color(0xffD9DFFC),
      child: Text(
        "Cancel".tr,
        style: FontStyleUtilities.h6(
            fontWeight: FWT.medium, fontColor: AppColors.primaryColor),
      ),
    );
  }
}

class SaveChangesButton extends StatelessWidget {
  final double width;
  final double height;
  bool isTextChanged;
  SaveChangesButton(
      {Key? key,
      required this.width,
      required this.height,
      this.isTextChanged = false})
      : super(key: key);
  final cnt = Get.put(EditProfileCnt());
  final dcnt = Get.put(DrawerCnt());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LargeButton(
          width: width,
          height: height,
          onPressed: (cnt.checkColor())
              ? () async {
                 await cnt.updateProfilePic();
                  if (cnt.formKey.currentState!.validate()) {
                  
                     
                  
                    cnt.updateProfile().then((value) {
                      if (AppPreference()
                              .getInt(PreferencesKey.isLoggedInFirstTimeSt) !=
                          1) {
                        Future.delayed(Duration(milliseconds: 100), () {
                          cnt.showFirstTimeEditCompleteDialog(context);
                        });

                        // dcnt.index.value = 1;
                        cnt.checkColor();
                      }
                    });
                    primaryFocus?.unfocus();
                  }
                  cnt.checkColor();
                }
              : () {
                  // print("object");
                },
          borderRadius: BorderRadius.circular(10),
          color: isTextChanged ? cnt.buttonColor?.value : AppColors.gray300,
          child: Text(
            "save_changes".tr,
            style: AppTextStyle.normalBold14,
          )),
    );
  }
}
