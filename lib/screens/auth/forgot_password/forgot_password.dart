import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:katon/screens/auth/forgot_password/controller/forgot_pass_cnt.dart';
import 'package:katon/screens/auth/forgot_password/forgot_password_mobile.dart';
import 'package:katon/screens/auth/forgot_password/forgot_password_tablet.dart';
import 'package:katon/widgets/responsive.dart';

class ForgotPassword extends StatelessWidget {
  final cnt = Get.put(ForgotPassCnt());
  ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: cnt.scaffoldKey,
      body: Responsive.isMobile(context)
          ? ForgotPasswordMobilePage()
          : ForgotPasswordTabletPage(),
    );
  }
}
