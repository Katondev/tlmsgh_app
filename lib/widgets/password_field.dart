import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/svgIcon.dart';
import 'package:katon/widgets/text_field.dart';

class PasswordField extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final String hint;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final double? width;
  final Color? color;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  PasswordField(
      {Key? key,
      required this.hint,
      this.textInputAction,
      this.validator,
      this.controller,
      this.hintStyle,
      this.width,
      this.color,
      this.onSubmitted,
      this.onChanged,
      this.inputFormatters})
      : super(key: key);

  final RxBool isObs = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: width,
        child: TextBox(
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          controller: controller,
          readOnly: false,
          textInputAction: TextInputAction.next,
          isObs: isObs.value,
          validator: validator,
          hint: hint,
          inputFormatters: inputFormatters,
          // prefix: SvgIcon(Images.lockSvg),
          suffix: GestureDetector(
            onTap: () => isObs.value = !isObs.value,
            child: Padding(
              padding: r16t10b10l19,
              child: !isObs.value
                  ? Icon(Icons.visibility_off,
                      color: AppColors.iconGrey, size: 20)
                  : const Icon(
                      Icons.visibility,
                      color: AppColors.iconGrey,
                      size: 20,
                    ),
            ),
          ),
          // prefixIcon: Icons.access_time_sharp,
          // prefix: AuthIconWrapper(
          //   icon: 'assets/Icons/password.svg',
          //   // iconColor: ColorUtil.primaryColor,
          // ),
        ),
      ),
    );
  }
}
