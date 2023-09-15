import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/library_page/library_mobile.dart';
import 'package:katon/utils/Routes/student_Routes.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:katon/widgets/drawer/drawer_cnt.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:package_info_plus/package_info_plus.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? classId;
  PackageInfo? packageInfo;
  final drawerCnt = Get.put(DrawerCnt());

  final routes = List.generate(20, (i) => 'test $i');

  bool isMenuFixed(BuildContext context) {
    return MediaQuery.of(context).size.width > 500;
  }

  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
  }

  init() async {
    classId = AppPreference().getStudentInfo();
    packageInfo = await PackageInfo.fromPlatform();
    drawerCnt.appVersion.value = packageInfo?.version ?? "";
    drawerCnt.index.value = 1;
    if (mounted) {
      setState(() {});
    }
  }

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final menu = Container(
      color: theme.canvasColor,
      child: DrawerBox(navKey: navigatorKey),
    );

    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null) {
          currentBackPressTime = now;

          Fluttertoast.showToast(msg: "Press again to exit the app");

          return Future.value(false);
        } else if (now.difference(currentBackPressTime!) >
            Duration(seconds: 2)) {
          log("back tap-----${now.difference(currentBackPressTime!)}");
          currentBackPressTime = null;
          MoveToBackground.moveTaskToBack();

          // SystemNavigator.pop();

          // //add duration of press gap
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: Text(
          //         'Press Back Button Again to Exit'))); //scaffold message, you can show Toast message too.
        }

        return Future.value(false);

//!
        // Check if there are pages in the navigation stack.
        // if (navigatorKey.currentState!.canPop()) {
        //   // Instead of popping, you can navigate to another page.
        //   navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
        //     builder: (context) => LibraryPageMobile(
        //       arguments: Arguments(title: "title", description: "description"),
        //     ),
        //   ));
        //   return false;
        // }
        // // Return true if the app can be popped; otherwise, false.
        // return true;

        // DateTime now = DateTime.now();
        // if (currentBackPressTime == null && now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        //   currentBackPressTime = now;
        //   Fluttertoast.showToast(
        //       msg: 'Tap Again to Exit'); // you can use snackbar too here
        //   return Future.value(false);
        // }
        // return Future.value(true);
        // showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     title: Text("Confirm Exit"),
        //     content: Text("Are you sure you want to exit?"),
        //     actions: <Widget>[
        //       CupertinoDialogAction(
        //         child: Text("YES"),
        //         onPressed: () => Navigator.of(context).pop(false),
        //       ),
        //       CupertinoDialogAction(
        //         child: Text("NO"),
        //         onPressed: () => Navigator.of(context).pop(false),
        //       ),

        //     ],
        //   ),
        // );
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text("Confirm Exit"),
        //         content: Text("Are you sure you want to exit?"),
        //         actions: <Widget>[
        //           ElevatedButton(
        //             child: Text("YES"),
        //             onPressed: () {
        //               SystemNavigator.pop();
        //             },
        //           ),
        //           ElevatedButton(
        //             child: Text("NO"),
        //             onPressed: () {
        //               Navigator.of(context).pop();
        //             },
        //           )
        //         ],
        //       );
        //     });
        // return Future.value(true);
      },
      child: Row(
        children: <Widget>[
          if (isMenuFixed(context)) menu,
          Expanded(
            child: Navigator(
              key: navigatorKey,
              initialRoute: classId == "" || classId == null
                  ? RoutesConst.editProfile
                  : RoutesConst.eLearning,
              onGenerateRoute: (settings) =>
                  StudentPageRoute().getPageRoute(settings, settings.name),
            ),
          ),
        ],
      ),
    );
  }
}
