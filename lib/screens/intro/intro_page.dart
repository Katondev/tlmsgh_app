import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/models/active_list_model.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/intro/intro_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/dot_indicator.dart';
import 'package:katon/widgets/responsive.dart';

import '../../components/app_text_style.dart';

class IntroPage extends StatefulWidget {
  /// Introduction page
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final cnt = Get.put(IntroCnt());

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration(milliseconds: 100),
      () => PermissionService().requestPermission(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: AppColors.black.withOpacity(0.3)),
              child: PageView.builder(
                controller: cnt.controller.value,
                onPageChanged: (value) {
                  cnt.page.value = value;
                },
                itemCount: cnt.introList.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(cnt.introList[index].image.toString()),
                          colorFilter: ColorFilter.mode(
                              index != 2 ? Colors.black38 : AppColors.white,
                              BlendMode.darken),
                          fit: BoxFit.cover,
                        ),
                      ));
                },
              ),
            ),
            Positioned(
              top: Responsive.isMobilenew(context) ? 64 : 60.r,
              right: Responsive.isMobilenew(context) ? 30 : 74.r,
              child: Image.asset(
                cnt.page.value == 2
                    ? AppAssets.ic_splash_black
                    : AppAssets.ic_splash,
                width: Responsive.isMobilenew(context) ? 150.r : 70,
                height: Responsive.isMobilenew(context) ? 150.r : 70,
                // color:
                //     cnt.page.value != 2 ? Colors.white : AppColors.black,
              ),
            ),
            Positioned(
              bottom: Responsive.isMobile(context) ? 30.h : 64.h,
              left: 0,
              right: 0,
              child: (Responsive.isTabletnew(context))
                  ? Column(
                      children: [
                        Padding(
                          padding: hz60,
                          child: Center(
                            child: Text(
                              cnt.introList[cnt.page.value].title.toString(),
                              textAlign: TextAlign.center,
                              style: AppTextStyle.normalBold16,
                            ),
                          ),
                        ),
                        h14,
                        LargeButton(
                          width: 290,
                          height: 50,
                          color: Colors.transparent,
                          borderWidth: 4.r,
                          borderColor: cnt.page.value != 2
                              ? Colors.white
                              : AppColors.primaryYellow,
                          onPressed: () => cnt.onNextOrGetStartedPressed(),
                          child: Text(
                            'get_started'.tr.toUpperCase(),
                            style: AppTextStyle.normalBold18.copyWith(
                              color: cnt.page.value != 2
                                  ? Colors.white
                                  : AppColors.primaryYellow,
                            ),
                          ),
                        ),
                        20.h.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DotsIndicator(
                              dotsCount: 3,
                              position: cnt.page.value,
                              decorator: DotsDecorator(
                                activeSize: Size(8, 8),
                                size: Size(8, 8),
                                spacing: all4,
                                activeColor: AppColors.gray909090,
                                color: (cnt.page.value == 2)
                                    ? AppColors.black
                                    : AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: hz60,
                          child: Center(
                            child: Text(
                                cnt.introList[cnt.page.value].title.toString(),
                                textAlign: TextAlign.center,
                                style: AppTextStyle.normalBold12.copyWith(
                                  color: AppColors.white,
                                )),
                          ),
                        ),
                        16.h.verticalSpace,
                        LargeButton(
                          width: 120,
                          height: 40,
                          color: Colors.transparent,
                          borderWidth: 4.r,
                          borderColor: cnt.page.value != 2
                              ? Colors.white
                              : AppColors.primaryYellow,
                          onPressed: () => cnt.onNextOrGetStartedPressed(),
                          child: Text(
                            'get_started'.tr.toUpperCase(),
                            style: AppTextStyle.normalBold12.copyWith(
                              color: cnt.page.value != 2
                                  ? Colors.white
                                  : AppColors.primaryYellow,
                            ),
                          ),
                        ),
                        20.h.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DotsIndicator(
                              dotsCount: 3,
                              position: cnt.page.value,
                              decorator: DotsDecorator(
                                activeSize: Size(8, 8),
                                size: Size(8, 8),
                                spacing: all4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              //       : Container(
              //           padding: hz30,
              //           width: Get.width,
              //           child: Row(
              //             children: [
              //               LargeButton(
              //                 width: Responsive.isMobile(context) ? 120 : 180,
              //                 height: Responsive.isMobile(context) ? 40 : 55,
              //                 color: Colors.transparent,
              //                 borderWidth: 1,
              //                 borderColor: AppColors.primary,
              //                 onPressed: () => cnt.redirectToLoginPage(),
              //                 child: Text(
              //                   'skip'.tr,
              //                   style: FontStyleUtilities.h6(
              //                       fontWeight: FWT.medium,
              //                       fontColor: AppColors.primary),
              //                 ),
              //               ),
              //               const Spacer(),
              //               DotsIndicator(
              //                 dotsCount: 3,
              //                 position: cnt.page.value,
              //                 decorator: const DotsDecorator(
              //                   activeSize: Size(8, 8),
              //                   size: Size(8, 8),
              //                   spacing: all4,
              //                 ),
              //               ),
              //               const Spacer(),
              //               LargeButton(
              //                 width: Responsive.isMobile(context) ? 120 : 178,
              //                 height: Responsive.isMobile(context) ? 40 : 56,
              //                 onPressed: () => cnt.onNextOrGetStartedPressed(),
              //                 child: Text(cnt.page.value == 2
              //                     ? 'get_started'.tr
              //                     : "next".tr),
              //               )
              //             ],
              //           ),
              //         ),
            ),
          ],
        ),
      ),
    );
  }
}
