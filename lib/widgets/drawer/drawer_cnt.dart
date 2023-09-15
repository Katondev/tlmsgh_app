import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/screens/auth/login/login_cnt.dart';
import 'package:katon/screens/auth/login/login_page.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';
import '../../screens/home_page.dart';

class DrawerCnt extends GetxController {
  RxInt index = 0.obs;
  RxString appVersion = "".obs;

  Future logoutDialog({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
          message: "Are you sure you want to logout?",
          title1: "No",
          onFirstButtonTap: () => Navigator.of(context).pop(),
          title2: "Yes",
          onSecButtonTap: () async {
            AppPreference().getString(PreferencesKey.myLibraryData);
            // if (bookdata.isNotEmpty) {
            //   Get.put(ELearningCnt()).books.value =
            //       BookDetailsM.decode(bookdata);
            // }
            Provider.of<ELearningProvider>(context, listen: false)
                .mainCategoryMList
                .clear();
            await AppPreference().clearSharedPreferences();
            log("---${AppPreference().getString(PreferencesKey.myLibraryData)}");
            Get.offAll(LoginPage());
            index.value = 0;
            // print("index.value${index.value}");
          }),
    );
  }

  void SidebarOnTap(
      {required int currentIndex,
      required String route,
      required BuildContext context,
      bool? isTeacher}) {
    Future.delayed(
      Duration(milliseconds: 0),
      () {
        if (isTeacher ?? false) {
          index.value = currentIndex;
          navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(route, (r) => false);
        } else {
          Map<String, dynamic> userData =
              jsonDecode(AppPreference().getString(PreferencesKey.studentData));
          final student = SignInModel.fromJson(userData);
          if (student.data?.student?.stClass != null &&
                  student.data?.student?.stDivision != null ||
              student.data?.student?.stClass != '' &&
                  student.data?.student?.stDivision != '') {
            index.value = currentIndex;
            navigatorKey.currentState
                ?.pushNamedAndRemoveUntil(route, (r) => false);
            log(index.value.toString());
            log(navigatorKey.currentState.toString());
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                message: "Student Class and Division Must be Required",
                title1: "Ok",
                onFirstButtonTap: () => Navigator.of(context).pop(),
              ),
            );
          }
        }
      },
    );
  }
}
