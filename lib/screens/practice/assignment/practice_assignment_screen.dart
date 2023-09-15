import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/models/teacher_sign_in_model.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/screens/library_page/library_mobile.dart';
import 'package:katon/screens/library_page/library_tablet.dart';
import 'package:katon/screens/message/message_cnt.dart';
import 'package:katon/screens/practice/assignment/practice_assignment_mobile.dart';
import 'package:katon/screens/practice/assignment/practice_assignment_tablet.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

import '../controller/practice_prv.dart';

class PracticeAssignmentScreen extends StatefulWidget {
  final Arguments arguments;

  const PracticeAssignmentScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticeAssignmentScreen> createState() =>
      _PracticeAssignmentScreenState();
}

class _PracticeAssignmentScreenState extends State<PracticeAssignmentScreen>
    with WidgetsBindingObserver {
  PracticePrv? assignmentPrv;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      assignmentPrv = Provider.of<PracticePrv>(context, listen: false);
      init();
    });
  }

  init() async {
    await assignmentPrv?.getAllAssignment();
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return PracticeAssignmentMobile(arguments: widget.arguments);
    } else {
      return PracticeAssignmentTablet(arguments: widget.arguments);
    }
  }
}
