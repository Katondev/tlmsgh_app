import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/setting_page/change_password/change_password_cnt.dart';
import 'package:katon/screens/setting_page/change_password/change_password_mobile.dart';
import 'package:katon/screens/setting_page/change_password/change_password_tablet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/utils/config.dart';

class ChangePassword extends StatefulWidget {
  final Arguments arguments;

  ChangePassword({Key? key, required this.arguments}) : super(key: key);
  final cnt = Get.put(ChangePasswordCnt());

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final cnt = Get.put(ChangePasswordCnt());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Responsive.isMobile(context)
          ? ChangePasswordMobilePage(arguments: widget.arguments)
          : ChangePasswordTabletPage(arguments: widget.arguments),
    );
  }
}
