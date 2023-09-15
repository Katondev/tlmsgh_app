import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularProcessor extends StatelessWidget {
  final double? processPercentage;
  final String? processTitle;
  final Color circleColor;
  final Color strokeColor;

  const CircularProcessor({
    Key? key,
    required this.circleColor,
    required this.strokeColor,
    this.processPercentage,
    this.processTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: NewActCircleProgress(
        circleColor: circleColor,
        strokeColor: strokeColor,
        currentAssesedVillage: processPercentage ?? 0.0,
      ),
      child: Container(
        color: Colors.transparent,
        width: 80,
        child: Center(
          child: Text(
            "$processTitle",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class NewActCircleProgress extends CustomPainter {
  double currentAssesedVillage;
  Color circleColor;
  Color strokeColor;

  NewActCircleProgress({
    required this.currentAssesedVillage,
    required this.circleColor,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //this is base circle
    Paint completeArc = Paint()
      ..strokeWidth = 12
      ..color = strokeColor
      ..style = PaintingStyle.stroke;

    Paint outerCircle = Paint()
      ..strokeWidth = 18
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 10.r;
    double percentage = 100 - currentAssesedVillage;

    canvas.drawCircle(
        center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (percentage / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
