import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/login/login_cnt.dart';
import 'package:katon/screens/auth/login/widgets/type_of_login_widget.dart';
import 'package:katon/screens/auth/signup/signup_page.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/password_field.dart';
import 'package:katon/widgets/svgIcon.dart';
import 'package:katon/widgets/text_field.dart';

import '../../../components/app_text_style.dart';
import '../../../models/argument_model.dart';
import '../../../res.dart';
import '../../../utils/app_binding.dart';
import '../../../utils/validators.dart';
import '../../../widgets/app_webview/app_webview.dart';

class LoginPageMobilePage extends StatefulWidget {
  LoginPageMobilePage({Key? key}) : super(key: key);

  @override
  State<LoginPageMobilePage> createState() => _LoginPageMobilePageState();
}

class _LoginPageMobilePageState extends State<LoginPageMobilePage> {
  final cnt = Get.put(LoginCnt());
  GlobalKey<FormState> loginkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginkey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            h20,
            Text(
              "login".tr,
              style: AppTextStyle.normalBold20
                  .copyWith(color: AppColors.primaryYellow, fontSize: 30),
              // style: FontStyleUtilities.h1(fontWeight: FWT.bold)
              //     .copyWith(fontSize: 32),
            ),
            // Spacer(),
            h50,
            TypeOfLoginWidget(),
            h25,
            SizedBox(
              height: 60,
              width: Get.width,
              child: textFormField(
                controller: cnt.loginCnt,
                hintText: "Enter Email",
                maxLines: 1,
                suffixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 18, 25, 18),
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
            h18,

            SizedBox(
              height: 60,
              child: Obx(
                () => textFormField(
                  controller: cnt.passwordCnt,
                  hintText: "Enter Password",
                  maxLines: 1,
                  obscureText: !cnt.isObs.value,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 18, 24, 18),
                    child: GestureDetector(
                      onTap: () => cnt.isObs.value = !cnt.isObs.value,
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
            h10,
            Row(
              children: [
                InkWell(
                  onTap: () {
                    cnt.redirectToForgotPasswordPage();
                  },
                  child: Text('forgot_password?'.tr,
                      style: AppTextStyle.normalSemiBold10
                          .copyWith(decoration: TextDecoration.underline)),
                ),
              ],
            ),
            h50,
            LargeButton(
              height: 56,
              color: AppColors.black,
              onPressed: () {
                if (loginkey.currentState!.validate()) {
                  cnt.login(context);
                }
              },
              width: MediaQuery.of(context).size.width,
              child: Text(
                'login'.tr,
                style: FontStyleUtilities.h6(
                    fontWeight: FWT.medium, fontColor: AppColors.white),
              ),
            ),

            // h10,
            // Center(
            //   child: RichText(
            //     textAlign: TextAlign.center,
            //     text: TextSpan(
            //         text: "Read our ",
            //         style: FontStyleUtilities.h6(
            //                 fontColor:
            //                     AppColors.gray600.withOpacity(0.5))
            //             .copyWith(fontSize: 14),
            //         children: [
            //           TextSpan(
            //             text: "Privacy Policy",
            //             recognizer: TapGestureRecognizer()
            //               ..onTap = () {
            //                 navigatorKey.currentState!.push(
            //                   MaterialPageRoute(
            //                     builder: (context) => AppWebView(
            //                       url:
            //                           "https://katondev.in/privacy-policy",
            //                       arguments: Arguments(
            //                           title: "Privacy Policy",
            //                           description: ""),
            //                     ),
            //                   ),
            //                 );
            //               },
            //             style: FontStyleUtilities.h6(
            //                     fontWeight: FWT.medium,
            //                     fontColor: AppColors.black)
            //                 .copyWith(
            //               fontSize: 14,
            //             ),
            //           ),
            //           TextSpan(
            //             text: " and ",
            //             style: FontStyleUtilities.h6(
            //                     fontColor: AppColors.gray600
            //                         .withOpacity(0.5))
            //                 .copyWith(fontSize: 14),
            //           ),
            //           TextSpan(
            //             text: "Terms and Conditions",
            //             recognizer: TapGestureRecognizer()
            //               ..onTap = () {
            //                 navigatorKey.currentState!.push(
            //                   MaterialPageRoute(
            //                     builder: (context) => AppWebView(
            //                       url:
            //                           "https://katondev.in/terms-of-use",
            //                       arguments: Arguments(
            //                           title: "Terms and Conditions",
            //                           description: ""),
            //                     ),
            //                   ),
            //                 );
            //               },
            //             style: FontStyleUtilities.h6(
            //               fontWeight: FWT.medium,
            //               fontColor: AppColors.black,
            //             ).copyWith(fontSize: 14),
            //           ),
            //         ]),
            //   ),
            // ),
            // h30,
          ],
        ),
      ),
    );
    // : Stack(
    //     children: [
    //       /*Container(
    //   width: Get.width,
    //   height: Get.height / 2.5,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //         image: AssetImage(Images.login), fit: BoxFit.cover),
    //   ),
    // ),*/
    //       /* Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.bottomCenter,
    //       end: Alignment.bottomCenter,
    //       colors: [
    //         AppColors.primaryColor.withOpacity(0.38),
    //         const Color(0xff000000).withOpacity(0.50)
    //       ],
    //     ),
    //   ),
    // ),*/
    //       Padding(
    //         padding: t14l18,
    //         child: Image.asset(
    //           Images.introLogo,
    //           width: 100,
    //           height: 85,
    //         ),
    //       ),
    //       Obx(
    //         () => (cnt.isLogin.value)
    //             ? Positioned(
    //                 bottom: 0,
    //                 top: Get.height / 3,
    //                 child: Container(
    //                   // height: Get.height / 1.5,
    //                   decoration: BoxDecoration(
    //                     borderRadius: onlyTopLeftRight42,
    //                     color: AppColors.white,
    //                   ),
    //                   width: MediaQuery.of(context).size.width,
    //                   padding: EdgeInsets.only(
    //                       right: 15,
    //                       left: 15,
    //                       top: 10,
    //                       bottom: MediaQuery.of(context).viewInsets.bottom),
    //                   child: Form(
    //                     key: loginkey,
    //                     child: ListView(
    //                       // mainAxisAlignment: MainAxisAlignment.center,
    //                       // crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Center(
    //                           child: Text("login".tr,
    //                               style: FontStyleUtilities.h1(
    //                                       fontWeight: FWT.bold)
    //                                   .copyWith(fontSize: 32)),
    //                         ),
    //                         TypeOfLoginWidget(),
    //                         Text("email".tr,
    //                             style: FontStyleUtilities.h6(
    //                                 fontWeight: FWT.semiBold)),
    //                         h8,
    //                         TextBox(
    //                           keyboardType: TextInputType.emailAddress,
    //                           textInputAction: TextInputAction.next,
    //                           hint: 'email'.tr,
    //                           validator: (value) {
    //                             String pattern =
    //                                 r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]+.com"
    //                                 r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    //                                 r"{0,253}[a-zA-Z0-9])?)*$";
    //                             RegExp regex = RegExp(pattern);
    //                             if (!regex.hasMatch(value!)) {
    //                               return 'valid_email'.tr;
    //                             } else {
    //                               return null;
    //                             }
    //                           },
    //                           controller: cnt.loginCnt,
    //                           prefix: SvgIcon(Images.smsSvg),
    //                         ),
    //                         h18,
    //                         Text("password".tr,
    //                             style: FontStyleUtilities.h6(
    //                                 fontWeight: FWT.semiBold)),
    //                         h8,
    //                         PasswordField(
    //                           textInputAction: TextInputAction.done,
    //                           hint: 'password'.tr,
    //                           controller: cnt.passwordCnt,
    //                           inputFormatters: [
    //                             FilteringTextInputFormatter.deny(
    //                                 RegExp(r'\s')),
    //                           ],
    //                           validator: (value) =>
    //                               Validators.validatePassword(value),
    //                           onSubmitted: (p0) => cnt.login(context),
    //                         ),
    //                         h22,
    //                         Row(
    //                           children: [
    //                             Obx(
    //                               () => SizedBox(
    //                                 height: 20,
    //                                 width: 20,
    //                                 child: Theme(
    //                                   data: ThemeData(
    //                                       unselectedWidgetColor:
    //                                           AppColors.textGrey),
    //                                   child: Checkbox(
    //                                     shape: RoundedRectangleBorder(
    //                                       borderRadius: cr6,
    //                                     ),
    //                                     value: cnt.value.value,
    //                                     activeColor: AppColors.primary,
    //                                     onChanged: (bool? value) {
    //                                       cnt.value.value = value!;
    //                                     },
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             w8,
    //                             Text('remember_me'.tr,
    //                                 style: FontStyleUtilities.h6(
    //                                     fontColor: AppColors.gray600)),
    //                             const Spacer(),
    //                             InkWell(
    //                               onTap: () =>
    //                                   cnt.redirectToForgotPasswordPage(),
    //                               child: Text('forgot_password?'.tr,
    //                                   style: FontStyleUtilities.h6(
    //                                       fontColor: AppColors.gray600)),
    //                             ),
    //                           ],
    //                         ),
    //                         h20,
    //                         LargeButton(
    //                           height: 45,
    //                           onPressed: () {
    //                             if (loginkey.currentState!.validate()) {
    //                               cnt.login(context);
    //                             }
    //                           },
    //                           width: MediaQuery.of(context).size.width,
    //                           child: Text(
    //                             'login'.tr,
    //                             style: FontStyleUtilities.h6(
    //                                 fontWeight: FWT.medium,
    //                                 fontColor: AppColors.white),
    //                           ),
    //                         ),
    //                         h30,
    //                         Center(
    //                           child: RichText(
    //                             textAlign: TextAlign.center,
    //                             text: TextSpan(
    //                                 text: "Don't have any account? ",
    //                                 style: FontStyleUtilities.h6(
    //                                     fontColor: AppColors.gray600),
    //                                 children: [
    //                                   TextSpan(
    //                                     text: "Sign up",
    //                                     recognizer: TapGestureRecognizer()
    //                                       ..onTap = () {
    //                                         // navigatorKey.currentState!.push(
    //                                         //   MaterialPageRoute(
    //                                         //       builder: (context) => SignupPage()),
    //                                         // );
    //                                         cnt.isLogin.value = false;
    //                                         // Get.toNamed(RoutesConst.signupPage);
    //                                       },
    //                                     style: FontStyleUtilities.h6(
    //                                       fontWeight: FWT.medium,
    //                                       fontColor: AppColors.primary,
    //                                     ),
    //                                   ),
    //                                 ]),
    //                           ),
    //                         ),
    //                         h10,
    //                         Center(
    //                           child: RichText(
    //                             textAlign: TextAlign.center,
    //                             text: TextSpan(
    //                                 text: "Read our ",
    //                                 style: FontStyleUtilities.h6(
    //                                         fontColor: AppColors.gray600)
    //                                     .copyWith(fontSize: 14),
    //                                 children: [
    //                                   TextSpan(
    //                                     text: "Privacy Policy",
    //                                     recognizer: TapGestureRecognizer()
    //                                       ..onTap = () {
    //                                         navigatorKey.currentState!.push(
    //                                           MaterialPageRoute(
    //                                             builder: (context) =>
    //                                                 AppWebView(
    //                                               url:
    //                                                   "https://katondev.in/privacy-policy",
    //                                               arguments: Arguments(
    //                                                   title:
    //                                                       "Privacy Policy",
    //                                                   description: ""),
    //                                             ),
    //                                           ),
    //                                         );
    //                                       },
    //                                     style: FontStyleUtilities.h6(
    //                                             fontColor:
    //                                                 AppColors.primary)
    //                                         .copyWith(fontSize: 14),
    //                                   ),
    //                                   TextSpan(
    //                                     text: " and ",
    //                                     style: FontStyleUtilities.h6(
    //                                             fontColor:
    //                                                 AppColors.gray600)
    //                                         .copyWith(fontSize: 14),
    //                                   ),
    //                                   TextSpan(
    //                                     text: "Terms and Conditions",
    //                                     recognizer: TapGestureRecognizer()
    //                                       ..onTap = () {
    //                                         navigatorKey.currentState!.push(
    //                                           MaterialPageRoute(
    //                                             builder: (context) =>
    //                                                 AppWebView(
    //                                               url:
    //                                                   "https://katondev.in/terms-of-use",
    //                                               arguments: Arguments(
    //                                                   title:
    //                                                       "Terms and Conditions",
    //                                                   description: ""),
    //                                             ),
    //                                           ),
    //                                         );
    //                                       },
    //                                     style: FontStyleUtilities.h6(
    //                                       fontColor: AppColors.primary,
    //                                     ).copyWith(fontSize: 14),
    //                                   ),
    //                                 ]),
    //                           ),
    //                         ),
    //                         h30,
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             : SignupPage(),
    //       ),
    //     ],
    //   );
  }
}
