import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:katon/models/elearning_model/category_model.dart';
import 'package:katon/models/elearning_model/sub_category_model.dart';
import 'package:katon/screens/live_class/controller/live_class_prv.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/dropdown.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class LiveClassFilterBar extends StatelessWidget {
  const LiveClassFilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LiveClassProvider>(
      builder: (context, ePrv, child) {
        return SizedBox(
          width: context.width,
          height: 70,
          child: ListView(
            padding: all10,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              LargeButton(
                borderColor: AppColors.primary,
                borderWidth: 1.5,
                color: Colors.transparent,
                onPressed: () async => await ePrv.resetOnTap(),
                height: 48,
                width: Responsive.isMobile(context) ? 100 : 178,
                child: Text(
                  'reset'.tr,
                  style: FontStyleUtilities.h6(
                      fontWeight: FWT.medium, fontColor: AppColors.primary),
                ),
              ),
              w10,
              DropDownCustom<CategoryModel>(
                width: Responsive.isMobile(context) ? 150 : 200,
                onChange: (value) => ePrv.selectSubCategory(value: value),
                items: ePrv.mainCategoryMList
                    .map(
                      (e) => DropdownMenuItem<CategoryModel>(
                        value: e,
                        child: Text(
                          "${e.categoryName}",
                          style: FontStyleUtilities.h6().copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                selectedValue: ePrv.selectedMainCat.obs,
              ),
              w10,
              DropDownCustom<SubCategoryModel>(
                width: Responsive.isMobile(context) ? 150 : 200,
                onChange: (value) => ePrv.selectSubcategory(value: value),
                items: ePrv.subCategoryList
                    .map(
                      (e) => DropdownMenuItem<SubCategoryModel>(
                        value: e,
                        child: Text(
                          "${e.categoryName}",
                          style: FontStyleUtilities.h6().copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                selectedValue: ePrv.selectedSubCat.obs,
              ),
              w10,
              LargeButton(
                height: 48,
                onPressed: () => ePrv.submitOnTap(),
                child: Text(
                  "search".tr,
                  style: FontStyleUtilities.h5(
                    fontWeight: FWT.medium,
                    fontColor: AppColors.white,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
