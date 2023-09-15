import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/training_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/responsive.dart';

class TrainingItem extends StatelessWidget {
  final TrainingPrograms? trainingPrograms;
  final void Function()? onTap;

  const TrainingItem({Key? key, this.trainingPrograms, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Responsive.isMobile(context) ? Get.width / 2 - 10 : 214,
          decoration: BoxDecoration(
              borderRadius: cr16,
              color: AppColors.white,
              border: Border.all(
                  width: 1, color: AppColors.borderColor.withOpacity(0.8)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 08,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                    color: Colors.blueGrey.withOpacity(0.1))
              ]),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: CachedNetworkImage(
                  height: 150,
                  width:
                      Responsive.isMobile(context) ? Get.width / 2 - 10 : 214,
                  fit: BoxFit.cover,
                  imageUrl:
                      "${ApiRoutes.imageURL}${trainingPrograms?.tpProgramImage}",
                  errorWidget: (context, url, error) {
                    return SizedBox();
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: all8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              FormatDate.dateMonth(
                                  "${trainingPrograms?.tpCreatedAt}"),
                              style: FontStyleUtilities.t6(
                                  fontWeight: FWT.medium)),
                          Flexible(
                            child: FutureBuilder(
                                future: Translator().translate(
                                    "${trainingPrograms?.tpDuration}"),
                                builder: (context, snapshot) {
                                  return Text(
                                      snapshot.hasData
                                          ? "${snapshot.data}"
                                          : "${trainingPrograms?.tpDuration}",
                                      style: FontStyleUtilities.t4(
                                          fontWeight: FWT.medium));
                                }),
                          ),
                        ],
                      ),
                      h10,
                      Flexible(
                        child: FutureBuilder(
                            future: Translator().translate(
                                "${trainingPrograms?.tpProgramTitle}"),
                            builder: (context, snapshot) {
                              return Text(
                                  snapshot.hasData
                                      ? "${snapshot.data}"
                                      : "${trainingPrograms?.tpProgramTitle}",
                                  style: FontStyleUtilities.t2(
                                      fontWeight: FWT.semiBold,
                                      fontColor: AppColors.primaryColor));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: h8v5,
                child: LargeButton(
                  onPressed: onTap,
                  height: 40,
                  width: double.maxFinite,
                  textColor: AppColors.primaryColor,
                  color: AppColors.lightPurple1,
                  child: Text(
                    'details'.tr,
                    style: FontStyleUtilities.h6(
                        fontWeight: FWT.medium,
                        fontColor: AppColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 25,
          top: 125,
          child: LargeButton(
            onPressed: () {},
            height: 30,
            width: 80,
            borderRadius: cr99,
            color: AppColors.primary,
            textColor: AppColors.white,
            child: Text(
              'virtual'.tr,
            ),
          ),
        ),
      ],
    );
  }
}
