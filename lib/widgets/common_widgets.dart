import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/library_page/book_detail/widget/reviews.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/svgIcon.dart';

class RatingStars extends StatelessWidget {
  final double? height;
  final double? width;
  final double? space;
  const RatingStars({Key? key, this.height, this.width, this.space})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        false,
        false,
        false,
        false,
        false,
      ]
          .map(
            (e) => Row(
              children: [
                SvgIcon(
                  Images.starSvg,
                  color: e ? AppColors.gray400 : AppColors.starColor,
                  height: height ?? 12,
                  width: width ?? 12,
                ),
                SizedBox(width: space ?? 4)
              ],
            ),
          )
          .toList(),
    );
  }
}

class ReviewsList extends StatelessWidget {
  const ReviewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: 5,
        // primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Reviews(
            name: "frank_garrett".tr,
            days: "day_ago".tr,
            image:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhwaLDKaK49tsHmdMGOrmTdns5qiw080F2Yw&usqp=CAU",
          );
        },
      ),
    );
  }
}
