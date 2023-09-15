import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';

class Utility {
  static void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static void showLoader() {
    Get.defaultDialog(
      content: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
