import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/models/teacher_sign_in_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/message/message_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/dropdown.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/svgIcon.dart';
import 'package:provider/provider.dart';

import '../components/app_text_style.dart';
import '../models/filter_category_model/filter_category_model.dart';
import '../models/snackbar_datamodel.dart';
import '../screens/self_assessment/self_assesment_controller.dart';
import '../services/snackbar_service.dart';

AppBar commonAppBar({
  required String title,
  String? description,
  bool? drawer,
  PreferredSizeWidget? bottom,
  Function()? onPressed,
  bool? backIcon = false,
  bool? closeButton = false,
}) {
  return AppBar(
    shape: RoundedRectangleBorder(borderRadius: onlyTopLeft42),
    bottom: bottom,
    shadowColor: AppColors.shadowColor.withOpacity(0.25),
    titleSpacing: backIcon ?? false ? -0 : -22,
    toolbarHeight: 70,
    centerTitle: false,
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => TextButton(
        onPressed: drawer ?? false
            ? () => Scaffold.of(context).openDrawer()
            : onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith(
              (states) => const Color(0xffE0E0E0)),
        ),
        child: drawer ?? false
            ? const Icon(Icons.menu, color: AppColors.white)
            : Padding(
                padding: r100,
                child: backIcon ?? false
                    ? InkWell(
                        onTap: onPressed,
                        child: const Icon(Icons.arrow_back_ios_rounded,
                            color: AppColors.black),
                      )
                    : null),
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: FontStyleUtilities.h4(fontWeight: FWT.semiBold)),
        Text("$description",
            style: FontStyleUtilities.t2(fontColor: AppColors.grey500))
      ],
    ),
    actions: closeButton ?? false
        ? [
            Padding(
                padding: all14,
                child: LargeButton(
                    width: 120,
                    onPressed: () => Navigator.of(Get.context!).pop(),
                    child: Text("close".tr,
                        style: FontStyleUtilities.h5(
                            fontWeight: FWT.semiBold,
                            fontColor: AppColors.white)))),
          ]
        : [AppBarAction()],
  );
}

class AppBarAction extends StatelessWidget {
  AppBarAction({Key? key}) : super(key: key);
  final cnt = Get.put(AppBarCnt());
  final messageCnt = Get.put(MessageCnt());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (!AppPreference().isTeacherLogin)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(cnt.student.stFullName ?? "",
                      style: FontStyleUtilities.h4(fontWeight: FWT.medium)
                          .copyWith(fontSize: 20.sp)),
                  const SizedBox(height: 4.0),
                  Text(
                      "${"primary".tr} ${"roll_no".tr} ${cnt.student.stId ?? ""}",
                      style:
                          FontStyleUtilities.t2(fontColor: AppColors.primary)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(cnt.teacher.tcFullName ?? "",
                      style: FontStyleUtilities.h4(fontWeight: FWT.medium)
                          .copyWith(fontSize: 20.sp)),
                  const SizedBox(height: 4.0),
                  Text("${"roll_no".tr} ${cnt.teacher.tcId ?? ""}",
                      style:
                          FontStyleUtilities.t2(fontColor: AppColors.primary)),
                ],
              ),
        w12,
        (!AppPreference().isTeacherLogin)
            ? ClipRRect(
                borderRadius: cr50,
                child: CachedNetworkImage(
                  height: 45,
                  width: 45,
                  fit: BoxFit.cover,
                  imageUrl: cnt.student.stProfilePic == ""
                      ? "https://img.freepik.com/free-photo/young-attractive-smiling-student-showing-thumb-up-outdoors-campus-university_8353-6394.jpg?w=2000"
                      : ApiRoutes.imageURL +
                          cnt.student.stProfilePic.toString(),
                  errorWidget: (context, url, error) => Image.asset(
                      Images.walkThrough,
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover),
                ),
              )
            : ClipRRect(
                borderRadius: cr50,
                child: CachedNetworkImage(
                  height: 45,
                  width: 45,
                  fit: BoxFit.cover,
                  imageUrl: cnt.teacher.tcProfilePic == ""
                      ? "https://img.freepik.com/free-photo/young-attractive-smiling-student-showing-thumb-up-outdoors-campus-university_8353-6394.jpg?w=2000"
                      : ApiRoutes.imageURL +
                          cnt.teacher.tcProfilePic.toString(),
                  errorWidget: (context, url, error) => Image.asset(
                      Images.walkThrough,
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover),
                ),
              ),
        w32,
        if (!AppPreference().isTeacherLogin)
          Obx(
            () => InkWell(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 48,
                    child: SvgIcon(Images.mail),
                  ),
                  Positioned(
                    top: 23,
                    right: 28,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: AppColors.appbarRed,
                      child: Text(
                        "${messageCnt.messageCount.value}",
                        style: FontStyleUtilities.t4(
                          fontColor: AppColors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        w22
      ],
    );
  }
}

