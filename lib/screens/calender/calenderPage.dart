import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/calender/calender_mobile.dart';
import 'package:katon/screens/calender/calender_tablet.dart';
import 'package:katon/screens/calender/controller/event_cnt.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/connection_manager.dart';

class CalenderPage extends StatefulWidget {
  final Arguments? arguments;

  const CalenderPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  final cnt = Get.put(EventsCnt());
  final connection = Get.put(ConnectionManagerController());

  @override
  void initState() {
    super.initState();
    cnt.getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return CalenderMobilePage(arguments: widget.arguments);
    } else {
      return CalenderTabletPage(arguments: widget.arguments);
    }
  }

  // List<Meeting> _getDataSource() {
  //   final List<Meeting> meetings = <Meeting>[];
  //   cnt.events?.forEach((element) {
  //     final DateTime startTime =
  //         FormatDate.stringToDate(element.ecEventDate.toString());
  //     final DateTime endTime = startTime.add(const Duration(hours: 12));
  //     meetings.add(Meeting(element.ecEventTitle.toString(), startTime, endTime,
  //         const Color(0xFF0F8644), false));
  //   });
  //   return meetings;
  // }
}
