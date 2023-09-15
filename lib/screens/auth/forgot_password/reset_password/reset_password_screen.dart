import 'package:flutter/material.dart';
import 'package:katon/screens/auth/forgot_password/reset_password/reset_password_mobile.dart';
import 'package:katon/screens/auth/forgot_password/reset_password/reset_password_tablet.dart';
import '../../../../widgets/responsive.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Responsive.isMobilenew(context)
            ? ResetPasswordMobile()
            : ResetPasswordTablet(),
      ),
    );
  }
}
