import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/live_class_model.dart';
import 'package:katon/screens/live_class/live_class_details/live_class_details_mobile.dart';
import 'package:katon/screens/live_class/live_class_details/live_class_details_tablet.dart';
import 'package:katon/models/active_list_model.dart';
import 'package:katon/widgets/responsive.dart';

class LiveClassDetailsPage extends StatefulWidget {
  const LiveClassDetailsPage({Key? key}) : super(key: key);

  @override
  State<LiveClassDetailsPage> createState() => _LiveClassDetailsPageState();
}

class _LiveClassDetailsPageState extends State<LiveClassDetailsPage> {
  @override
  void initState() {
    askPer();
    super.initState();
  }

  void askPer() async {
    await PermissionService().requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    LiveSession liveSession = args[0];
    Arguments? arg = args[1];
    return Responsive.isMobile(context)
        ? LiveClassDetailsMobile(liveSession: liveSession, arg: arg)
        : LiveClassDetailsTablet(liveSession: liveSession, arg: arg);
  }
}
