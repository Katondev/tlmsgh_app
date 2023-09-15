import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;

  final Widget tablet;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1080 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isMobilenew(BuildContext context) =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .shortestSide <
      600;
  static bool isTabletnew(BuildContext context) =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .shortestSide >
      600;

  String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 650) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
