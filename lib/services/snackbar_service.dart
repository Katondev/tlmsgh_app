import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/utils/config.dart';

class SnackBarService {
  showSnackBar({
    @required String? message,
    SnackBarDataModel? snackBar,
    Function()? onActionClicked,
    Duration? duration,
    SnackBarType? type,
    String? actionLabel,
    SnackPosition? position,
    EdgeInsets? margin,
  }) {
    return Get.rawSnackbar(
        message: message,
        backgroundColor: _backgroundColor(type ?? SnackBarType.info),
        maxWidth: 350,
        borderRadius: 12.r,
        duration: duration ?? const Duration(seconds: 3),
        snackPosition: position ?? SnackPosition.BOTTOM,
        margin: margin ?? all8);
  }

  Color _backgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.error:
        return AppColors.red;
      case SnackBarType.success:
        return AppColors.green;
      case SnackBarType.warning:
        return AppColors.orange;
      default:
        return AppColors.blue;
    }
  }
}
