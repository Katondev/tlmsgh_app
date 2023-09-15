import 'package:flutter/material.dart';
import 'package:katon/screens/training/training_options/training_options_mobile.dart';
import 'package:katon/screens/training/training_options/training_options_tablet.dart';

import '../../../models/argument_model.dart';
import '../../../widgets/responsive.dart';

class TrainingOptionsScreen extends StatefulWidget {
  final Arguments arguments;
  const TrainingOptionsScreen({super.key, required this.arguments});

  @override
  State<TrainingOptionsScreen> createState() => _TrainingOptionsScreenState();
}

class _TrainingOptionsScreenState extends State<TrainingOptionsScreen> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobilenew(context)) {
      return TrainingOptionsMobile(
        arguments: widget.arguments,
      );
    } else {
      return TrainingOptionsTablet(
        arguments: widget.arguments,
      );
    }
  }
}
