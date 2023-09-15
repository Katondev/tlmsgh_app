import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/setting_page/change_password/change_password.dart';
import 'package:katon/screens/setting_page/help_and_support/help_and_support_screen.dart';
import 'package:katon/screens/setting_page/setting_cnt.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';
import '../../teacher/drawer.dart';
import '../../widgets/common_appbar.dart';
import '../../widgets/drawer/drawer.dart';
import '../home_page.dart';
import '../practice/controller/practice_prv.dart';
import 'delete_account/delete_account_screen.dart';

class SettingMobile extends StatefulWidget {
  final Arguments arguments;

  const SettingMobile({Key? key, required this.arguments}) : super(key: key);

  @override
  State<SettingMobile> createState() => _SettingMobileState();
}

class _SettingMobileState extends State<SettingMobile> {
  final settingCnt = Get.put(SettingCnt());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.boxgreyColor,
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      appBar: CommonAppbarMobile(title: widget.arguments.title),
      body: Consumer<PracticePrv>(
        builder: (context, ePrv, child) {
          return Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Settings",
                //   style: AppTextStyle.normalBold28.copyWith(
                //     color: AppColors.black,
                //   ),
                // ),
                customHeight(15),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        settingWidget(
                          height: 60,
                          icon: AppAssets.ic_notification,
                          title: "Notifications",
                          suffixIcon: Transform.scale(
                            scale: .5,
                            child: Obx(
                              () => CupertinoSwitch(
                                value: settingCnt.selectedVal.value,

                                activeColor: AppColors.primaryBlack,
                                onChanged: (val) {
                                  settingCnt.selectedVal.value = val;
                                },
                                // materialTapTargetSize:
                                //     MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.dividergreyColor,
                          thickness: 2,
                          height: 0,
                        ),
                        settingWidget(
                            onTap: () {
                              navigatorKey.currentState
                                  ?.pushNamed(RoutesConst.deleteAccount);
                            },
                            height: 60,
                            icon: AppAssets.ic_delete_account,
                            title: "Delete Account"),
                        Divider(
                          color: AppColors.dividergreyColor,
                          thickness: 2,
                          height: 0,
                        ),
                        settingWidget(
                            onTap: () {
                              navigatorKey.currentState
                                  ?.pushNamed(RoutesConst.changePassword);
                            },
                            height: 60,
                            icon: AppAssets.ic_lock,
                            title: "Change Password"),
                        Divider(
                          color: AppColors.dividergreyColor,
                          thickness: 2,
                          height: 0,
                        ),
                        settingWidget(
                            onTap: () {
                              navigatorKey.currentState
                                  ?.pushNamed(RoutesConst.helpAndsupport);
                            },
                            height: 60,
                            icon: AppAssets.ic_help,
                            title: "Help and Support"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget settingWidget(
    {double? height,
    required String icon,
    required String title,
    Widget? suffixIcon,
    void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      color: AppColors.transparentColor,
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            child: Image.asset(icon),
          ),
          customWidth(25),
          Text(
            title,
            style: AppTextStyle.normalBold14.copyWith(
              color: AppColors.primaryBlack,
            ),
          ),
          Spacer(),
          if (suffixIcon != null) suffixIcon,
        ],
      ),
    ),
  );
}
