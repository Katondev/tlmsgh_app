import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/practice/student/practice_phone.dart';
import 'package:katon/screens/practice/student/practice_tablet.dart';
import 'package:katon/widgets/responsive.dart';

class PracticeStudentPage extends StatefulWidget {
  final Arguments arguments;

  const PracticeStudentPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticeStudentPage> createState() => PracticeStudentPageState();
}

class PracticeStudentPageState extends State<PracticeStudentPage> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return PracticePagePhone(arguments: widget.arguments);
    } else {
      return PracticePageTablet(arguments: widget.arguments);
    }
  }
}
