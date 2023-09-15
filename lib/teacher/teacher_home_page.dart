import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/Routes/teacher_routes.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/drawer/drawer_cnt.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
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
    drawerCnt.index.value = 1;
  }

  init() async {
    packageInfo = await PackageInfo.fromPlatform();
    drawerCnt.appVersion.value = packageInfo?.version ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final menu = Container(
      color: theme.canvasColor,
      child: TeacherDrawerBox(navKey: navigatorKey),
    );

    return Row(
      children: <Widget>[
        if (isMenuFixed(context)) menu,
        Expanded(
          child: Navigator(
            key: navigatorKey,
            initialRoute: RoutesConst.eLearning,
            onGenerateRoute: (settings) =>
                TeacherPageRoute().getTeacherPageRoute(settings, settings.name),
          ),
        ),
      ],
    );
  }
}
