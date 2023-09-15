import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';

import '../../../../components/app_text_style.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/responsive.dart';
import '../../setting_cnt.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final Arguments arguments;
  const PrivacyPolicyScreen({super.key, required this.arguments});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final settingCnt = Get.find<SettingCnt>();
  @override
  Widget build(BuildContext context) {
    return (Responsive.isMobilenew(context))
        ? Material(
            color: AppColors.white,
            child: SafeArea(
              child: Container(
                // decoration: BoxContainer.boxDeco,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: AppColors.boxgreyColor,
                  body: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonAppBar2(
                          isshowback: true,
                          title: widget.arguments.title,
                          description: widget.arguments.description,
                        ),
                        customHeight(35),
                        Expanded(
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: AppColors.boxgreyColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: settingCnt.privacyList.length,
                              itemBuilder: (context, i) {
                                var data = settingCnt.privacyList[i];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (data["title"] != "")
                                      Text(
                                        "${data["title"]}",
                                        style:
                                            AppTextStyle.normalBold16.copyWith(
                                          color: AppColors.primaryBlack,
                                        ),
                                      ),
                                    if (data["title"] != "") h12,
                                    Text(
                                      "${data["description"]}",
                                      style:
                                          AppTextStyle.normalRegular12.copyWith(
                                        color: AppColors.primaryBlack,
                                      ),
                                    ),
                                    h16,
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Material(
            color: AppColors.white,
            child: SafeArea(
              child: Container(
                // decoration: BoxContainer.boxDeco,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.transparent,
                  body: Container(
                    padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
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
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: AppColors.boxgreyColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.fromLTRB(36, 69, 36, 0),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: settingCnt.privacyList.length,
                              itemBuilder: (context, i) {
                                var data = settingCnt.privacyList[i];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (data["title"] != "")
                                      Text(
                                        "${data["title"]}",
                                        style:
                                            AppTextStyle.normalBold16.copyWith(
                                          color: AppColors.primaryBlack,
                                        ),
                                      ),
                                    if (data["title"] != "") h12,
                                    Text(
                                      "${data["description"]}",
                                      style:
                                          AppTextStyle.normalRegular12.copyWith(
                                        color: AppColors.primaryBlack,
                                      ),
                                    ),
                                    h16,
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
