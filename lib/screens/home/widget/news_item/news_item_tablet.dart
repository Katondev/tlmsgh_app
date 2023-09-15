import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/home/widget/news_item/news_common_widget.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/time_ago.dart';

class NewsItemTablet extends StatelessWidget {
  const NewsItemTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorContainer(
      width: 617,
      title: "news".tr,
      color: AppColors.darkPink,
      suffixItem: Text(
        'view_all'.tr,
        style: FontStyleUtilities.t4(
            fontColor: AppColors.white, fontWeight: FWT.semiBold),
      ),
      child: Container(
          padding: l12t12b12,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: cr20,
          ),
          child: Row(
            children: [
              NewsImage(height: 141, width: 144.03),
              Padding(
                padding:
                l19r24t4,
                child: SizedBox(
                  width: 390,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('cold_temprature'.tr,
                              style: FontStyleUtilities.t2(
                                  fontWeight: FWT.medium,
                                  fontColor: AppColors.blackType)),
                          const Spacer(),
                          Text(timeAgoSinceDate(),
                              style: FontStyleUtilities.t4(
                                  fontColor: AppColors.grey500))
                        ],
                      ),
                      h50,
                      NewsEntry()
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
