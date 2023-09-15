import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/home/widget/news_item/news_common_widget.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/time_ago.dart';

class NewsItemMobile extends StatelessWidget {
  const NewsItemMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorContainer(
        color: AppColors.darkPink,
        title: 'news'.tr,
        suffixItem: Text(
          'view_all'.tr,
          style: FontStyleUtilities.t4(
              fontColor: AppColors.white, fontWeight: FWT.semiBold),
        ),
        child: Container(
          padding: l10t10b10,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: cr20,
          ),
          child: Row(
            children: [
              NewsImage(height: 100, width: 100),
              Expanded(
                child: Padding(
                  padding: l10r10t4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(timeAgoSinceDate(),
                            style: FontStyleUtilities.t4(
                                fontColor: AppColors.grey500)),
                      ),
                      Text('cold_temprature'.tr,
                          textAlign: TextAlign.start,
                          style: FontStyleUtilities.t2(
                              fontWeight: FWT.medium,
                              fontColor: AppColors.blackType)),
                      h50,
                      NewsEntry()
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
