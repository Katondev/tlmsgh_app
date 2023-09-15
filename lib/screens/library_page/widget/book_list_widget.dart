import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_widgets.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/svgIcon.dart';

class BookListItem extends StatelessWidget {
  final BookDetailsM? book;
  final void Function()? onTap;

  BookListItem({Key? key, required this.book, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // 214
        width: Responsive.isMobile(context) ? Get.width / 2 - 13 : 235,
        padding: l10r10t10b7,
        decoration: BoxDecoration(
          borderRadius: cr16,
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 142,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: onlyTopLeftRight12,
                  color: AppColors.black),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                      bottom: 16,
                      child: SvgIcon(Images.round1, height: 47, width: 103)),
                  Positioned(
                    bottom: 35,
                    child: CachedNetworkImage(
                      height: 90,
                      width: 75,
                      imageUrl: "${ApiRoutes.imageURL}${book?.bkPreview}",
                      errorWidget: (context, url, error) {
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
            h8,
            FutureBuilder(
                future: Translator().translate("${book?.bkTitle!}"),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData ? "${snapshot.data}" : "${book?.bkTitle}",
                    maxLines: 4,
                    style: FontStyleUtilities.t2(
                        fontWeight: FWT.medium,
                        fontColor: AppColors.primaryColor),
                  );
                }),
            // h10,
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingStars(height: 11, width: 11, space: 1),
                Text(book?.bkIsFree == true ? "free".tr : "${book?.bkPrice}",
                    style: FontStyleUtilities.t2(
                        fontWeight: FWT.semiBold,
                        height: 0,
                        fontColor: book?.bkIsFree == true
                            ? AppColors.freetext
                            : AppColors.black)),
              ],
            ),
            // Spacer(),
            h4,
            LargeButton(
              onPressed: onTap,
              height: 40,
              width: Get.width,
              textColor: AppColors.primaryColor,
              color: AppColors.lightPurple1,
              child: Text(
                'details'.tr,
                style: FontStyleUtilities.h6(
                    fontWeight: FWT.medium, fontColor: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
