import 'package:flutter/material.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_widgets.dart';

class Reviews extends StatelessWidget {
  final String name;
  final String days;
  final String image;
  const Reviews({
    Key? key,
    required this.name,
    required this.days,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 150,
      // padding: t18r45,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              // height: 44,
              // width: 44,
              decoration: BoxDecoration(
                  color: AppColors.gray400,
                  image: DecorationImage(image: NetworkImage(image)),
                  shape: BoxShape.circle),
            ),
          ),
          w24,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name,
                  style: FontStyleUtilities.t2(
                      fontWeight: FWT.medium, fontColor: AppColors.gray800)),

              h4,
              RatingStars(width: 12.12, height: 12.36, space: 12),
              h4,

              Text(days,
                  style: FontStyleUtilities.t4(fontColor: AppColors.gray700)),
              // SizedBox(
              //     width: 309,
              //     child: Text(
              //       description,
              //       style: FontStyleUtilities.t4(
              //               fontWeight: FWT.medium,
              //               fontColor: AppColors.gray700)
              //           .copyWith(
              //               fontSize: 10, overflow: TextOverflow.ellipsis),
              //       maxLines: 2,
              //     )),
            ],
          ),
        ],
      ),
    );
  }
}
