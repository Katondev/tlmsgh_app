import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/training/training_resources/training_resources_mobile.dart';
import 'package:katon/screens/training/training_resources/training_resources_tablet.dart';

import '../../../widgets/responsive.dart';

class TrainingResourcesScreen extends StatefulWidget {
  final Arguments arguments;
  const TrainingResourcesScreen({super.key, required this.arguments});

  @override
  State<TrainingResourcesScreen> createState() =>
      _TrainingResourcesScreenState();
}

class _TrainingResourcesScreenState extends State<TrainingResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobilenew(context)) {
      return TrainingResourcesMobile(
        arguments: widget.arguments,
      );
    } else {
      return TrainingResourcesTablet(
        arguments: widget.arguments,
      );
    }
  }
}
