import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/svgIcon.dart';
import 'package:katon/widgets/time_ago.dart';

/// Display recent notification on student dashboard

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorContainer(
      width: Responsive.isMobile(context) ? double.infinity : 350,
      color: AppColors.nevYBlue,
      title: 'notification'.tr,
      svgImage: Images.calendar2Svg,
      suffixItem: Row(
        children: [
          LargeButton(
            onPressed: () {},
            borderRadius: cr6,
            height: 28.35,
            width: 54,
            color: AppColors.primaryColor,
            child: Text(
              '2_New'.tr,
              style: FontStyleUtilities.t6(
                  fontColor: AppColors.white, fontWeight: FWT.medium),
            ),
          ),
          w6,
          Text(
            'read_all'.tr,
            style: FontStyleUtilities.p3(
                fontWeight: FWT.semiBold, fontColor: AppColors.white),
          ),
        ],
      ),
      child: Container(
        padding: t14l18,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: cr20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('today.'.tr,
                style: FontStyleUtilities.t2(
                    fontWeight: FWT.medium, fontColor: AppColors.blackType)),
            h24,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(radius: 2.5, backgroundColor: AppColors.red),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey500.withOpacity(0.20),
                  child: Center(
                    child: SvgIcon(Images.checkSvg, color: AppColors.gray700),
                  ),
                ),
                w10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('your_order'.tr,
                            style: FontStyleUtilities.t2(
                                fontColor: AppColors.blackType)),
                        Text('successful'.tr,
                            style: FontStyleUtilities.t2(
                                fontWeight: FWT.semiBold,
                                fontColor: AppColors.blackType)),
                      ],
                    ),
                    h4,
                    Row(
                      children: [
                        SvgIcon(Images.clockSvg),
                        w8,
                        Text(timeAgoSinceDate(),
                            style: FontStyleUtilities.t4(
                                fontColor: AppColors.gray801))
                      ],
                    )
                  ],
                ),
              ],
            ),
            h24,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/photos/portrait-of-schoolboy-standing-at-school-campus-picture-id1163984184?k=20&m=1163984184&s=612x612&w=0&h=GI3jbN2rEoM69Z1MPJwvNgnfwFg8hCKFykIvQgGIcdA=")),
                w10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('your_order'.tr,
                            style: FontStyleUtilities.t2(
                                fontColor: AppColors.blackType)),
                        Text('successful'.tr,
                            style: FontStyleUtilities.t2(
                                fontWeight: FWT.semiBold,
                                fontColor: AppColors.blackType)),
                      ],
                    ),
                    h4,
                    Row(
                      children: [
                        SvgIcon(Images.clockSvg),
                        w8,
                        Text(timeAgoSinceDate(),
                            style: FontStyleUtilities.t4(
                                fontColor: AppColors.gray801))
                      ],
                    )
                  ],
                ),
              ],
            ),
            h24,
            Text('yesterday'.tr,
                style: FontStyleUtilities.t2(
                    fontWeight: FWT.medium, fontColor: AppColors.gray801)),
            h20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey500.withOpacity(0.20),
                  child: Center(
                    child:
                        SvgIcon(Images.calendar2Svg, color: AppColors.gray700),
                  ),
                ),
                w14,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('appointment '.tr,
                            style: FontStyleUtilities.t2(
                                fontColor: AppColors.blackType)),
                        Text('today.'.tr,
                            style: FontStyleUtilities.t2(
                                fontWeight: FWT.semiBold,
                                fontColor: AppColors.blackType)),
                      ],
                    ),
                    h4,
                    Row(
                      children: [
                        SvgIcon(
                          Images.calendarSvg,
                          height: 16,
                          width: 16,
                          color: AppColors.blackType,
                        ),
                        w8,
                        Text('27/04/2022',
                            style: FontStyleUtilities.t4(
                                fontColor: AppColors.blackType)),
                      ],
                    ),
                    h10,
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
