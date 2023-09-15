import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/about_page/about_page_common_widget.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import '../home_page.dart';

class AboutPageMobilePage extends StatelessWidget {
  final Arguments? arguments;
  const AboutPageMobilePage({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: CommonAppbarMobile(title: arguments?.title ?? ""),
      // endDrawer: endDrawerMobile(),
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ColorContainer(
            svgImage: Images.aboutUsSvg,
            title: 'about_us'.tr,
            textStyle: FontStyleUtilities.h4(
                fontColor: AppColors.white, fontWeight: FWT.semiBold),
            margin: all8,
            color: AppColors.blueType2,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: cr24,
              ),
              child: Column(
                children: [
                  Container(
                    width: 400,
                    height: 300,
                    margin: hz20,
                    decoration: BoxDecoration(
                      borderRadius: cr24,
                      image: DecorationImage(
                        image: AssetImage(
                          Images.aboutUs,
                        ),
                      ),
                    ),
                  ),
                  AboutUsCommonWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
