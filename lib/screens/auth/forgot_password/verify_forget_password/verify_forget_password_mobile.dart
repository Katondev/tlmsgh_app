import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/forgot_password/controller/forgot_pass_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/utils/validators.dart';
import 'package:pinput/pinput.dart';
import '../../../../../widgets/button.dart';

class VerifyForgetPasswordMobile extends StatefulWidget {
  const VerifyForgetPasswordMobile({super.key});

  @override
  State<VerifyForgetPasswordMobile> createState() =>
      _VerifyForgetPasswordMobileState();
}

class _VerifyForgetPasswordMobileState
    extends State<VerifyForgetPasswordMobile> {
  final forgetpassCnt = Get.find<ForgotPassCnt>();
  GlobalKey<FormState> forgetpasskey = GlobalKey<FormState>();

  Timer? timer;
  RxInt _start = 30.obs;

  int currentSeconds = 0;

  String get timerText =>
      '${((_start - currentSeconds) ~/ 60).toString().padLeft(2, '0')} : ${((_start - currentSeconds) % 60).toString().padLeft(2, '0')}';

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Forget Password Verification",
                  textAlign: TextAlign.center,
                  style: FontStyleUtilities.h1(fontWeight: FWT.bold)
                      .copyWith(fontSize: 32)),
              h16,
              Text(
                "Enter the 6 digit code sent to your email: ${forgetpassCnt.emailCnt.value.text}",
                textAlign: TextAlign.center,
                style: FontStyleUtilities.t4(fontWeight: FWT.regular)
                    .copyWith(fontSize: 16, color: AppColors.gray600),
              ),
              h50,
              Form(
                key: forgetpasskey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Pinput(
                  validator: (value) =>
                      Validators.validaterequired(value, "Please enter OTP"),
                  controller: forgetpassCnt.OtpCnt.value,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  length: 6,
                  keyboardType: TextInputType.number,
                  onCompleted: (pin) => print(pin),
                ),
              ),
              Spacer(),
              Container(
                height: 50,
                // width: 100,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                            .copyWith(fontSize: 16, color: AppColors.gray600),
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
                        .copyWith(fontSize: 14, color: AppColors.gray600),
                  ),
                  InkWell(
                    onTap: () async {
                      if (_start.value == 0) {
                        _start.value = 30;
                        startTimer();
                        // signupCnt.otpType.value = 1;
                        // log(signupCnt.isteacher.value.toString());
                        // if (signupCnt.isteacher.value) {
                        //   await signupCnt.resendTeacherOtp();
                        // } else {
                        //   await signupCnt.resendStudentOtp();
                        // }
                      }
                    },
                    child: Obx(
                      () => Text(
                        "Resend",
                        style: FontStyleUtilities.t4(fontWeight: FWT.regular)
                            .copyWith(
                                fontSize: 14,
                                color: _start.value == 0
                                    ? AppColors.primary
                                    : AppColors.gray300),
                      ),
                    ),
                  ),
                ],
              ),
              h20,
              LargeButton(
                onPressed: () async {
                  primaryFocus?.unfocus();
                  // signupCnt.otpType.value = 1;
                  if (forgetpasskey.currentState!.validate()) {
                    await forgetpassCnt.verifyForgotPassword();
                  }
                },
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'submit'.tr,
                  style: FontStyleUtilities.h6(
                      fontWeight: FWT.medium, fontColor: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       LargeButton(
      //         onPressed: () {
      //           signupCnt.otpType.value = 1;
      //           signupCnt.verifyTeacherOtp().then((value) {
      //             Get.toNamed(RoutesConst.phoneVerificationPage);
      //           });
      //         },
      //         width: MediaQuery.of(context).size.width,
      //         child: Text(
      //           'submit'.tr,
      //           style: FontStyleUtilities.h6(
      //               fontWeight: FWT.medium, fontColor: AppColors.white),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
