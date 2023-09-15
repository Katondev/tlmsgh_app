import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/edit_profile/teacher/teacher_edit_profile_mobile.dart';
import 'package:katon/screens/edit_profile/teacher/teacher_edit_profile_tablet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/utils/config.dart';

import '../controller/teacher_edit_profile_cnt.dart';

class TeacherEditProfilePage extends StatefulWidget {
  final Arguments arguments;
  final String title;

  const TeacherEditProfilePage(
      {Key? key, required this.arguments, required this.title})
      : super(key: key);

  @override
  State<TeacherEditProfilePage> createState() => _TeacherEditProfilePageState();
}

class _TeacherEditProfilePageState extends State<TeacherEditProfilePage>
    with WidgetsBindingObserver {
  // final cnt = Get.put(EditProfileCnt());
  final aCnt = Get.put(AppBarCnt());
  final tcnt = Get.put(TeacherEditProfileCnt());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tcnt.init(widget.title);
      tcnt.getAllRegions(context);
    });
    log("${AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeT)}");
    // if (AppPreference().getInt(PreferencesKey.isLoggedInFirstTime) !=1) {
    //   Future.delayed(Duration(milliseconds: 100), () {
    //     showFirstTimeDialog();
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? TeacherEditProfileMobile(
            arguments: widget.arguments,
            title: widget.title,
          )
        : TeacherEditProfileTablet(
            arguments: widget.arguments,
            title: widget.title,
          );
  }
}
