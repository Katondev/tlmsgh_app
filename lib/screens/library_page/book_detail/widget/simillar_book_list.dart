import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_widgets.dart';

class SimiLLerBookList extends StatelessWidget {
  final String? bookName;
  final String? bookImage;
  final int? bkPrice;
  final bool? bkIsFree;
  final void Function()? onTap;
  const SimiLLerBookList(
      {Key? key,
      required this.bookName,
      required this.bookImage,
      this.onTap,
      this.bkPrice,
      this.bkIsFree})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: t10l12r12,
      margin: l17r17b8t20,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: AppColors.gray300, blurRadius: 18, offset: Offset(0, 08))
      ], borderRadius: cr16, color: AppColors.white),
      child: Column(
        children: [
          Container(
            height: 142,
            decoration: BoxDecoration(
                borderRadius: onlyTopLeftRight12, color: AppColors.cardColor),
            child: Center(
              child: CachedNetworkImage(
                height: 117,
                width: 93,
                imageUrl: "$bookImage",
              ),
            ),
          ),
          h8,
          Align(
            alignment: Alignment.topLeft,
            child: FutureBuilder(
                future: Translator().translate("${bookName}"),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData ? "${snapshot.data}" : "${bookName}",
                    style: FontStyleUtilities.t4(fontWeight: FWT.medium)
                        .copyWith(overflow: TextOverflow.ellipsis),
                  );
                }),
            // Text(
            //   "$bookName",
            //   overflow: TextOverflow.ellipsis,
            //   style: FontStyleUtilities.t4(fontWeight: FWT.medium, height: 0)
            //       .copyWith(
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
          ),
          h14,
          RatingStars(space: 7.5, height: 11.17, width: 10.96),
          h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bkIsFree == true ? "free".tr : "${bkPrice}",
                  style: FontStyleUtilities.t2(
                      fontWeight: FWT.semiBold,
                      height: 0,
                      fontColor: bkIsFree == true
                          ? AppColors.freetext
                          : AppColors.black)),
              LargeButton(
                onPressed: onTap,
                height: 35.74,
                width: 98.12,
                textColor: AppColors.primaryColor,
                color: AppColors.lightPurple1,
                child: Text(
                  'details'.tr,
                  style: FontStyleUtilities.t2(
                      fontWeight: FWT.medium,
                      fontColor: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          // Button(
          //     height: 40,
          //     onTap: () {},
          //     borderRadius: BorderRadius.circular(4.0),
          //     color: AppColors.white,
          //     tittle: "Buy Now",
          //     style: FontStyleUtilities.t2(fontWeight: FWT.medium, height: 0),
          //     border: Border.all(color: AppColors.borderColor))
        ],
      ),
    );
  }
}
