import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/svgIcon.dart';

class SideBarItem extends StatelessWidget {
  final String? icon;
  final String? image;
  final String? title;
  final bool? isActive;

  final void Function()? onTap;

  const SideBarItem(
      {Key? key, this.title, this.icon, this.isActive, this.onTap, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: InkWell(
        onTap: onTap,
        // borderRadius: cr12,
        child: Container(
          margin: (title == "Tution")
              ? EdgeInsets.symmetric(horizontal: 5, vertical: 5)
              : null,
          decoration: BoxDecoration(
            color:
                isActive ?? false ? AppColors.primaryYellow : AppColors.black,
            border: (title == "Tution")
                ? Border.all(color: AppColors.primaryWhite)
                : Border.all(
                    width: 1.2,
                    color: isActive ?? false
                        ? AppColors.gray400.withOpacity(0.0)
                        : Colors.transparent,
                  ),
            borderRadius:
                (title == "Tution") ? BorderRadius.circular(10) : null,
          ),
          padding: v12,
          child: Center(
            child: Row(
              children: [
                w14,
                if (icon != null)
                  SvgIcon(
                    "$icon",
                    height: 20,
                    width: 20,
                    color:
                        isActive ?? false ? AppColors.white : AppColors.white,
                  ),
                if (image != null)
                  Image.asset(
                    image!,
                    height: 20,
                    width: 20,
                    color: isActive ?? false
                        ? AppColors.white
                        : (title == "Tution")
                            ? AppColors.primaryWhite
                            : AppColors.gray909090,
                  ),
                w18,
                Flexible(
                  child: Text(
                    "$title",
                    style: AppTextStyle.normalRegular16.copyWith(
                        fontWeight: isActive ?? false
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isActive ?? false
                            ? AppColors.white
                            : AppColors.white,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
