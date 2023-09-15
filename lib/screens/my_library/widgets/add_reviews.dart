import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/text_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/font_style.dart';
import '../../../widgets/common_container.dart';
import '../../library_page/controller/elearning_cnt.dart';

class AddReviews extends StatelessWidget {
  const AddReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ELearningCnt>(
      builder:(cnt)=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DottedLine(width: 0.6, color: AppColors.primary),
          h26,
          Text(
            "send_reviews".tr,
            style: FontStyleUtilities.h6(
              height: 0,
              fontColor: AppColors.gray800,
              fontWeight: FWT.medium,
            ),
          ),
          h10,
          TextBox(
            hint: "Write comment",
            maxLines: 4,
          ),
          h10,
          Text(
            "your_rating".tr,
            style: FontStyleUtilities.h6(
              height: 0,
              fontColor: AppColors.gray800,
              fontWeight: FWT.medium,
            ),
          ),
          h10,
          Center(
            child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              unratedColor: AppColors.gray300,
              itemSize: 45,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                cnt.ratingval.value = rating;
              },
            ),
          ),
          h20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LargeButton(
                height: 50,
                onPressed: () {},
                child: Text(
                  "submit".tr,
                  style: FontStyleUtilities.h6(
                    fontColor: AppColors.white,
                    fontWeight: FWT.semiBold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
