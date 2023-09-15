import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';
import '../../controller/practice_prv.dart';

Future studentResultDialog(context) {
  final practicePrv = Provider.of<PracticePrv>(context, listen: false);
  // final createBlogKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (c) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: StatefulBuilder(
          builder: (c, setState) => Container(
            width: 500,
            // height: 350,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            // padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: AppColors.primaryBlack,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Student Result",
                            style: AppTextStyle.normalBold14
                                .copyWith(fontSize: 15),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColors.primaryWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, height: 0),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Students Name",
                            style: AppTextStyle.normalBold12.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Marks",
                            style: AppTextStyle.normalBold12.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      h10,
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          var data = practicePrv
                              .assignmentResult?.data?.assignmentResult?[i];
                          return Row(
                            children: [
                              Text(
                                "${data?.arStudent?.stFullName}",
                                style: AppTextStyle.normalRegular12.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${data?.arScore}",
                                style: AppTextStyle.normalRegular12.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: practicePrv
                            .assignmentResult?.data?.assignmentResult?.length,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
