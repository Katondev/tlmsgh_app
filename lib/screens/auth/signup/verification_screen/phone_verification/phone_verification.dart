import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/signup/verification_screen/phone_verification/phone_verification_mobile.dart';
import 'package:katon/screens/auth/signup/verification_screen/phone_verification/phone_verification_tablet.dart';

import '../../../../../widgets/responsive.dart';
import '../../signup_cnt.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final signupCnt = Get.put(SignupCnt());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Responsive.isMobilenew(context)
            ? PhoneVerificationMobile()
            : PhoneVerificationTablet(),
      ),
    );
  }
}
