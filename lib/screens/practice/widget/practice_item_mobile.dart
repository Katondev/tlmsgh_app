import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:katon/models/assignment_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/practice/widget/common_widgets.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';

class PracticeItemMobile extends StatelessWidget {
  final Assignment? assignment;
  final Function()? onPressed;

  const PracticeItemMobile({Key? key, this.assignment, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: v10,
      padding:h10v20,
      decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: cr20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
              future: Translator().translate("${assignment?.asnTitle}"),
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData
                      ? "${snapshot.data}"
                      : "${assignment?.asnTitle}",
                  style: FontStyleUtilities.h4(
                      fontWeight: FWT.bold, fontColor: AppColors.primaryColor),
                );
              }),
          h12,
          Text(
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facilis repellendus iusto alias autem praesentium quaerat nisi.",
            style: FontStyleUtilities.t3(
                fontWeight: FWT.medium, fontColor: AppColors.grey500),
          ),
          h12,
          Row(children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: AppColors.white,
              backgroundImage: CachedNetworkImageProvider(
                  "${ApiRoutes.imageURL}${assignment?.asnTeacher?.tcProfilePic}"),
            ),
            w16,
            FutureBuilder(
                future: Translator()
                    .translate("${assignment?.asnTeacher?.tcFullName}"),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData
                        ? "${snapshot.data}"
                        : "${assignment?.asnTeacher?.tcFullName}",
                    style: FontStyleUtilities.t1(
                        fontWeight: FWT.semiBold, fontColor: AppColors.grey500),
                  );
                }),
          ]),
          h10,
          Text(
            "english_letter_writting".tr,
            style: FontStyleUtilities.t1(fontColor: AppColors.grey500),
          ),
          h10,
          TotalMarksAndDuration(assignment: assignment),
          h12,
          StartAssignmentButton(onPressed: onPressed, assignment: assignment),
        ],
      ),
    );
  }
}
