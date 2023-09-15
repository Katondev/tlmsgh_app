import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/edit_profile/controller/edit_profile_cnt.dart';
import 'package:katon/screens/setting_page/setting_mobile.dart';
import 'package:katon/screens/setting_page/setting_tablet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_appbar.dart';

class SettingPage extends StatefulWidget {
  final Arguments arguments;

  const SettingPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? SettingMobile(
            arguments: widget.arguments,
          )
        : SettingTablet(
            arguments: widget.arguments,
          );
  }
}
