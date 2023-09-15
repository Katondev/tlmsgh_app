import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/login/login_cnt.dart';
import 'package:katon/screens/auth/login/login_page_mobile.dart';
import 'package:katon/screens/auth/login/login_page_tablet.dart';
import 'package:katon/widgets/responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cnt = Get.put(LoginCnt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // key: cnt.scaffoldKey,
      body: SafeArea(
        child: Responsive.isMobilenew(context)
            ? LoginPageMobilePage()
            : LoginPageTabletPage(),
      ),
    );
  }
}
