import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/widgets/responsive.dart';

import '../../../../components/app_text_style.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/common_appbar.dart';
import '../../setting_cnt.dart';

class FAQScreen extends StatefulWidget {
  final Arguments arguments;
  const FAQScreen({super.key, required this.arguments});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
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
                              itemCount: settingCnt.FAQList.length,
                              itemBuilder: (context, i) {
                                var data = settingCnt.FAQList[i];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data["question"]}",
                                      style: AppTextStyle.normalBold12.copyWith(
                                        color: AppColors.primaryBlack,
                                      ),
                                    ),
                                    Text(
                                      "${data["answer"]}",
                                      style:
                                          AppTextStyle.normalRegular12.copyWith(
                                        color: AppColors.primaryBlack,
                                      ),
                                    ),
                                    h10,
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
                            padding: EdgeInsets.fromLTRB(36, 50, 36, 0),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: settingCnt.FAQList.length,
                              itemBuilder: (context, i) {
                                var data = settingCnt.FAQList[i];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data["question"]}",
                                      style: AppTextStyle.normalBold12.copyWith(
                                        color: AppColors.primaryBlack,
                                      ),
                                    ),
                                    Text(
                                      "${data["answer"]}",
                                      style:
                                          AppTextStyle.normalRegular12.copyWith(
                                        color: AppColors.primaryBlack,
                                      ),
                                    ),
                                    h10,
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
