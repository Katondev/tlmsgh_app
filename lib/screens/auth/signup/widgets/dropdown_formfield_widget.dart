import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';

class DropdownWidget<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final Widget? hint;
  const DropdownWidget(
      {super.key,
      this.value,
      this.items,
      this.validator,
      this.onChanged,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      icon: Padding(
          padding: l14, child: const Icon(Icons.keyboard_arrow_down_rounded)),
      // hint: Text(
      //     "${"select_school_name".tr}"),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: cr10,
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        filled: true,
        fillColor: AppColors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: cr10,
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
      ),
      // value: cnt.regionValue.value,

      value: value,
      items: items,
      validator: validator,
      onChanged: onChanged,
      hint: hint,
      // borderRadius: cr10,
      isDense: true,
      isExpanded: true,
      
    );
  }
}
