import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/setting_page/delete_account/delete_account_tablet.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/responsive.dart';
import 'delete_account_mobile.dart';

class DeleteAccountScreen extends StatefulWidget {
  final Arguments arguments;
  const DeleteAccountScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Responsive.isMobile(context)
          ? DeleteAccountMobile(
              arguments: widget.arguments,
            )
          : DeleteAccountTablet(
              args: widget.arguments,
            ),
    );
  }
}
