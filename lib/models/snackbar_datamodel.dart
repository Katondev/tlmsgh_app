import 'package:flutter/foundation.dart';

enum SnackBarType { error, success, warning, info }

class SnackBarDataModel {
  final String? message;
  final Duration? duration;
  final Function()? onActionClicked;
  final String? actionLabel;
  final SnackBarType? type;

  SnackBarDataModel({
    @required this.message,
    this.duration,
    this.onActionClicked,
    this.actionLabel,
    this.type,
  });
}
