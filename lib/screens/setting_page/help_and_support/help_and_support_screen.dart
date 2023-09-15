import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/setting_page/help_and_support/help_and_support_tablet.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/responsive.dart';
import 'help_and_support_mobile.dart';

class HelpAndSupportScreen extends StatefulWidget {
  final Arguments arguments;
  const HelpAndSupportScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Responsive.isMobile(context)
          ? HelpAndSupportMobile(
              args: widget.arguments,
            )
          : HelpAndSupportTablet(
              args: widget.arguments,
            ),
    );
  }
}
