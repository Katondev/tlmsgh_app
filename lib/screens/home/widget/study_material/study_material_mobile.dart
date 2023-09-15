import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/home/widget/study_material/study_material_item_mobile.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';

class StudyMaterialMobile extends StatelessWidget {
  final String? image;
  final String? bookName;
  final double? bookPrice;
  final bool? isFree;

  const StudyMaterialMobile(
      {Key? key, this.image, this.bookName, this.bookPrice, this.isFree})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorContainer(
      color: AppColors.lightGreen,
      suffixItem: Padding(
        padding: r10,
        child: Text(
          "see_all".tr,
          style: FontStyleUtilities.t4(
              fontWeight: FWT.semiBold, fontColor: AppColors.white),
        ),
      ),
      title: "latest_study_material".tr,
      child: Column(
        children: [
          ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return StudyMaterialItemMobile(
                  image: image,
                  bookName: bookName,
                  isFree: isFree,
                  bookPrice: bookPrice);
            },
          ),
        ],
      ),
    );
  }
}
