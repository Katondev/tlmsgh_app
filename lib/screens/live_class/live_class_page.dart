import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/live_class/controller/live_class_prv.dart';
import 'package:katon/screens/live_class/live_class_mobile.dart';
import 'package:katon/screens/live_class/live_class_tablet.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class LiveClassPage extends StatefulWidget {
  final Arguments arguments;

  const LiveClassPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<LiveClassPage> createState() => _LiveClassPageState();
}

class _LiveClassPageState extends State<LiveClassPage> {
  SignInModel signInM = SignInModel();
  LiveClassProvider? liveClassPrv;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    liveClassPrv = Provider.of<LiveClassProvider>(context, listen: false);
    init();
  }

  void init() async {
    // await liveClassPrv?.getAllCategoryInfo();
    await liveClassPrv?.getScheduledLiveClass(
        bkCategory: "", bkSubCategory: "");
    liveClassPrv?.tabbarIndex = 0;
    // await liveClassPrv?.getAllLiveClass(
    //     bkSubCategory: "", bkCategory: "", page: 1, limit: 12, tcId: 37);
    // Map<String, dynamic> userData =
    //     jsonDecode(AppPreference().getString(PreferencesKey.studentData));
    // signInM = SignInModel.fromJson(userData);
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return LiveClassMobilePage(arguments: widget.arguments);
    } else {
      return LiveClassTabletPage(arguments: widget.arguments);
    }
  }
}
