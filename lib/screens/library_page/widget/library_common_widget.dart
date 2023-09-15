import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/elearning_model/category_model.dart';
import 'package:katon/models/elearning_model/sub_category_model.dart';
import 'package:katon/models/filter_category_model/filter_category_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/dropdown.dart';
import 'package:katon/widgets/text_field.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

class ELearningFilterBar extends StatelessWidget {
  const ELearningFilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ELearningProvider>(
      builder: (context, ePrv, child) {
        return SizedBox(
          width: context.width,
          height: 70,
          child: ListView(
            padding: all10,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              // Center(
              //   child: Text(
              //     "${ePrv.booksMCount} ${"books".tr}",
              //     style: FontStyleUtilities.h6(
              //       fontWeight: FWT.medium,
              //       fontColor: AppColors.primaryColor,
              //     ),
              //   ),
              // ),
              w10,
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
              DropDownCustom<String>(
                width: Responsive.isMobile(context) ? 170 : 178,
                onChange: (value) {
                  // if (value != "All") {
                  //   SnackBarService().showSnackBar(
                  //     message: "Rearranging the list",
                  //     type: SnackBarType.info,
                  //   );
                  // }

                  ePrv.updateSelectedFilter(value!);
                },
                items: ePrv.filterResourceList
                    .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: FutureBuilder(
                          future: Translator().translate("${e}"),
                          builder: (context, snapshot) => Text(
                              snapshot.hasData ? "${snapshot.data}" : "${e}",
                              style: FontStyleUtilities.h6()
                                  .copyWith(color: AppColors.black)),
                        )))
                    .toList(),
                selectedValue: ePrv.selectedFilter,
              ),
              w10,
              DropDownCustom<FilterCategoryModel>(
                width: Responsive.isMobile(context) ? 160 : 178,
                onChange: (value) {
                  // log("subcategory----${value?.subcategory?.length}");
                  ePrv.selectMainCategory(value: value);
                },
                items: ePrv.mainCategoryMList
                    .map(
                      (e) => DropdownMenuItem<FilterCategoryModel>(
                        value: e,
                        enabled: e.isenabled ?? true,
                        child: Text(
                          e.isenabled ?? true
                              ? "${e.categoryName}"
                              : "${e.maincategoryName}",
                          style: e.isenabled ?? true
                              ? FontStyleUtilities.h6()
                                  .copyWith(color: AppColors.black)
                              : FontStyleUtilities.t4()
                                  .copyWith(color: Colors.black54),
                        ),
                        // child: FutureBuilder(
                        //   future: Translator().translate("${e.categoryName}"),
                        //   builder: (context, snapshot) => Text(
                        //     snapshot.hasData
                        //         ? "${snapshot.data}"
                        //         : "${e.categoryName}",
                        //     style: e.isenabled ?? true
                        //         ? FontStyleUtilities.h6()
                        //             .copyWith(color: AppColors.black)
                        //         : FontStyleUtilities.t4()
                        //             .copyWith(color: Colors.black54),
                        //   ),
                        // ),
                      ),
                    )
                    .toList(),
                selectedValue: ePrv.selectedMainCat,
              ),
              w10,
              DropDownCustom<SubCategoryModel>(
                width: Responsive.isMobile(context) ? 140 : 178,
                onChange: (value) {
                  // log(value)
                  ePrv.selectSubcategory(value: value);
                  // ePrv.selectedFilter.value = "All";
                  // ePrv.updateSelectedFilter("All");
                },
                items: ePrv.subCategoryList
                    .map(
                      (e) => DropdownMenuItem<SubCategoryModel>(
                        value: e,
                        child: FutureBuilder(
                          future: Translator().translate("${e.categoryName}"),
                          builder: (context, snapshot) => Text(
                            snapshot.hasData
                                ? "${snapshot.data}"
                                : "${e.categoryName}",
                            style: FontStyleUtilities.h6().copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                selectedValue: ePrv.selectedSubCat,
              ),
              w10,
              TextBox(
                // fillColor: AppColors.textFiled,
                controller: ePrv.searchCnt,
                hint: 'search_here'.tr,
                suffix: const Icon(
                  Icons.search_rounded,
                  size: 20,
                ),
                width: Responsive.isMobile(context) ? 150 : 178,
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

class LibraryPagination extends StatelessWidget {
  final ELearningProvider ePrv;
  final double? width;

  const LibraryPagination({Key? key, required this.ePrv, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          decoration: const BoxDecoration(color: AppColors.backGroundColor),
          padding: all10,
          height: 70,
          child: NumberPaginator(
            numberPages: ePrv.totalNumberOfPages,
            onPageChange: (index) => null,
          ),
        ),
      ],
    );
  }
}
