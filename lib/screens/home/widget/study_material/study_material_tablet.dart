import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/home/widget/study_material/study_material_item_tablet.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';

class StudyMaterialTablet extends StatelessWidget {
  final String? image;
  final String? bookName;
  final double? bookPrice;
  final bool? isFree;

  const StudyMaterialTablet(
      {Key? key, this.image, this.bookName, this.bookPrice, this.isFree})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorContainer(
      height: 220,
      width: 991,
      color: AppColors.lightGreen,
      title: "latest_study_material".tr,
      suffixItem: Padding(
        padding: r15,
        child: Text(
          "see_all".tr,
          style: FontStyleUtilities.t4(
              fontWeight: FWT.semiBold, fontColor: AppColors.white),
        ),
      ),
      child: Expanded(
        child: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return StudyMaterialItemTablet(
                image: image,
                bookName: bookName,
                isFree: isFree,
                bookPrice: bookPrice);
          },
        ),
      ),
    );
  }
}

