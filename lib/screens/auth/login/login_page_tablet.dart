import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/screens/auth/login/login_cnt.dart';
import 'package:katon/screens/auth/login/widgets/type_of_login_widget.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../../../res.dart';
import '../signup/signup_page.dart';

class LoginPageTabletPage extends StatefulWidget {
  LoginPageTabletPage({Key? key}) : super(key: key);

  @override
  State<LoginPageTabletPage> createState() => _LoginPageTabletPageState();
}

class _LoginPageTabletPageState extends State<LoginPageTabletPage> {
  final cnt = Get.put(LoginCnt());
  GlobalKey<FormState> loginkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (cnt.isLogin.value)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: onlyTopBottomLeft42,
                    color: AppColors.white,
                  ),
                  width: Get.width / 2.4,
                  padding: EdgeInsets.only(
                      right: 76,
                      left: 76,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Form(
                        key: loginkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "login".tr,
                              style: AppTextStyle.normalBold20
                                  .copyWith(color: AppColors.primaryYellow),
                              // style: FontStyleUtilities.h1(fontWeight: FWT.bold)
                              //     .copyWith(fontSize: 32),
                            ),
                            20.verticalSpace,
                            TypeOfLoginWidget(),
                            h30,
                            // Text("email".tr,
                            //     style: FontStyleUtilities.h6(
                            //         fontWeight: FWT.semiBold)),
                            // h8,
                            SizedBox(
                              height: 60,
                              width: Get.width,
                              child: textFormField(
                                controller: cnt.loginCnt,
                                hintText: "Enter Email",
                                maxLines: 1,
                                suffixIcon: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 18, 35, 18),
                                  child: SizedBox(
                                    height: 25,
                                    child: SvgPicture.asset(
                                      AppAssets.ic_user,
                                      // height: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // TextBox(
                            //   keyboardType: TextInputType.emailAddress,
                            //   textInputAction: TextInputAction.next,
                            //   hint: 'email'.tr,
                            //   controller: cnt.loginCnt,
                            //   validator: (value) {
                            //     String pattern =
                            //         r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]+.com"
                            //         r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            //         r"{0,253}[a-zA-Z0-9])?)*$";
                            //     RegExp regex = RegExp(pattern);
                            //     if (!regex.hasMatch(value!)) {
                            //       return 'valid_email'.tr;
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   // prefix: SvgIcon(Images.smsSvg),
                            // ),
                            h16,

                            SizedBox(
                              height: 60,
                              child: Obx(
                                () => textFormField(
                                  controller: cnt.passwordCnt,
                                  hintText: "Enter Password",
                                  maxLines: 1,
                                  obscureText: !cnt.isObs.value,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 18, 32, 18),
                                    child: GestureDetector(
                                      onTap: () =>
                                          cnt.isObs.value = !cnt.isObs.value,
                                      child: !cnt.isObs.value
                                          ? SizedBox(
                                              height: 20,
                                              child: SvgPicture.asset(
                                                AppAssets.ic_visibility_off,
                                                // height: 20,
                                                colorFilter: ColorFilter.mode(
                                                  AppColors.textFieldhintColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 20,
                                              child: SvgPicture.asset(
                                                AppAssets.ic_visibility,
                                                // height: 20,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // PasswordField(
                            //   textInputAction: TextInputAction.done,
                            //   hint: 'Password',
                            //   inputFormatters: [
                            //     FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            //   ],
                            //   validator: (value) =>
                            //       Validators.validatePassword(value),
                            //   controller: cnt.passwordCnt,
                            //   onSubmitted: (p0) => cnt.login(context),
                            // ),
                            h10,
                            Row(
                              children: [
                                /* Obx(
                                () => SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor:
                                            AppColors.textGrey),
                                    child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: cr6,
                                      ),
                                      value: cnt.value.value,
                                      activeColor: AppColors.primary,
                                      onChanged: (bool? value) {
                                        cnt.value.value = value!;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              w8,
                              Text('remember_me'.tr,
                                  style: FontStyleUtilities.h6(
                                      fontColor: AppColors.gray600)),
                              const Spacer(),*/
                                InkWell(
                                  onTap: () {
                                    cnt.redirectToForgotPasswordPage();
                                  },
                                  child: Text('forgot_password?'.tr,
                                      style: AppTextStyle.normalSemiBold10
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline)),
                                ),
                              ],
                            ),
                            h64,
                            Align(
                              alignment: Alignment.center,
                              child: LargeButton(
                                color: AppColors.black,
                                onPressed: () {
                                  // Get.offAll(() => HomePage());
                                  if (loginkey.currentState!.validate()) {
                                    cnt.login(context);
                                  }
                                },
                                width: 300,
                                height: 49,
                                child: Text(
                                  'login'.tr,
                                  style: AppTextStyle.normalBold18,
                                ),
                              ),
                            ),
                            h64,
                            /*Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Don't have any account? ",
                                  style: FontStyleUtilities.h6(
                                      fontColor: AppColors.gray600),
                                  children: [
                                    TextSpan(
                                      text: "Sign up",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           SignupPage()),
                                          // );
                                          cnt.isLogin.value = false;
                                        },
                                      style: FontStyleUtilities.h6(
                                        fontWeight: FWT.medium,
                                        fontColor: AppColors.primary,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          h20,
                            Center(
                              child: RichText(
                                text: TextSpan(
                                    text: "Read our ",
                                    style: FontStyleUtilities.h6(
                                        fontColor:
                                            AppColors.gray600.withOpacity(0.5)),
                                    children: [
                                      TextSpan(
                                        text: "Privacy Policy",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            navigatorKey.currentState!.push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AppWebView(
                                                  url:
                                                      "https://katondev.in/privacy-policy",
                                                  arguments: Arguments(
                                                      title: "Privacy Policy",
                                                      description: ""),
                                                ),
                                              ),
                                            );
                                          },
                                        style: FontStyleUtilities.h6(
                                            fontWeight: FWT.medium,
                                            fontColor: AppColors.black),
                                      ),
                                      TextSpan(
                                        text: " and ",
                                        style: FontStyleUtilities.h6(
                                            fontColor: AppColors.gray600
                                                .withOpacity(0.5)),
                                      ),
                                      TextSpan(
                                        text: "Terms and Conditions",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            navigatorKey.currentState!.push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AppWebView(
                                                  url:
                                                      "https://katondev.in/terms-of-use",
                                                  arguments: Arguments(
                                                      title:
                                                          "Terms and Conditions",
                                                      description: ""),
                                                ),
                                              ),
                                            );
                                          },
                                        style: FontStyleUtilities.h6(
                                            fontWeight: FWT.medium,
                                            fontColor: AppColors.black),
                                      ),
                                    ]),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SignupPage(),
    );
  }
}
