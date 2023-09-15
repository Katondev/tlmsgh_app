import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/elearning_model/category_model.dart';
import 'package:katon/models/elearning_model/sub_category_model.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';

class DropDown extends StatelessWidget {
  const DropDown(
      {Key? key,
      this.dropDowns,
      this.onChange,
      this.selectedValue,
      this.validator,
      this.hint})
      : super(key: key);
  final ValueChanged<String?>? onChange;
  final RxList<String>? dropDowns;
  final String? selectedValue;
  final Widget? hint;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 40,
        // padding: l12r12t10,
        // padding: l12r12,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5),
        //     color: AppColors.white,
        //     border: Border.all(color: AppColors.borderColor)),
        child: DropdownButtonFormField<String>(
            icon: Padding(
              padding: EdgeInsets.only(left: 10),
              child: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
            value: selectedValue ?? dropDowns?[0] ?? "A",
            iconSize: 18,
            hint: hint,
            // underline: Container(color: Colors.transparent),
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: AppColors.boxgrey,
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(15, 7, 15, 15)),
            borderRadius: BorderRadius.circular(5),
            alignment: Alignment.centerRight,
            isDense: true,
            isExpanded: true,
            style: AppTextStyle.normalRegular12,
            validator: validator,
            items: dropDowns
                ?.map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                      style: AppTextStyle.normalRegular12,
                    ),
                  ),
                )
                .toList(),
            onChanged: onChange),
      ),
    );
  }
}

class DropDownCustom<T> extends StatelessWidget {
  const DropDownCustom(
      {Key? key,
      this.onChange,
      this.selectedValue,
      this.items,
      this.width,
      this.validator,
      this.hint})
      : super(key: key);
  final ValueChanged<T?>? onChange;
  final List<DropdownMenuItem<T>>? items;
  final Rx<T>? selectedValue;
  final double? width;
  final Widget? hint;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: width,
      // // padding: l12r12t10,
      // padding: l12r12,
      // decoration: BoxDecoration(
      //     borderRadius: cr10,
      //     color: AppColors.white,
      //     border: Border.all(color: AppColors.borderColor)),
      child: DropdownButtonFormField<T>(
        icon: Padding(
          padding: EdgeInsets.only(left: 10),
          child: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
        hint: hint,
        iconSize: 18,
        value: selectedValue?.value,
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: AppColors.boxgrey,
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(15, 7, 15, 15)),
        // underline: Container(color: Colors.transparent),
        validator: validator,
        borderRadius: BorderRadius.circular(5),
        alignment: Alignment.centerLeft,
        isDense: true,
        isExpanded: true,
        style: AppTextStyle.normalRegular12,
        items: items,
        onChanged: onChange,
      ),
    );
  }
}

class DropDownMainCat extends StatelessWidget {
  const DropDownMainCat(
      {Key? key, this.dropDowns, this.onChange, this.selectedValue})
      : super(key: key);
  final ValueChanged<CategoryModel?>? onChange;
  final RxList<CategoryModel>? dropDowns;
  final Rx<CategoryModel>? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 50,
        padding: l12r12t10,
        decoration: BoxDecoration(
            borderRadius: cr10,
            color: AppColors.textFiled,
            border: Border.all(color: AppColors.borderColor)),
        child: DropdownButton<CategoryModel>(
            icon: Padding(
                padding: l14,
                child: const Icon(Icons.keyboard_arrow_down_rounded)),
            value: selectedValue!.value,
            underline: Container(color: Colors.transparent),
            borderRadius: cr10,
            alignment: Alignment.centerRight,
            isDense: true,
            isExpanded: true,
            style: FontStyleUtilities.h2(fontColor: AppColors.gray900),
            items: dropDowns
                ?.map((e) => DropdownMenuItem<CategoryModel>(
                    value: e,
                    child: Text(
                      "${e.categoryName}",
                      style: FontStyleUtilities.h6()
                          .copyWith(color: AppColors.black),
                    )))
                .toList(),
            onChanged: onChange),
      ),
    );
  }
}

class DropDownSubCat extends StatelessWidget {
  const DropDownSubCat(
      {Key? key, this.dropDowns, this.onChange, this.selectedValue})
      : super(key: key);
  final ValueChanged<SubCategoryModel?>? onChange;
  final RxList<SubCategoryModel>? dropDowns;
  final Rx<SubCategoryModel>? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 50,
        padding: l12r12t10,
        decoration: BoxDecoration(
            borderRadius: cr10,
            color: AppColors.textFiled,
            border: Border.all(color: AppColors.borderColor)),
        child: DropdownButton<SubCategoryModel>(
            icon: Padding(
                padding: l14,
                child: const Icon(Icons.keyboard_arrow_down_rounded)),
            value: selectedValue!.value,
            underline: Container(color: Colors.transparent),
            borderRadius: cr10,
            alignment: Alignment.centerRight,
            isDense: true,
            isExpanded: true,
            style: FontStyleUtilities.h2(fontColor: AppColors.gray900),
            items: dropDowns
                    ?.map((e) => DropdownMenuItem<SubCategoryModel>(
                        value: e,
                        child: Text(
                          "${e.categoryName}",
                          style: FontStyleUtilities.h6()
                              .copyWith(color: AppColors.black),
                        )))
                    .toList() ??
                [],
            onChanged: onChange),
      ),
    );
  }
}
