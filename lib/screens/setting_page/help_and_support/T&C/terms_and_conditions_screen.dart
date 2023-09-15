import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';

import '../../../../components/app_text_style.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/responsive.dart';
import '../../setting_cnt.dart';

class TermsandConditionScreen extends StatefulWidget {
  final Arguments arguments;
  const TermsandConditionScreen({super.key, required this.arguments});

  @override
  State<TermsandConditionScreen> createState() =>
      _TermsandConditionScreenState();
}

class _TermsandConditionScreenState extends State<TermsandConditionScreen> {
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
                              itemCount: settingCnt.TandCList.length,
                              itemBuilder: (context, i) {
                                var data = settingCnt.TandCList[i];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data["mainTitle"]}",
                                      style: AppTextStyle.normalBold12.copyWith(
                                          color: AppColors.primaryBlack,
                                          fontSize: 15),
                                    ),
                                    h5,
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: data["subList"].length,
                                        itemBuilder: (context, i) {
                                          var dd = data["subList"][i];
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (dd["title"] != "")
                                                Text(
                                                  "${dd["title"]}",
                                                  style: AppTextStyle
                                                      .normalBold12
                                                      .copyWith(
                                                    color:
                                                        AppColors.primaryBlack,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              if (dd["title"] != "") h4,
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text(
                                                  "${dd["description"]}",
                                                  style: AppTextStyle
                                                      .normalSemiBold12
                                                      .copyWith(
                                                    color:
                                                        AppColors.primaryBlack,
                                                  ),
                                                ),
                                              ),
                                              h10,
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    h20,
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
                            padding: EdgeInsets.fromLTRB(36, 50, 36, 50),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: settingCnt.TandCList.length,
                              itemBuilder: (context, i) {
                                var data = settingCnt.TandCList[i];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data["mainTitle"]}",
                                      style: AppTextStyle.normalBold12.copyWith(
                                          color: AppColors.primaryBlack,
                                          fontSize: 15),
                                    ),
                                    h5,
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: data["subList"].length,
                                        itemBuilder: (context, i) {
                                          var dd = data["subList"][i];
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (dd["title"] != "")
                                                Text(
                                                  "${dd["title"]}",
                                                  style: AppTextStyle
                                                      .normalBold12
                                                      .copyWith(
                                                    color:
                                                        AppColors.primaryBlack,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              if (dd["title"] != "") h4,
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text(
                                                  "${dd["description"]}",
                                                  style: AppTextStyle
                                                      .normalSemiBold12
                                                      .copyWith(
                                                    color:
                                                        AppColors.primaryBlack,
                                                  ),
                                                ),
                                              ),
                                              h10,
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    h20,
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
