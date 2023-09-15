import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/utils/validators.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/text_field.dart';
import '../../../../models/argument_model.dart';
import '../../../../widgets/loader.dart';
import '../../controller/blog_controller.dart';

class CreateBlogMobile extends StatefulWidget {
  final Arguments arguments;
  const CreateBlogMobile({super.key, required this.arguments});

  @override
  State<CreateBlogMobile> createState() => _CreateBlogMobileState();
}

class _CreateBlogMobileState extends State<CreateBlogMobile> {
  final blgCnt = Get.put(BlogController());
  final createBlogKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.arguments.title,
          style: FontStyleUtilities.h4(fontWeight: FWT.medium),
        ),
      ),
      body: Obx(
        () => blgCnt.isLoading.value
            ? Loader(message: "loading".tr)
            : Form(
                key: createBlogKey,
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    TextBox(
                      hint: "Enter Blog Title",
                      controller: blgCnt.blogTitle.value,
                      validator: (val) => Validators.validaterequired(
                          val, "enter_blog_title".tr),
                      fillColor: AppColors.boxgrey,
                    ),
                    h16,
                    TextBox(
                      hint: "Enter Description",
                      controller: blgCnt.blogDesc.value,
                      validator: (val) =>
                          Validators.validaterequired(val, "enter_blog_des".tr),
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
                              padding: EdgeInsets.symmetric(horizontal: 30),
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
                      Text("${blgCnt.path!.path.toString().split("/").last}"),
                    h30,
                    LargeButton(
                      onPressed: () async {
                        if (createBlogKey.currentState!.validate()) {
                          await blgCnt.addBlog();
                        }
                      },
                      height: 50,
                      child: Text(
                        "submit".tr,
                        style: FontStyleUtilities.t1(
                            fontWeight: FWT.medium, fontColor: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
