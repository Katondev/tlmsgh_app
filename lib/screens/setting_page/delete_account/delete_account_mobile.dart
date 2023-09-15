import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/res.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/textfiled_with_title.dart';
import '../../practice/controller/practice_prv.dart';
import '../setting_cnt.dart';

class DeleteAccountMobile extends StatefulWidget {
  final Arguments arguments;
  const DeleteAccountMobile({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<DeleteAccountMobile> createState() => _DeleteAccountMobileState();
}

class _DeleteAccountMobileState extends State<DeleteAccountMobile> {
  final settingCnt = Get.find<SettingCnt>();

  showDeleteAccountDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            message: "delete_account_des".tr,
            title2: "delete".tr,
            title1: "cancel".tr,
            onSecButtonTap: () async {
              await settingCnt.deleteAccount();
            },
            onFirstButtonTap: () => Navigator.of(context).pop(),
            // child: Container(
            //   height: 100,
            //   width: 300,
            //   decoration: BoxDecoration(color: AppColors.white),
            // ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.boxgreyColor,
        body: Consumer<PracticePrv>(
          builder: (context, ePrv, child) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBar2(
                    isshowback: true,
                    title: widget.arguments.title,
                    description: widget.arguments.description,
                  ),
                  customHeight(15),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        24, 12, 0, 12),
                                    child: Text(
                                      "${widget.arguments.description}",
                                      style: AppTextStyle.normalSemiBold15
                                          .copyWith(
                                        color: AppColors.primaryBlack,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: AppColors.dividerColor,
                                  thickness: 2,
                                  height: 0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "You can delete your TLMS Ghana account at any time. if you change your mind, you might not be able to recover it.",
                                        style: AppTextStyle.normalSemiBold18
                                            .copyWith(
                                          color: AppColors.primaryBlack,
                                        ),
                                      ),
                                      customHeight(30),
                                      LargeButton(
                                        onPressed: () {
                                          showDeleteAccountDialog();
                                        },
                                        height: 44,
                                        width: 300,
                                        child: Text(
                                          "Delete Account",
                                          style: AppTextStyle.normalBold14,
                                        ),
                                        color: AppColors.primaryYellow,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
