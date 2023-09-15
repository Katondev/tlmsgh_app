import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/models/notification_model.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/svgIcon.dart';

class NotificationItem extends StatelessWidget {
  final Notifications? notificationItem;
  final void Function()? imgOnTap;
  final void Function()? viewPdfOnTap;
  final void Function()? downloadOnTap;

  const NotificationItem({
    Key? key,
    required this.notificationItem,
    this.imgOnTap,
    this.downloadOnTap,
    this.viewPdfOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: Responsive.isMobile(context) ? hz10:hz24,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 0.0,
              child: Center(
                child: Text(
                  "${FormatDate.date(notificationItem?.ntCreatedAt.toString() ?? "")}\n${FormatDate.month(
                    notificationItem?.ntCreatedAt.toString() ?? "",
                  )}",
                  textAlign: TextAlign.center,
                  style:
                      FontStyleUtilities.t2(fontColor: AppColors.primaryColor),
                ),
              ),
            ),
            Padding(
              padding:l75,
              child: Container(
                width: double.infinity,
                height: Responsive.isMobile(context) ? 110 : 150.0,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.grey,
                      width: 1.w,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Responsive.isMobile(context) ? SizedBox() : w28,
                    SizedBox(
                      width: context.width / 2,
                      child: FutureBuilder(
                        future: Translator()
                            .translate("${notificationItem?.ntDesc}"),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.hasData
                                ? "${snapshot.data}"
                                : "${notificationItem?.ntDesc}",
                            style: FontStyleUtilities.t2(
                                    fontColor: AppColors.primaryColor)
                                .copyWith(overflow: TextOverflow.ellipsis),
                            maxLines: 5,
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    Responsive.isMobile(context) ? SizedBox() : w20,
                    notificationItem?.inProgress?.value == true
                        ? const CircularProgressIndicator()
                        : InkWell(
                            onTap:
                                notificationItem?.isDownloading?.value == true
                                    ? viewPdfOnTap
                                    : downloadOnTap,
                            child:
                                notificationItem?.isDownloading?.value == true
                                    ? Image.asset(
                                        Images.img,
                                        height: 32.0,
                                        width: 32.0,
                                      )
                                    : SvgIcon(
                                        Images.download,
                                        color: AppColors.primaryColor,
                                      ),
                          ),
                    if (!Responsive.isMobile(context)) w36,
                  ],
                ),
              ),
            ),

            /// ON free time: convert this widget to custom divider with params
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 50.0,
              child: Container(width: 1.5, color: AppColors.primaryColor),
            ),
            Positioned(
              top: Responsive.isMobile(context) ? 40 : 65.0,
              left: 39.5,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: Container(
                  margin: all4,
                  height: 15.0,
                  width: 15.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
