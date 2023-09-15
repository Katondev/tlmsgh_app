import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/exam_result/exam_result_mobile.dart';
import 'package:katon/screens/exam_result/exam_result_tablet.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/widgets/responsive.dart';

class ExamResultPage extends StatefulWidget {
  final Arguments arguments;

  const ExamResultPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ExamResultPage> createState() => _ExamResultPageState();
}

class _ExamResultPageState extends State<ExamResultPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Material(
            color: AppColors.white,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: onlyTopBottomLeft42,
                  color: AppColors.backGroundColor,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.grey500,
                        blurRadius: 02,
                        offset: Offset(2, 0))
                  ]),
              child: Responsive.isMobile(context)
                  ? ExamResultPageMobile(arguments: widget.arguments)
                  : ExamResultPageTablet(arguments: widget.arguments),
            )));
  }
}

