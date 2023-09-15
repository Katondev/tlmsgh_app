import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/live_class_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/svgIcon.dart';

class LiveClassList extends StatelessWidget {
  final LiveSession? liveSession;
  final void Function()? onTap;

  const LiveClassList({Key? key, required this.liveSession, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Responsive.isMobile(context) ? Get.width / 2 - 15 : 235,
          padding: l10t10r10,
          decoration: BoxDecoration(
            borderRadius: cr16,
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: 194,
                decoration: BoxDecoration(
                  borderRadius: cr12,
                  color: AppColors.white,
                ),
                child: ClipRRect(
                  borderRadius: cr12,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "${ApiRoutes.imageURL}${liveSession?.lsImage}",
                    errorWidget: (context, url, error) => SizedBox(),
                  ),
                ),
              ),
              h16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.white,
                    backgroundImage: CachedNetworkImageProvider(
                      "${ApiRoutes.imageURL}${liveSession?.lsTeacher?.tcProfilePic}",
                    ),
                  ),
                  Flexible(
                    child: FutureBuilder(
                      future: Translator()
                          .translate("${liveSession!.lsTeacher?.tcFullName}"),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasData
                              ? "${snapshot.data}"
                              : "${liveSession!.lsTeacher?.tcFullName}",
                          style: FontStyleUtilities.t4(
                            fontWeight: FWT.medium,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              h10,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgIcon(Images.calendar2Svg),
                  w10,
                  Flexible(
                    child: Text(
                      "${liveSession?.lsDate} ${liveSession?.lsTime}",
                      softWrap: true,
                      textAlign: TextAlign.end,
                      style: FontStyleUtilities.t4(
                              fontWeight: FWT.medium, height: 0)
                          .copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              h10,
              FutureBuilder(
                  future: Translator().translate("${liveSession?.lsTitle}"),
                  builder: (context, snapshot) {
                    return Text(
                        snapshot.hasData
                            ? "${snapshot.data}"
                            : "${liveSession?.lsTitle}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FontStyleUtilities.t2(
                          fontWeight: FWT.medium,
                        ).copyWith(
                          overflow: TextOverflow.visible,
                        ));
                  }),
              FutureBuilder(
                future: Translator().translate("${liveSession?.lsDesc}"),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData
                        ? "${snapshot.data}"
                        : "${liveSession?.lsDesc}",
                    maxLines: 1,
                    style: FontStyleUtilities.t4(
                      fontWeight: FWT.regular,
                      fontColor: AppColors.grey500,
                    ).copyWith(
                      overflow: TextOverflow.visible,
                    ),
                  );
                },
              ),
              h10,
              Spacer(),
              Center(
                child: LargeButton(
                  onPressed: onTap,
                  height: 40,
                  width: double.maxFinite,
                  textColor: AppColors.primaryColor,
                  color: AppColors.lightPurple1,
                  child: Text(
                    'class_details'.tr,
                    style: FontStyleUtilities.h6(
                        fontWeight: FWT.medium,
                        fontColor: AppColors.primaryColor),
                  ),
                ),
              ),
              h8,
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
            child: FutureBuilder(
              future: Translator().translate("${liveSession?.lsSubCategory}"),
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData
                      ? "${snapshot.data}"
                      : "${liveSession?.lsSubCategory}",
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
