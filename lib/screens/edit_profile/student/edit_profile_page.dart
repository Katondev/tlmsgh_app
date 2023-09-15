import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/edit_profile/controller/edit_profile_cnt.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_appbar.dart';

import 'edit_profile_mobile.dart';
import 'edit_profile_tablet.dart';

class EditProfilePage extends StatefulWidget {
  final Arguments arguments;
  final String title;

  const EditProfilePage(
      {Key? key, required this.arguments, required this.title})
      : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final cnt = Get.put(EditProfileCnt());
  final aCnt = Get.put(AppBarCnt());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cnt.getStudentInfo();
      cnt.textChanged.value = false;
      aCnt.getStudentInfo();
      cnt.getAllRegions(context);
      // cnt.checkColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? EditProfileMobilePage(
            arguments: widget.arguments,
            title: widget.title,
          )
        : EditProfileTabletPage(
            arguments: widget.arguments,
            title: widget.title,
          );
  }
}
