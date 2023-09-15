import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/intro_model.dart';
import 'package:katon/res.dart';
import 'package:katon/utils/config.dart';

class IntroCnt extends GetxController {
  RxInt page = 0.obs;

  Rx<PageController> controller = PageController().obs;

  RxList<IntroM> introList = <IntroM>[
    IntroM(title: 'skills'.tr, image: AppAssets.slider_1),
    IntroM(title: 'learning_experience'.tr, image: AppAssets.slider_2),
    IntroM(title: "", image: AppAssets.slider_3),
  ].obs;

  void redirectToLoginPage() {
    Get.offNamed(RoutesConst.loginPage);
    AppPreference().setBool(PreferencesKey.introPage, true);
  }

  void onNextOrGetStartedPressed() {
    redirectToLoginPage();
  }
  /*if (page.value == 0) {
      page.value = 1;
    } else if (page.value == 1) {
      page.value = 2;
    } else {
      redirectToLoginPage();
    }
    controller.value.animateToPage(page.value,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubicEmphasized);
  }*/
}
