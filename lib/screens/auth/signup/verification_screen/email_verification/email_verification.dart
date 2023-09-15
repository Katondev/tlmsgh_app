import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/signup/verification_screen/email_verification/email_verification_mobile.dart';

import '../../../../../widgets/responsive.dart';
import '../../signup_cnt.dart';
import 'email_verification_tablet.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final signupCnt = Get.put(SignupCnt());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Responsive.isMobilenew(context)
            ? EmailVerificationMobile()
            : EmailVerificationTablet(),
      ),
    );
  }
}
