import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/app_binding.dart';
import 'package:katon/widgets/text_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/font_style.dart';
import '../../../utils/validators.dart';
import '../../../widgets/button.dart';
import '../controller/blog_controller.dart';

Future showCreateBlogDialog(BuildContext context) {
  final blgCnt = Get.find<BlogController>();
  final createBlogKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: StatefulBuilder(
          builder: (context, setState) => Container(
            width: 600,
            height: 450,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            // padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Create Blog",
                            style:
                                FontStyleUtilities.h5(fontWeight: FWT.medium),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.close,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, height: 0),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true, padding: EdgeInsets.all(20),
                      physics: BouncingScrollPhysics(),
                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Form(
                            key: createBlogKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBox(
                                  hint: "Enter Blog Title",
                                  controller: blgCnt.blogTitle.value,
                                  validator: (val) =>
                                      Validators.validaterequired(
                                          val, "enter_blog_title".tr),
                                  fillColor: AppColors.boxgrey,
                                ),
                                h16,
                                TextBox(
                                  hint: "Enter Description",
                                  controller: blgCnt.blogDesc.value,
                                  validator: (val) =>
                                      Validators.validaterequired(
                                          val, "enter_blog_des".tr),
                                  maxLines: 5,
                                  fillColor: AppColors.boxgrey,
                                ),
                                h16,
                                Container(
                                  height: 50,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: cr10,
                                    color: AppColors.boxgrey,
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          await blgCnt.pickImage();
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          color: AppColors.grey.withOpacity(.8),
                                          child: Text(
                                            "Choose File",
                                            style: FontStyleUtilities.t3(
                                                fontWeight: FWT.medium,
                                                fontColor: AppColors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (blgCnt.path != null) h4,
                                if (blgCnt.path != null)
                                  Text(
                                      "${blgCnt.path!.path.toString().split("/").last}"),
                                h30,
                                LargeButton(
                                  onPressed: () async {
                                    if (createBlogKey.currentState!
                                        .validate()) {
                                      await blgCnt.addBlog();
                                    }
                                  },
                                  height: 50,
                                  width: Get.width,
                                  child: Text(
                                    "submit".tr,
                                    style: FontStyleUtilities.t1(
                                        fontWeight: FWT.medium,
                                        fontColor: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ).whenComplete(() => blgCnt.path = null);
}