class AppBarCnt extends GetxController {
  Student student = Student();
  Teacher teacher = Teacher();

  RxBool isLoading = false.obs;

  void getStudentInfo() async {
    isLoading.value = true;
    try {
      Map<String, dynamic> userData =
          jsonDecode(AppPreference().getString(PreferencesKey.studentData));

      student = Student.fromJson(userData['data']['student']);
    } catch (e) {
      student = Student();
    }
    isLoading.value = false;
  }

  void getTeacherInfo() async {
    isLoading.value = true;
    try {
      Map<String, dynamic> userData =
          jsonDecode(AppPreference().getString(PreferencesKey.teacherData));

      teacher = Teacher.fromJson(userData['data']['teacher']);
    } catch (e) {
      teacher = Teacher();
    }
    isLoading.value = false;
  }
}

AppBar CommonAppbarMobile({
  required String title,
  bool? closeButton = false,
  bool? backButton,
}) {
  return AppBar(
    title: Text(
      title,
      style: FontStyleUtilities.h4(
        fontWeight: FWT.semiBold,
      ),
    ),
    automaticallyImplyLeading: backButton ?? true,
    centerTitle: backButton ?? true,
    // actions: closeButton ?? false
    //     ? [
    //         Padding(
    //           padding: all8,
    //           child: LargeButton(
    //             width: 80,
    //             height: 40,
    //             onPressed: () => Navigator.of(Get.context!).pop(),
    //             child: Text(
    //               "close".tr,
    //               style: FontStyleUtilities.h5(
    //                 fontWeight: FWT.medium,
    //                 fontColor: AppColors.white,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ]
    // : [AppBarActionMobile()],
  );
}

class AppBarActionMobile extends StatelessWidget {
  AppBarActionMobile({Key? key}) : super(key: key);
  final messageCnt = Get.put(MessageCnt());
  RxString? readValue = ''.obs;
  RxInt? messageCount;

