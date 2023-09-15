import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';
import '../../../components/image/image_widget.dart';
import '../../../network/api_constants.dart';
import '../../../utils/font_style.dart';
import '../../../widgets/responsive.dart';

Future shareEbookDialog(BuildContext context, {required BookDetailsM book}) {
  final elearnPrv = Provider.of<ELearningProvider>(context, listen: false);
  // final createBlogKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: (Responsive.isMobilenew(context))
            ? EdgeInsets.symmetric(horizontal: 20)
            : EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: StatefulBuilder(
          builder: (context, setState) => Container(
            width: 600,
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
                          // Text(
                          //   "Create Blog",
                          //   style:
                          //       FontStyleUtilities.h5(fontWeight: FWT.medium),
                          // ),
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
                  padding: (Responsive.isMobilenew(context))
                      ? EdgeInsets.symmetric(horizontal: 20, vertical: 20)
                      : const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NetworkImageWidget(
                            height: 115,
                            width: 80,
                            fit: BoxFit.fill,
                            imageUrl: "${ApiRoutes.imageURL}${book.bkPreview}",
                          ),
                          w36,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "E-Books",
                                  style: AppTextStyle.normalBold12
                                      .copyWith(color: AppColors.primaryBlack),
                                ),
                                h5,
                                RichText(
                                  text: TextSpan(
                                    text: "Subject: ",
                                    style: AppTextStyle.normalBold14.copyWith(
                                      fontSize: 15,
                                      color: AppColors.primaryBlack,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${book.bkLanguage}",
                                        style:
                                            AppTextStyle.normalBold14.copyWith(
                                          fontSize: 15,
                                          color: AppColors.textgrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                h5,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Topic: ",
                                      style: AppTextStyle.normalBold12.copyWith(
                                        color: AppColors.primaryBlack,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${book.bkDescription}",
                                        style:
                                            AppTextStyle.normalBold12.copyWith(
                                          color: AppColors.textgrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      h12,
                      SizedBox(
                        height: 36,
                        child: TextFormField(
                          controller: elearnPrv.ebookShareCnt,
                          style: AppTextStyle.normalRegular12,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                        ),
                      ),
                      h16,
                      Divider(
                        height: 0,
                        color: AppColors.shadowColor,
                      ),
                      h16,
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppAssets.copy, height: 20),
                            w6,
                            Text(
                              "Copy Link",
                              style: AppTextStyle.normalRegular12,
                            ),
                          ],
                        ),
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
