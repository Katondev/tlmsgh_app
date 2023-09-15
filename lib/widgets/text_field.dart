import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';

import '../components/app_text_style.dart';

class TextBox extends StatelessWidget {
  final String hint;
  final double? maxHeight;
  final int? maxLines;
  final int? maxLength;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final Widget? prefix, suffix;
  final ImageProvider? preImage;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final GestureTapCallback? onTap;
  final bool? isObs;
  final bool? autofocus;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final TextStyle? hintStyle;
  final bool? prefixImage;
  final Color? fillColor;
  final double? width;
  final bool? scrollPadding;

  const TextBox({
    super.key,
    required this.hint,
    this.maxHeight,
    this.maxLines = 1,
    this.controller,
    this.onSubmitted,
    this.validator,
    this.prefix,
    this.textInputAction,
    this.suffix,
    this.maxLength,
    this.isObs = false,
    this.keyboardType,
    this.inputFormatters,
    this.readOnly,
    this.onTap,
    this.autofocus,
    this.focusNode,
    this.onChanged,
    this.hintStyle,
    this.prefixImage,
    this.preImage,
    this.fillColor,
    this.width,
    this.scrollPadding,
  });

  static final OutlineInputBorder _border =
      OutlineInputBorder(borderRadius: cr8, borderSide: BorderSide.none);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
          // obscuringCharacter: "*",
          scrollPadding: scrollPadding ?? false
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 30)
              : EdgeInsets.all(20),
          obscureText: isObs!,
          validator: validator,
          maxLength: maxLength,
          keyboardType: keyboardType,
          onFieldSubmitted: onSubmitted,
          controller: controller,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          readOnly: readOnly ?? false,
          maxLines: maxLines,
          textCapitalization: TextCapitalization.none,
          onTap: onTap,
          autofocus: autofocus ?? false,
          focusNode: focusNode,
          onChanged: onChanged,
          style: FontStyleUtilities.h6().copyWith(color: AppColors.black),
          decoration: InputDecoration(
            contentPadding: prefix != null && prefixImage == true
                ? r19t10b10
                : EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            counterText: "",
            prefixIcon: prefix != null || prefixImage == true
                ? Container(
                    margin: prefixImage ?? false ? null : r14t9b9,
                    padding: prefixImage ?? false ? hz8 : hz16,
                    decoration: BoxDecoration(
                        border: prefixImage ?? false
                            ? const Border()
                            : const Border(
                                right:
                                    BorderSide(color: AppColors.borderColor))),
                    child: prefixImage ?? false
                        ? CircleAvatar(
                            backgroundColor: AppColors.red1,
                            radius: 24.r,
                            backgroundImage: preImage,
                          )
                        : prefix)
                : null,
            suffixIcon: suffix,
            fillColor: fillColor ?? AppColors.white,
            filled: true,
            hintMaxLines: maxLines,
            hintText: hint,
            hintStyle: hintStyle ??
                FontStyleUtilities.t2(fontColor: AppColors.gray400),

            border: _border,
            errorMaxLines: 2,
            errorStyle: TextStyle(overflow: TextOverflow.visible),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.red,
                ),
                borderRadius: cr10),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.borderColor,
                ),
                borderRadius: cr10),
            // constraints: ,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.red,
                ),
                borderRadius: cr10),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.primary,
                ),
                borderRadius: cr10),
          )),
    );
  }
}

// 0xff121212
class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    this.fieldKey,
    this.hintText,
    this.textStyle,
    this.hintStyle,
    this.validator,
    this.prefixIcon,
    required this.controller,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.borderColor,
    this.filledColor,
    this.enabled,
    this.readonly,
    this.scropadding,
    this.textAlign = TextAlign.left,
    this.contentPadding,
    this.obscureText,
  }) : super(key: key);
  final EdgeInsets? scropadding;
  final Key? fieldKey;
  final bool? readonly;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? borderColor;
  final Color? filledColor;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String?>? onFieldSubmitted;
  final ValueChanged<String?>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final bool? enabled;
  final EdgeInsetsGeometry? contentPadding;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return textFormField(
      fieldKey: fieldKey,
      focusNode: focusNode,
      hintText: hintText,
      scropadding: scropadding,
      controller: controller,
      borderRaduis: 5,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      maxLength: maxLength,
      maxLines: maxLines,
      enabled: enabled ?? true,
      textInputAction: textInputAction,
      textAlign: textAlign,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      contentPadding: const EdgeInsets.fromLTRB(20, 18, 10, 15),
      textStyle: textStyle,
      hintStyle: hintStyle,
      borderColor: borderColor,
      filledColor: filledColor,
    );
  }
}

TextFormField textFormField({
  final Key? fieldKey,
  final String? hintText,
  final String? labelText,
  final String? helperText,
  final String? initialValue,
  final int? errorMaxLines,
  final int? maxLines,
  final int? maxLength,
  final double? borderRaduis = 0,
  final bool? enabled,
  final bool autofocus = false,
  final bool obscureText = false,
  final Color? filledColor,
  final Color? cursorColor,
  final Color? borderColor,
  final Widget? prefixIcon,
  final Widget? suffixIcon,
  final FocusNode? focusNode,
  final TextStyle? style,
  final TextStyle? textStyle,
  final TextStyle? hintStyle,
  final TextAlign textAlign = TextAlign.left,
  final TextEditingController? controller,
  final List<TextInputFormatter>? inputFormatters,
  final TextInputAction? textInputAction,
  final TextInputType? keyboardType,
  final TextCapitalization textCapitalization = TextCapitalization.none,
  final GestureTapCallback? onTap,
  final FormFieldSetter<String?>? onSaved,
  final FormFieldValidator<String?>? validator,
  final ValueChanged<String?>? onChanged,
  final ValueChanged<String?>? onFieldSubmitted,
  final BorderSide? border,
  final EdgeInsetsGeometry? contentPadding,
  final bool? readonly,
  final EdgeInsets? scropadding,
}) {
  return TextFormField(
    scrollPadding: scropadding ?? EdgeInsets.zero,
    key: fieldKey,
    readOnly: readonly ?? false,
    controller: controller,
    focusNode: focusNode,
    maxLines: maxLines,
    initialValue: initialValue,
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    obscureText: obscureText,
    enabled: enabled,
    validator: validator,
    maxLength: maxLength,
    textInputAction: textInputAction,
    inputFormatters: inputFormatters,
    onTap: onTap,
    onSaved: onSaved,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    autocorrect: true,
    autofocus: autofocus,
    textAlign: textAlign,
    cursorColor: AppColors.primaryBlack,
    cursorHeight: 15,
    style: textStyle ?? AppTextStyle.normalRegular12,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      contentPadding:
          contentPadding ?? const EdgeInsets.fromLTRB(20, 18, 10, 18),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis!),
        borderSide: border ?? BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis),
        borderSide: border ?? BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis),
        borderSide: border ?? BorderSide.none,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis),
        borderSide: border ?? BorderSide.none,
      ),
      errorMaxLines: 5,
      fillColor: filledColor ?? AppColors.textFieldColor,
      filled: true,
      hintStyle: hintStyle ??
          AppTextStyle.normalRegular12
              .copyWith(color: AppColors.textFieldhintColor),
      hintText: hintText,
      enabled: enabled ?? true,
      suffixIcon: suffixIcon,
      labelText: labelText,
      helperText: helperText,
    ),
  );
}
