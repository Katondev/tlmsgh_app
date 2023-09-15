import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/about_page/about_page_common_widget.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';

class AboutPageTabletPage extends StatelessWidget {
  final Arguments? arguments;
  const AboutPageTabletPage({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: commonAppBar(
        title: arguments?.title ?? "",
        description: arguments?.description ?? "".tr,
      ),
      // endDrawer: endDrawer(),
      body: ColorContainer(
        svgImage: Images.aboutUsSvg,
        title: 'about_us'.tr,
        textStyle: FontStyleUtilities.h4(
          fontColor: AppColors.white,
          fontWeight: FWT.semiBold,
        ),
        margin: t5l20r20b15,
        color: AppColors.blueType2,
        child: Expanded(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: cr24,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 500.w,
                    height: 560.h,
                    margin: l20,
                    decoration: BoxDecoration(
                      borderRadius: cr24,
                      image: DecorationImage(
                        image: AssetImage(
                          Images.aboutUs,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AboutUsCommonWidget(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
