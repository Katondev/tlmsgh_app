import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/group_page/controller/group_controller.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/text_field.dart';
import '../../../../models/argument_model.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/loader.dart';
import '../../../blog_page/controller/blog_controller.dart';

class CreateGroupBlogMobile extends StatefulWidget {
  final Arguments arguments;
  const CreateGroupBlogMobile({super.key, required this.arguments});

  @override
  State<CreateGroupBlogMobile> createState() => _CreateGroupBlogMobileState();
}

class _CreateGroupBlogMobileState extends State<CreateGroupBlogMobile> {
  final grpCnt = Get.put(GroupController());
  final createGroupBlogKey = GlobalKey<FormState>();
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
        () => Form(
          key: createGroupBlogKey,
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              TextBox(
                hint: "Enter Blog Title",
                controller: grpCnt.groupblogTitle.value,
                validator: (val) =>
                    Validators.validaterequired(val, "enter_blog_title".tr),
                fillColor: AppColors.boxgrey,
              ),
              h16,
              TextBox(
                hint: "Enter Description",
                controller: grpCnt.groupblogDesc.value,
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
                        await grpCnt.pickImage();
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
              if (grpCnt.path != null) h4,
              if (grpCnt.path != null)
                Text("${grpCnt.path!.path.toString().split("/").last}"),
              h30,
              LargeButton(
                onPressed: () async {
                  if (createGroupBlogKey.currentState!.validate()) {
                    await grpCnt.addGroupBlog();
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
