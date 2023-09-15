import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/home/dash_board_mobile.dart';
import 'package:katon/screens/home/dash_board_tablet.dart';
import 'package:katon/screens/message/message_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';

class DashBoard extends StatefulWidget {
  final Arguments arguments;

  const DashBoard({Key? key, required this.arguments}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final cnt = Get.put(AppBarCnt());
  final messageCnt = Get.put(MessageCnt());
  int messageCount = 0;

  @override
  void initState() {
    // TODO: implement initState.
    init();
    super.initState();
  }

  init() async {
    if (!AppPreference().isTeacherLogin) {
      cnt.getStudentInfo();
      await messageCnt.getAllMessage();
    } else {
      cnt.getStudentInfo();
      messageCnt.messageResponseModel = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    LargeButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      height: 45,
                      textColor: AppColors.primaryColor,
                      color: const Color(0xffD9DFFC),
                      child: Text("YES"),
                    ),
                    LargeButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      height: 45,
                      textColor: AppColors.primaryColor,
                      color: const Color(0xffD9DFFC),
                      child: Text("NO"),
                    )
                  ],
                );
              });
          return Future.value(true);
        },
        child: CommonContainer(
          child: Responsive.isMobile(context)
              ? DashBoardMobile(arguments: widget.arguments)
              : DashBoardTablet(arguments: widget.arguments),
        ),
      ),
    );
  }
}
