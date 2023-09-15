import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/widgets/svgIcon.dart';
import 'package:katon/widgets/text_field.dart';

import '../components/app_text_style.dart';

class TextFiledWithTitle extends StatelessWidget {
  final String hint;
  final String title;
  final String? trailingTitle;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController? controller;
  final Widget? icon;
  final int? maxLines;
  final Function()? onTap;
  final Function()? copyOnTap;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? obscureText;
  final bool isrequired;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final bool? scrollPadding;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;

  const TextFiledWithTitle(
      {Key? key,
      required this.hint,
      required this.title,
      this.trailingTitle,
      this.keyboardType,
      this.maxLength,
      this.controller,
      this.icon,
      this.obscureText = false,
      this.maxLines,
      this.onTap,
      this.focusNode,
      this.copyOnTap,
      this.readOnly,
      this.validator,
      this.isrequired = false,
      this.scrollPadding,
      this.onChanged,
      this.suffix,
      this.inputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (isrequired)
            ? Row(
                children: [
                  Text(title,
                      style:
                          FontStyleUtilities.t2(fontColor: AppColors.grey500)),
                  w4,
                  Text(
                    "*",
                    style:
                        FontStyleUtilities.h6(fontColor: AppColors.appbarRed),
                  ),
                  if (trailingTitle != null) w4,
                  if (trailingTitle != null)
                    Expanded(
                      child: Text(trailingTitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FontStyleUtilities.t2(
                              fontColor: AppColors.grey500)),
                    ),
                ],
              )
            : Text(title,
                style: FontStyleUtilities.t2(fontColor: AppColors.grey500)),
        h8,
        TextBox(
          onChanged: onChanged,
          hint: hint,
          keyboardType: keyboardType,
          onTap: onTap,
          maxLength: maxLength,
          readOnly: readOnly,
          isObs: obscureText,
          controller: controller,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          maxLines: maxLines ?? 1,
          validator: validator,
          scrollPadding: scrollPadding,
          suffix: icon == null
              ? null
              : InkWell(
                  onTap: copyOnTap,
                  child: Padding(
                    padding: b12t12,
                    child: icon,
                  ),
                ),
        ),
      ],
    );
  }
}

class TextfieldwithTitle extends StatelessWidget {
  final String hint;
  final String title;
  final String? trailingTitle;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController? controller;
  final Widget? icon;
  final int? maxLines;
  final Function()? onTap;
  final Function()? copyOnTap;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? obscureText;
  final bool isrequired;
  final FormFieldValidator<String>? validator;
  final void Function(String?)? onChanged;
  final bool? scrollPadding;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? iconPadding;
  final Color? filledColor;
  final double? height;
  final bool? ismaxline;

  const TextfieldwithTitle(
      {Key? key,
      required this.hint,
      required this.title,
      this.trailingTitle,
      this.keyboardType,
      this.maxLength,
      this.controller,
      this.icon,
      this.obscureText = false,
      this.maxLines,
      this.onTap,
      this.focusNode,
      this.copyOnTap,
      this.readOnly,
      this.validator,
      this.isrequired = false,
      this.scrollPadding,
      this.onChanged,
      this.suffix,
      this.inputFormatters,
      this.contentPadding,
      this.filledColor,
      this.height,
      this.iconPadding,
      this.ismaxline = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (isrequired)
            ? Row(
                children: [
                  Text(
                    title,
                    style: AppTextStyle.normalBold12.copyWith(
                      color: AppColors.primaryBlack,
                    ),
                  ),
                  w4,
                  Text(
                    "*",
                    style:
                        FontStyleUtilities.h6(fontColor: AppColors.appbarRed),
                  ),
                  if (trailingTitle != null) w4,
                  if (trailingTitle != null)
                    Expanded(
                      child: Text(
                        trailingTitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.normalRegular12.copyWith(
                          color: AppColors.gray400,
                        ),
                      ),
                    ),
                ],
              )
            : Text(
                title,
                style: AppTextStyle.normalBold12.copyWith(
                  color: AppColors.primaryBlack,
                ),
              ),
        h8,
        SizedBox(
          height: (ismaxline!) ? null : height ?? 40,
          child: textFormField(
            onChanged: onChanged,
            hintText: hint,
            keyboardType: keyboardType,
            onTap: onTap,
            maxLength: maxLength,
            readonly: readOnly,
            obscureText: obscureText ?? false,
            controller: controller,
            focusNode: focusNode,
            filledColor: filledColor ?? AppColors.boxgrey,
            inputFormatters: inputFormatters,
            maxLines: maxLines ?? 1,
            validator: validator,
            contentPadding: contentPadding ??
                EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
            scropadding: EdgeInsets.only(bottom: 50),
            suffixIcon: icon == null
                ? null
                : InkWell(
                    onTap: copyOnTap,
                    child: Padding(
                      padding: iconPadding ?? EdgeInsets.all(13),
                      child: icon,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
