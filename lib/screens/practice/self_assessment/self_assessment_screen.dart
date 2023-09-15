import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/practice/self_assessment/self_assessment_mobile.dart';
import 'package:katon/screens/practice/self_assessment/self_assessment_tablet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

import '../../self_assessment/self_assesment_controller.dart';

class SelfAssessmentScreen extends StatefulWidget {
  final Arguments arguments;

  const SelfAssessmentScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<SelfAssessmentScreen> createState() => _SelfAssessmentScreenState();
}

class _SelfAssessmentScreenState extends State<SelfAssessmentScreen>
    with WidgetsBindingObserver {
  SelfAssessmentController? selfAsscnt;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selfAsscnt =
          Provider.of<SelfAssessmentController>(context, listen: false);
      init();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  init() async {
    await selfAsscnt?.getAllSelfAssessmentList();
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return SelfAssessmentMobile(arguments: widget.arguments);
    } else {
      return SelfAssessmentTablet(arguments: widget.arguments);
    }
  }
}
