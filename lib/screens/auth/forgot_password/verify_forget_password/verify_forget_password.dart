import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/forgot_password/verify_forget_password/verify_forget_password_mobile.dart';
import 'package:katon/screens/auth/forgot_password/verify_forget_password/verify_forget_password_tablet.dart';

import '../../../../widgets/responsive.dart';
import '../controller/forgot_pass_cnt.dart';

class VerifyForgetPassword extends StatefulWidget {
  const VerifyForgetPassword({super.key});

  @override
  State<VerifyForgetPassword> createState() => _VerifyForgetPasswordState();
}

class _VerifyForgetPasswordState extends State<VerifyForgetPassword>
    with WidgetsBindingObserver {
  final forgetPassCnt = Get.put(ForgotPassCnt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Responsive.isMobilenew(context)
            ? VerifyForgetPasswordMobile()
            : VerifyForgetPasswordTablet(),
      ),
    );
  }
}
