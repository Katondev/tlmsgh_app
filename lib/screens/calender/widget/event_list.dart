import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/screens/calender/controller/event_cnt.dart';
import 'package:katon/screens/calender/widget/event_item.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/svgIcon.dart';

class EventList extends StatelessWidget {
  EventList({Key? key}) : super(key: key);
  final cnt = Get.put(EventsCnt());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          SvgIcon(Images.holiday),
          w12,
          Text(
            'holiday'.tr,
            style: FontStyleUtilities.h6(
                fontColor: AppColors.white, fontWeight: FWT.medium),
          )
        ]),
        h16,
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: cnt.events?.length,
            itemBuilder: (context, index) {
              if (cnt.events?[index].ecEventtype == Constants.holiday) {
                return Padding(
                  padding: b16,
                  child: EventItem(
                      date: FormatDate.formatDate(
                          cnt.events?[index].ecEventDate.toString() ?? ""),
                      backgroundColor: const Color(0xFF4F8E72),
                      fontColor: AppColors.white,
                      title: cnt.events?[index].ecEventTitle),
                );
              } else {
                return const SizedBox();
              }
            }),
        h26,
        Row(
          children: [
            SvgIcon(
              Images.upcomingEvent,
            ),
            w12,
            Text(
              'upcoming_events'.tr,
              style: FontStyleUtilities.h6(
                  fontColor: AppColors.white, fontWeight: FWT.medium),
            ),
          ],
        ),
        h16,
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: cnt.events?.length,
            itemBuilder: (context, index) {
              if (cnt.events?[index].ecEventtype == Constants.event) {
                return Padding(
                  padding: b16,
                  child: EventItem(
                    date: FormatDate.formatDate(
                        cnt.events?[index].ecEventDate.toString() ?? ""),
                    backgroundColor: const Color(0xFF4F8E72),
                    fontColor: AppColors.white,
                    title: cnt.events?[index].ecEventTitle,
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
        h26,
        Row(
          children: [
            SvgIcon(
              Images.upcomingEvent,
            ),
            w12,
            Text(
              'events'.tr,
              style: FontStyleUtilities.h6(
                  fontColor: AppColors.white, fontWeight: FWT.medium),
            ),
          ],
        ),
        h16,
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: cnt.events?.length,
            itemBuilder: (context, index) {
              if (cnt.events?[index].ecEventtype == Constants.exam) {
                return Padding(
                  padding: b16,
                  child: EventItem(
                    date: FormatDate.formatDate(
                        cnt.events?[index].ecEventDate.toString() ?? ""),
                    backgroundColor: const Color(0xFF4F8E72),
                    fontColor: AppColors.white,
                    title: cnt.events?[index].ecEventTitle,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
      ],
    );
  }
}
