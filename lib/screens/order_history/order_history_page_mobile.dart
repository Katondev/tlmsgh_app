import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:get/get.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';

class OrderHistoryPageMobile extends StatelessWidget {
  final Arguments? arguments;
  const OrderHistoryPageMobile({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CommonAppbarMobile(title: arguments?.title ?? ""),
      // endDrawer: endDrawerMobile(),
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ColorContainer(
          margin: t5l10r10b15,
          color: AppColors.blueType2,
          title: 'order_history'.tr,
          textStyle: FontStyleUtilities.h4(
              fontColor: AppColors.white, fontWeight: FWT.semiBold),
          svgImage: Images.orderHistory,
          child: Container(
            height: Get.height,
            decoration:
                BoxDecoration(color: AppColors.white, borderRadius: cr24),
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: Text('coming_soon'.tr,
                  style: FontStyleUtilities.h4(
                      fontColor: AppColors.black, fontWeight: FWT.semiBold)),
            ),
          ),
        ),
      ),
    );
  }
}
