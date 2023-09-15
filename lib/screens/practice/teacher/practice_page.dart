import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/practice/teacher/practice_phone.dart';
import 'package:katon/screens/practice/teacher/practice_tablet.dart';
import 'package:katon/widgets/responsive.dart';

class PracticeTeacherPage extends StatefulWidget {
  final Arguments arguments;

  const PracticeTeacherPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticeTeacherPage> createState() => PracticeTeacherPageState();
}

class PracticeTeacherPageState extends State<PracticeTeacherPage> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return PracticeTeacherPagePhone(arguments: widget.arguments);
    } else {
      return PracticeTeacherPageTablet(arguments: widget.arguments);
    }
  }
}
