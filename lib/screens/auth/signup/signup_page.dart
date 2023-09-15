import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/signup/signup_cnt.dart';
import 'package:katon/screens/auth/signup/signup_page_mobile.dart';
import 'package:katon/screens/auth/signup/signup_page_tablet.dart';

import '../../../widgets/responsive.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with WidgetsBindingObserver {
  final cnt = Get.put(SignupCnt());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cnt.getAllRegions(context);
      cnt.getStaticData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobilenew(context)
        ? SignupMobilePage()
        : SignupTabletPage();
  }
}
