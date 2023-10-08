import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/res.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';

import '../components/app_text_style.dart';
import '../widgets/custom_dialog.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen> {
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;

  showModeDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            message:
                "For the best experience, we would like to recommend using app in landscape mode.",
            title1: "Ok".tr,
            // title2: "No",
            // onSecButtonTap: () => Navigator.of(context).pop(),
            onFirstButtonTap: () async {
              await SystemChrome.setPreferredOrientations(
                
                // [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
                [
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight
                ],
              ).whenComplete(
                  () => AppPreference().setBool("isPortrait", false));
              // Future.delayed(Duration(seconds: 3), () {
              log("s----${AppPreference().getBool(PreferencesKey.isLoggedIn).toString()}");
              log("s----${AppPreference().getBool(PreferencesKey.isTeacherLoggedIn).toString()}");
              log("s----${AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeSt).toString()}");
              log("s----${AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeT).toString()}");
              Get.offNamedUntil(AppPreference().initRoute, (route) => false);
              // });
              Get.back();
            },
            // child: Container(
            //   height: 100,
            //   width: 300,
            //   decoration: BoxDecoration(color: AppColors.white),
            // ),
          );
        });
  }

  changeOrientation() async {
    await SystemChrome.setPreferredOrientations(
      // [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
  }

  @override
  void initState() {
    super.initState();
    log("dsdsdsds-----tablet---");
    Future.delayed(Duration(seconds: 3), () {
      // AppPreference().setBool("isPortrait", true);
      if (Responsive.isTablet(context)) {
        if (AppPreference().getBool("isPortrait")) {
          Future.delayed(Duration(milliseconds: 10), () {
            showModeDialog(context);
          });
        } else {
          log("s----${AppPreference().getBool(PreferencesKey.isLoggedIn).toString()}");
          log("s----${AppPreference().getBool(PreferencesKey.isTeacherLoggedIn).toString()}");
          log("s----${AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeSt).toString()}");
          log("s----${AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeT).toString()}");
          Get.offNamedUntil(AppPreference().initRoute, (route) => false);
          // });
        }
      } else {
        //  changeOrientation();
        // Future.delayed(Duration(seconds: 3), () {
        log("s----${AppPreference().getBool(PreferencesKey.isLoggedIn).toString()}");
        log("s----${AppPreference().getBool(PreferencesKey.isTeacherLoggedIn).toString()}");
        log("s----${AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeSt).toString()}");
        log("s----${AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeT).toString()}");
        Get.offNamedUntil(AppPreference().initRoute, (route) => false);
        // });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                AppAssets.ic_splash,
                width: 98,
                height: 98,
              ),
              10.h.verticalSpace,
              Text(
                "LMS GHANA",
                style: AppTextStyle.normalRegular16.copyWith(
                    fontFamily: "Audiowide", color: AppColors.primaryWhite),
              ),
              16.h.verticalSpace,
              SizedBox(
                  width: 98,
                  child: LinearProgressIndicator(
                    color: AppColors.primaryYellow,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
