import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/calender/calendar_data_source.dart';
import 'package:katon/screens/calender/controller/event_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventCalender extends StatelessWidget {
  final double height;
  final double width;
  EventCalender({Key? key, required this.height, required this.width})
      : super(key: key);
  final cnt = Get.put(EventsCnt());

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        padding: t18,
        decoration: BoxDecoration(borderRadius: cr24, color: AppColors.white),
        child: SfCalendar(
            view: CalendarView.month,
            dataSource: CalenderDataSource(
              cnt.getDataSource(),
            ),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            )));
  }
}
