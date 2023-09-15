import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/group_page/controller/group_controller.dart';
import 'package:katon/utils/app_binding.dart';
import 'package:katon/utils/validators.dart';
import 'package:katon/widgets/text_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/font_style.dart';
import '../../../widgets/button.dart';

Future showCreateGroupDialog(BuildContext context) {
  final grpCnt = Get.find<GroupController>();
  final createGroupKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: StatefulBuilder(
          builder: (context, setState) => Container(
            width: 600,
            height: 400,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            // padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Create Group",
                            style:
                                FontStyleUtilities.h5(fontWeight: FWT.medium),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.close,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, height: 0),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(20),
                      physics: BouncingScrollPhysics(),
                      children: [
                        Form(
                          key: createGroupKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBox(
                                  hint: "Enter Group Name",
                                  controller: grpCnt.groupName.value,
                                  validator: (val) =>
                                      Validators.validaterequired(
                                          val, "enter_group_name".tr),
                                  fillColor: AppColors.boxgrey,
                                ),
                                h16,
                                TextBox(
                                  hint: "Enter Group Description",
                                  controller: grpCnt.groupDesc.value,
                                  validator: (val) =>
                                      Validators.validaterequired(
                                          val, "enter_group_des".tr),
                                  maxLines: 5,
                                  fillColor: AppColors.boxgrey,
                                ),
                                h30,
                                LargeButton(
                                  onPressed: () async {
                                    if (createGroupKey.currentState!
                                        .validate()) {
                                      navigatorKey.currentState!.pop();
                                      await grpCnt.addGroup();
                                    }
                                  },
                                  height: 50,
                                  width: Get.width,
                                  child: Text(
                                    "submit".tr,
                                    style: FontStyleUtilities.t1(
                                        fontWeight: FWT.medium,
                                        fontColor: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