  @override
  Widget build(BuildContext context) {
    return !AppPreference().isTeacherLogin
        ? Obx(
            () => Center(
              child: InkWell(
                onTap: () async {
                  Scaffold.of(context).openEndDrawer();
                  readValue!.value =
                      await AppPreference().getString('isMessageRead');
                  // messageCount!.value = await AppPreference().getInt('isMessageRead');
                },
                child: Stack(
                  children: [
                    Builder(
                      builder: (context) {
                        return Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: 48,
                          child: SvgIcon(
                            Images.mail,
                            width: 28,
                          ),
                        );
                      },
                    ),
                    if (readValue!.value == 'true')
                      Positioned(
                        top: 23,
                        right: 28,
                        child: CircleAvatar(
                          radius: 9,
                          backgroundColor: AppColors.appbarRed,
                          child: Text(
                            "${messageCnt.messageCount}",
                            style: FontStyleUtilities.t4(
                              fontColor: AppColors.white,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          )
        : SizedBox.shrink();
  }
}

class CommonAppBar2 extends StatelessWidget {
  final bool? isshowback;
  final String? title;
  final String? description;

  const CommonAppBar2(
      {super.key, this.title, this.description, this.isshowback = false});

  @override
  Widget build(BuildContext context) {
    final ePrv = Provider.of<SelfAssessmentController>(context);
    return (Responsive.isMobilenew(context))
        ? Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (isshowback!)
                      ? GestureDetector(
                          onTap: () {
                            // log("message");
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 37,
                            width: 40,
                            color: AppColors.transparentColor,
                            padding: EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                            ),
                          ),
                        )
                      : SizedBox(),
                  // customWidth(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (title != null)
                          ? Text(
                              "${title}",
                              style: AppTextStyle.normalBold26.copyWith(
                                color: AppColors.black,
                              ),
                            )
                          : SizedBox(),
                      // h4,
                      (description != null)
                          ? Text(
                              "${description}",
                              style: AppTextStyle.normalRegular15.copyWith(
                                color: AppColors.textgrey,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  
                ],
              ),
            ],
          )
        : Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (isshowback!)
                      ? GestureDetector(
                          onTap: () {
                            // log("message");
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 45,
                            padding: EdgeInsets.only(right: 15),
                            color: AppColors.transparentColor,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                            ),
                          ),
                        )
                      : SizedBox(),
                  // (isshowback!) ? customWidth(10) : SizedBox(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (title != null)
                          ? Text(
                              "${title}",
                              style: AppTextStyle.normalBold28.copyWith(
                                color: AppColors.black,
                              ),
                            )
                          : SizedBox(),
                      // h4,
                      (description != null)
                          ? Text(
                              "${description}",
                              style: AppTextStyle.normalRegular16.copyWith(
                                color: AppColors.textgrey,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(width: 40,),
                  
                                 title == "Self Assessment"? Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: DropDownCustom<FilterCategoryModel>(
                          onChange: (value) =>
                              ePrv.selectMainCategory(value: value),
                          //  ePrv.mainCategoryMList.any((r) => r.categoryId==ePrv.selectedMainCat?.value.categoryId)?
                          selectedValue:
                              ePrv.selectedMainCat.value.categoryId == null
                                  ? null
                                  : ePrv.selectedMainCat,
                          items: ePrv.mainCategoryMList
                              .map((e) => DropdownMenuItem<FilterCategoryModel>(
                                  enabled: e.isenabled ?? true,
                                  value: e,
                                  child: Text(
                                    "${e.isenabled ?? false ? e.categoryName : e.maincategoryName}",
                                    style: e.isenabled ?? false
                                        ? AppTextStyle.normalRegular12
                                        : AppTextStyle.normalRegular12
                                            .copyWith(color: Colors.black54),
                                  )))
                              .toList(),
                          hint: Text(
                            "Class/Garde",
                            style: AppTextStyle.normalRegular12,
                          ),
                        ),
                      ),
                      w10,
                      SizedBox(
                        width: 200,
                        child: DropDownCustom<Subject>(
                          onChange: (value) => ePrv.selectSubject(value: value),
                          selectedValue:
                              ePrv.selectedSubject.value.label == null
                                  ? null
                                  : ePrv.selectedSubject,
                          items: ePrv.subjectList
                              .map((e) => DropdownMenuItem<Subject>(
                                  value: e,
                                  child: Text("${e.label}",
                                      style: AppTextStyle.normalRegular12)))
                              .toList(),
                          hint: Text(
                            "Select Subject",
                            style: AppTextStyle.normalRegular12,
                          ),
                        ),
                      ),
                      w10,
                      LargeButton(
                        height: 40,
                        width: 100,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          if (ePrv.selectedMainCat.value.categoryName ==
                              "Class/Grade") {
                            SnackBarService().showSnackBar(
                                message: "Select Class/Grade",
                                type: SnackBarType.error);
                          } else if (ePrv.selectedSubject.value ==
                              "Select Subject") {
                            SnackBarService().showSnackBar(
                                message: "Select Subject",
                                type: SnackBarType.error);
                          } else {
                            ePrv.generatePaperApi(context);
                          }
                        },
                        child: Text("Generate Paper"),
                      ),
                    ],
                  ):SizedBox(width: MediaQuery.of(context).size.width /5,)
                ],
              ),
            ],
          );
  }
}
