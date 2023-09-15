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
import 'package:katon/screens/practice/past_questions/past_questions_mobile.dart';
import 'package:katon/screens/practice/past_questions/past_questions_tablet.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

import '../controller/practice_prv.dart';

class PastQuestionsScreen extends StatefulWidget {
  final Arguments arguments;

  const PastQuestionsScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PastQuestionsScreen> createState() =>
      _PastQuestionsScreenState();
}

class _PastQuestionsScreenState extends State<PastQuestionsScreen>
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
    await assignmentPrv?.getAllPastQuestions();
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return PastQuestionsMobile(arguments: widget.arguments);
    } else {
      return PastQuestionsTablet(arguments: widget.arguments);
    }
  }
}
