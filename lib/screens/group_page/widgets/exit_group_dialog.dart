import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/group_page/controller/group_controller.dart';
import '../../../widgets/custom_dialog.dart';

Future showExitGroupDialog(BuildContext context) {
  final grpCnt = Get.find<GroupController>();
  return showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          message: "exit_group".tr,
          title1: "cancel".tr,
          title2: "delete".tr,
          onFirstButtonTap: () {
            Get.back();
          },
          onSecButtonTap: () async {
            Get.back();
            await grpCnt.deleteGroup();
          },
          // child: Container(
          //   height: 100,
          //   width: 300,
          //   decoration: BoxDecoration(color: AppColors.white),
          // ),
        );
      });
}
