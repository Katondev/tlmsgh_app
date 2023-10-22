import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/res.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/drawer/drawer_cnt.dart';
import 'package:katon/widgets/drawer/drawer_item.dart';
import 'package:katon/widgets/responsive.dart';

class DrawerBox extends StatefulWidget {
  final navKey;
  final String? appVersion;

  const DrawerBox({Key? key, this.navKey, this.appVersion}) : super(key: key);

  @override
  State<DrawerBox> createState() => _DrawerBoxState();
}

class _DrawerBoxState extends State<DrawerBox> {
  final cnt = Get.put(DrawerCnt());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Responsive.isMobilenew(context) ? 260 : 280,
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
                  w10,
                  Text(
                    "LMS GHANA",
                    style: AppTextStyle.normalRegular16.copyWith(
                        fontFamily: "Audiowide", color: AppColors.primaryWhite),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      h102,
                      SideBarItem(
                        image: AppAssets.ic_library,
                        title: "Library".tr,
                        isActive: cnt.index.value == 1,
                        onTap: () {
                          cnt.SidebarOnTap(
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
                          //     currentIndex: 4,
                          //     route: RoutesConst.training,
                          //     context: context);
                        },
                      ),
                      SideBarItem(
                        image: AppAssets.ic_profile,
                        title: "Profile".tr,
                        isActive: cnt.index.value == 5,
                        onTap: () {
                          cnt.SidebarOnTap(
                              currentIndex: 5,
                              route: RoutesConst.editProfile,
                              context: context);
                        },
                      ),
                      SideBarItem(
                        image: AppAssets.ic_settings,
                        title: "Settings".tr,
                        isActive: cnt.index.value == 6,
                        onTap: () {
                          cnt.SidebarOnTap(
                              currentIndex: 6,
                              route: RoutesConst.setting,
                              context: context);
                        },
                      ),
                      h16,
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: AppColors.white,
              ),
              h16,
              SideBarItem(
                image: AppAssets.ic_logout,
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
