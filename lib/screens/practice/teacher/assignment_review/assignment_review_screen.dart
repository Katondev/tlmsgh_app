import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/practice/teacher/assignment_review/assignment_review_mobile.dart';

import '../../../../widgets/responsive.dart';
import 'assignment_review_tablet.dart';

class AssignmentReviewScreen extends StatefulWidget {
  final Arguments arguments;
  const AssignmentReviewScreen({super.key, required this.arguments});

  @override
  State<AssignmentReviewScreen> createState() => _AssignmentReviewScreenState();
}

class _AssignmentReviewScreenState extends State<AssignmentReviewScreen> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return AssignmentReviewMobile(arguments: widget.arguments);
    } else {
      return AssignmentReviewTablet(arguments: widget.arguments);
    }
  }
}
