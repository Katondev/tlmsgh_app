import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/drawer/drawer_cnt.dart';
import 'package:katon/widgets/drawer/drawer_item.dart';
import 'package:katon/widgets/responsive.dart';

import '../components/app_text_style.dart';
import '../res.dart';

class TeacherDrawerBox extends StatefulWidget {
  final navKey;
  final String? appVersion;

  const TeacherDrawerBox({Key? key, this.navKey, this.appVersion})
      : super(key: key);

  @override
  State<TeacherDrawerBox> createState() => _TeacherDrawerBoxState();
}

class _TeacherDrawerBoxState extends State<TeacherDrawerBox> {
  final cnt = Get.put(DrawerCnt());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Responsive.isMobile(context) ? null : 280.w,
      elevation: 0,
      backgroundColor: AppColors.black,
      child: Obx(
        () => SafeArea(
          child: Column(
            children: [
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.ic_splash,
                    width: 34,
                  ),
                  24.horizontalSpace,
                  Text(
                    "TLMS GHANA",
                    style: AppTextStyle.normalRegular16.copyWith(
                        fontFamily: "Audiowide", color: AppColors.primaryWhite),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    h102,
                    SideBarItem(
                      image: AppAssets.ic_library,
                      title: "Teaching Materials".tr,
                      isActive: cnt.index.value == 1,
                      onTap: () {
                        cnt.SidebarOnTap(
                            isTeacher: true,
                            currentIndex: 1,
                            route: RoutesConst.eLearning,
                            context: context);
                      },
                    ),
                    SideBarItem(
                      image: AppAssets.ic_practice,
                      title: "Practice".tr,
                      isActive: cnt.index.value == 2,
                      onTap: () {
                        cnt.SidebarOnTap(
                            isTeacher: true,
                            currentIndex: 2,
                            route: RoutesConst.practice,
                            context: context);
                      },
                    ),
                    SideBarItem(
                      image: AppAssets.ic_connect,
                      title: "Connect".tr,
                      isActive: cnt.index.value == 3,
                      onTap: () {
                        cnt.SidebarOnTap(
                            isTeacher: true,
                            currentIndex: 3,
                            route: RoutesConst.connect,
                            context: context);
                      },
                    ),
                    SideBarItem(
                      image: AppAssets.ic_tution,
                      title: "Tution".tr,
                      isActive: cnt.index.value == 4,
                      onTap: () {
                        // cnt.SidebarOnTap(
                        //     isTeacher: true,
                        //     currentIndex: 4,
                        //     route: RoutesConst.training,
                        //     context: context);
                      },
                    ),
                    SideBarItem(
                      image: AppAssets.ic_training,
                      title: "training".tr,
                      isActive: cnt.index.value == 5,
                      onTap: () {
                        cnt.SidebarOnTap(
                            currentIndex: 5,
                            route: RoutesConst.training,
                            context: context,
                            isTeacher: true);
                      },
                    ),
                    SideBarItem(
                      image: AppAssets.ic_profile,
                      title: "Profile".tr,
                      isActive: cnt.index.value == 6,
                      onTap: () {
                        cnt.SidebarOnTap(
                            currentIndex: 6,
                            route: RoutesConst.editProfile,
                            context: context,
                            isTeacher: true);
                      },
                    ),
                    SideBarItem(
                      image: AppAssets.ic_settings,
                      title: "Settings".tr,
                      isActive: cnt.index.value == 7,
                      onTap: () {
                        cnt.SidebarOnTap(
                            currentIndex: 7,
                            route: RoutesConst.setting,
                            context: context,
                            isTeacher: true);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: AppColors.white,
              ),
              h16,
              SideBarItem(
                icon: Images.logoutSvg,
                title: "log_out".tr,
                isActive: cnt.index.value == 17,
                onTap: () {
                  cnt.logoutDialog(context: context);
                  // cnt.index.value = 12;
                },
              ),
              h16,
              Center(
                child: Text(
                  "${"appversion".tr} ${cnt.appVersion}",
                  style: FontStyleUtilities.t1(
                    fontColor: AppColors.gray400,
                  ).copyWith(overflow: TextOverflow.ellipsis),
                ),
              ),
              h16,
            ],
          ),
        ),
      ),
    );
  }
}
