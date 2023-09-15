import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/signup/signup_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:pinput/pinput.dart';

import '../../../../../utils/font_style.dart';
import '../../../../../utils/validators.dart';
import '../../../../../widgets/button.dart';
import '../../../login/login_cnt.dart';

class EmailVerificationTablet extends StatefulWidget {
  const EmailVerificationTablet({super.key});

  @override
  State<EmailVerificationTablet> createState() =>
      _EmailVerificationTabletState();
}

class _EmailVerificationTabletState extends State<EmailVerificationTablet> {
  final signupCnt = Get.find<SignupCnt>();
  GlobalKey<FormState> emailVerifyKey = GlobalKey<FormState>();

  Timer? _timer;
  RxInt _start = 30.obs;

  int currentSeconds = 0;

  String get timerText =>
      '${((_start - currentSeconds) ~/ 60).toString().padLeft(2, '0')} : ${((_start - currentSeconds) % 60).toString().padLeft(2, '0')}';

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start.value == 0) {
          timer.cancel();
        } else {
          _start--;
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Email Verification",
                    style: FontStyleUtilities.h1(fontWeight: FWT.bold)
                        .copyWith(fontSize: 32)),
                h16,
                Text(
                  "Enter the 6 digit code sent to your email: ${AppPreference().getString("signupEmail")}",
                  textAlign: TextAlign.center,
                  style: FontStyleUtilities.t4(fontWeight: FWT.regular)
                      .copyWith(fontSize: 18, color: AppColors.gray600),
                ),
                h50,
                Form(
                  key: emailVerifyKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Pinput(
                    defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(30, 60, 87, 1),
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                        // borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) =>
                        Validators.validaterequired(value, "Please enter OTP"),
                    controller: signupCnt.tEmailotpcnt.value,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    length: 6,
                    keyboardType: TextInputType.number,
                    onCompleted: (pin) => log(pin),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              // width: 100,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.primary.withOpacity(.1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svgs/timer.svg"),
                  w12,
                  Obx(
                    () => Text(
                      timerText,
                      style: FontStyleUtilities.t4(fontWeight: FWT.regular)
                          .copyWith(fontSize: 18, color: AppColors.gray600),
                    ),
                  ),
                ],
              ),
            ),
            h20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn’t receive the OTP? ",
                  style: FontStyleUtilities.t4(fontWeight: FWT.regular)
                      .copyWith(fontSize: 16, color: AppColors.gray600),
                ),
                InkWell(
                  onTap: () async {
                    if (_start.value == 0) {
                      _start.value = 30;
                      startTimer();
                      signupCnt.otpType.value = 1;
                      if (Get.find<LoginCnt>().radioIndex == 1) {
                        await signupCnt.resendTeacherOtp();
                      } else {
                        await signupCnt.resendStudentOtp();
                      }
                    }
                  },
                  child: Obx(
                    () => Text(
                      "Resend",
                      style: FontStyleUtilities.t4(fontWeight: FWT.regular)
                          .copyWith(
                              fontSize: 16,
                              color: _start.value == 0
                                  ? AppColors.primary
                                  : AppColors.gray300),
                    ),
                  ),
                ),
              ],
            ),
            h20,
            SizedBox(
              width: 400,
              child: LargeButton(
                onPressed: () async {
                  primaryFocus?.unfocus();
                  if (emailVerifyKey.currentState!.validate()) {
                    signupCnt.otpType.value = 1;
                    if (Get.find<LoginCnt>().radioIndex == 1) {
                      await signupCnt.verifyTeacherOtp(context);
                    } else {
                      await signupCnt.verifyStudentOtp(context);
                    }
                  }
                },
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'submit'.tr,
                  style: FontStyleUtilities.h6(
                      fontWeight: FWT.medium, fontColor: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
