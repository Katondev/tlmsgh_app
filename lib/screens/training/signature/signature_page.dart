import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/training/signature/signature_page_mobile.dart';
import 'package:katon/screens/training/signature/signature_page_tablet.dart';

import '../../../widgets/responsive.dart';

class SignaturePage extends StatefulWidget {
  final Arguments arguments;
  const SignaturePage({super.key, required this.arguments});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobilenew(context)) {
      return SignatureMobile(
        arguments: widget.arguments,
      );
    } else {
      return SignatureTablet(
        arguments: widget.arguments,
      );
    }
  }
}
