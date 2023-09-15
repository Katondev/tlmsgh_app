import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:get/get.dart';
import 'package:katon/screens/connect/connect_mobile_screen.dart';
import 'package:katon/screens/connect/connect_tablet_screen.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:katon/widgets/responsive.dart';

class ConnectPage extends StatelessWidget {
  final Arguments arguments;
  const ConnectPage({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobilenew(context)) {
      return ConnectMobileScreen(arguments: arguments);
    } else {
      return ConnectTabletScreen(arguments: arguments);
    }
  }
}
