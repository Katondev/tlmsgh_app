import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/training/signed_form/signed_form_mobile.dart';
import 'package:katon/screens/training/signed_form/signed_form_tablet.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';
import '../../../widgets/responsive.dart';
import '../controller/training_prv.dart';

class SignedFormPage extends StatefulWidget {
  final Arguments arguments;
  const SignedFormPage({super.key, required this.arguments});

  @override
  State<SignedFormPage> createState() => _SignedFormPageState();
}

class _SignedFormPageState extends State<SignedFormPage>
    with WidgetsBindingObserver {
  TrainingProvider? pro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pro = Provider.of<TrainingProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
    await pro?.getAllschoolData(
        region: AppPreference().getString(PreferencesKey.region),
        district: AppPreference().getString(PreferencesKey.district));
    log("region---${AppPreference().getString(PreferencesKey.region)}----district----${AppPreference().getString(PreferencesKey.district)}");
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobilenew(context)) {
      return SignedFormMobile(
        arguments: widget.arguments,
      );
    } else {
      return SignedFormTablet(
        arguments: widget.arguments,
      );
    }
  }
}
