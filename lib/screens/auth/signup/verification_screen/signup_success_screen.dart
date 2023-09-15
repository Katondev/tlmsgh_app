import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/login/login_page.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:lottie/lottie.dart';

class SignupSuccessPage extends StatefulWidget {
  const SignupSuccessPage({super.key});

  @override
  State<SignupSuccessPage> createState() => _SignupSuccessPageState();
}

class _SignupSuccessPageState extends State<SignupSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              "https://assets8.lottiefiles.com/packages/lf20_rtxcgnqq.json",
              repeat: false,
              height: 300,
            ),
            h30,
            Text(
              "Great!",
              style: FontStyleUtilities.h3(
                  fontColor: AppColors.black, fontWeight: FWT.semiBold),
            ),
            h10,
            Text(
              "You have successfully joined",
              style: FontStyleUtilities.h4(fontColor: AppColors.black),
            ),
            // h6,
            Text(
              "KATON - 360 Degree Knowledge Hub",
              style: FontStyleUtilities.h4(fontColor: AppColors.black),
            ),
            h20,
            LargeButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesConst.loginPage,
                  (route) => false,
                );
                // Navigator.of(context).pop();
              },
              height: Responsive.isMobilenew(context) ? 40 : 50,
              child: Text(
                "Go To Login",
                style: Responsive.isMobilenew(context)
                    ? FontStyleUtilities.t1(
                        fontColor: AppColors.white, fontWeight: FWT.semiBold)
                    : FontStyleUtilities.h5(
                        fontColor: AppColors.white, fontWeight: FWT.semiBold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
