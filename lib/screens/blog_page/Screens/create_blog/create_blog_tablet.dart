import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/widgets/text_field.dart';
import '../../../../models/argument_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/font_style.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_container.dart';
import '../../controller/blog_controller.dart';

class CreateBlogTablet extends StatefulWidget {
  final Arguments arguments;
  const CreateBlogTablet({super.key, required this.arguments});

  @override
  State<CreateBlogTablet> createState() => _CreateBlogTabletState();
}

class _CreateBlogTabletState extends State<CreateBlogTablet> {
  final blgCnt = Get.find<BlogController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: endDrawer(),
      backgroundColor: Colors.white,
      appBar: commonAppBar(
        onPressed: () => Navigator.pop(context),
        backIcon: true,
        // title: widget.arguments.title,
        title: "${widget.arguments.title}",
        description: widget.arguments.description,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          // padding: EdgeInsets.all(20),
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 600,
                    child: TextBox(
                      hint: "Enter Blog Title",
                      fillColor: AppColors.boxgrey,
                    ),
                  ),
                  h16,
                  SizedBox(
                    width: 600,
                    child: TextBox(
                      hint: "Enter Description",
                      maxLines: 5,
                      fillColor: AppColors.boxgrey,
                    ),
                  ),
                  h16,
                  Container(
                    height: 50,
                    width: 600,
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
                    Text(
                        "${blgCnt.path.toString().replaceAll("'", "").split("/").last}"),
                  h30,
                  LargeButton(
                    onPressed: () {},
                    height: 50,
                    width: 600,
                    child: Text(
                      "submit".tr,
                      style: FontStyleUtilities.t1(
                          fontWeight: FWT.medium, fontColor: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
