import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/components/image/image_widget.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/sign_in_model.dart';

import 'package:katon/network/api_constants.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/edit_profile/controller/edit_profile_cnt.dart';
import 'package:katon/screens/edit_profile/widgets/common_widgets.dart';
import 'package:katon/screens/edit_profile/widgets/custom_textFileds.dart';
import 'package:katon/widgets/common_container.dart';

import '../../../teacher/drawer.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/font_style.dart';
import '../../../utils/prefs/app_preference.dart';
import '../../../utils/validators.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/drawer/drawer.dart';
import '../../../widgets/dropdown.dart';
import '../../../widgets/textfiled_with_title.dart';
import '../../home_page.dart';

class EditProfileMobilePage extends StatefulWidget {
  final Arguments arguments;
  final String title;

  const EditProfileMobilePage(
      {Key? key, required this.arguments, required this.title})
      : super(key: key);

  @override
  State<EditProfileMobilePage> createState() => _EditProfileMobilePageState();
}

class _EditProfileMobilePageState extends State<EditProfileMobilePage> {
  final cnt = Get.find<EditProfileCnt>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.boxgreyColor,
      // endDrawer: endDrawer(),
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      appBar: CommonAppbarMobile(title: widget.arguments.title),
      body: Obx(
        () => Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Profile",
              //   style: AppTextStyle.normalBold28.copyWith(
              //     color: AppColors.black,
              //   ),
              // ),
              customHeight(15),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Form(
                        key: cnt.formKey,
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 12, 0, 12),
                                  child: Text(
                                    "Edit Profile",
                                    style:
                                        AppTextStyle.normalSemiBold15.copyWith(
                                      color: AppColors.primaryBlack,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: AppColors.dividerColor,
                                thickness: 2,
                                height: 0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    h18,
                                    //! Circle Avatar
                                    Align(
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                            cnt.image1 != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.file(
                                                      height: 80,
                                                      width: 80,
                                                      fit: BoxFit.cover,
                                                      File(cnt.image1!.path)),
                                                )
                                              :
                                          NetworkImageWidget(
                                            height: 80,
                                            width: 80,
                                            imageUrl:
                                                "${ApiRoutes.imageURL+cnt.image!.value}",
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                  cnt.getImage();
                                              },
                                              child: Container(
                                                height: 27,
                                                width: 27,
                                                padding: EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.primaryBlack
                                                      .withOpacity(.7),
                                                ),
                                                child: Image.asset(
                                                  AppAssets.ic_add_image,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    h12,
                                    CustomTextFiledS(),
                                    h12,

                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              h5,
                                              Text(
                                                'country_code'.tr,
                                                style: AppTextStyle.normalBold12
                                                    .copyWith(
                                                  color: AppColors.primaryBlack,
                                                ),
                                              ),
                                              h10,
                                              DropDown(
                                                dropDowns: cnt.countryCodeList,
                                                selectedValue: cnt.countrycode
                                                        .value.isEmpty
                                                    ? null
                                                    : cnt.countrycode.value,
                                                onChange: (value) {
                                                  cnt.countrycode.value =
                                                      value ?? "";
                                                  if (!cnt.textChanged.value) {
                                                    cnt.textChanged.value =
                                                        true;
                                                  }
                                                  cnt.checkColor();
                                                },
                                                hint: Text(
                                                  "Select country code",
                                                  style: AppTextStyle
                                                      .normalRegular12,
                                                ),
                                                // validator: (value) {
                                                //   if (value!.isEmpty) {
                                                //     return "require_division"
                                                //         .tr;
                                                //   }
                                                //   return null;
                                                // },
                                              ),
                                            ],
                                          ),
                                        ),
                                        w20,
                                        Expanded(
                                          child: TextfieldwithTitle(
                                              onChanged: (value) {
                                                if (!cnt.textChanged.value) {
                                                  cnt.textChanged.value = true;
                                                }
                                                cnt.checkColor();
                                              },
                                              validator: (value) =>
                                                  Validators.validateMobile(
                                                      value),
                                              hint: "Mobile_number".tr,
                                              title: 'Mobile_number'.tr,
                                              isrequired: true,
                                              keyboardType:
                                                  TextInputType.number,
                                              controller:
                                                  cnt.mobileNumber.value),
                                        ),
                                      ],
                                    ),
                                    h12,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'class'.tr,
                                                    style: AppTextStyle
                                                        .normalBold12
                                                        .copyWith(
                                                      color: AppColors
                                                          .primaryBlack,
                                                    ),
                                                  ),
                                                  w4,
                                                  Text(
                                                    "*",
                                                    style: AppTextStyle
                                                        .normalBold12
                                                        .copyWith(
                                                      color:
                                                          AppColors.appbarRed,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              h8,
                                              DropDownCustom<DropdownClasses>(
                                                onChange: (value) {
                                                  print(value!.level);
                                                  print(
                                                      "                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ${value?.level}");
                                                  cnt.classValue.value = value!;
                                                  if (!cnt.textChanged.value) {
                                                    cnt.textChanged.value =
                                                        true;
                                                  }
                                                  cnt.checkColor();
                                                },
                                                validator: (value) {
                                                  if (value!.label!.isEmpty) {
                                                    return "require_class".tr;
                                                  }
                                                  return null;
                                                },
                                                selectedValue: (cnt.classValue
                                                            .value.label ==
                                                        null)
                                                    ? null
                                                    : cnt.classValue,
                                                items: cnt.classList
                                                    .map((e) =>
                                                        DropdownMenuItem<
                                                                DropdownClasses>(
                                                            enabled: e.enable ??
                                                                false,
                                                            value: e,
                                                            child: Text(
                                                              "${e.label}",
                                                              style: e.enable!
                                                                  ? AppTextStyle
                                                                      .normalRegular12
                                                                  : AppTextStyle
                                                                      .normalRegular12
                                                                      .copyWith(
                                                                          color: const Color.fromARGB(
                                                                              137,
                                                                              43,
                                                                              19,
                                                                              19)),
                                                            )))
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        w10,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'division'.tr,
                                                    style: AppTextStyle
                                                        .normalBold12
                                                        .copyWith(
                                                      color: AppColors
                                                          .primaryBlack,
                                                    ),
                                                  ),
                                                  w4,
                                                  Text(
                                                    "*",
                                                    style: AppTextStyle
                                                        .normalBold12
                                                        .copyWith(
                                                      color:
                                                          AppColors.appbarRed,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              h8,
                                              DropDown(
                                                dropDowns: cnt.divisionList,
                                                selectedValue: cnt
                                                        .divisionNumber
                                                        .value
                                                        .isEmpty
                                                    ? null
                                                    : cnt.divisionNumber.value,
                                                onChange: (value) {
                                                  cnt.divisionNumber.value =
                                                      value ?? "";
                                                  if (!cnt.textChanged.value) {
                                                    cnt.textChanged.value =
                                                        true;
                                                  }
                                                  cnt.checkColor();
                                                },
                                                hint: Text(
                                                  "Select division",
                                                  style: AppTextStyle
                                                      .normalRegular12,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "require_division"
                                                        .tr;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    h12,

                                    Row(
                                      children: [
                                        Text(
                                          'region_district'.tr,
                                          style: AppTextStyle.normalBold12
                                              .copyWith(
                                            color: AppColors.primaryBlack,
                                          ),
                                        ),
                                        w4,
                                        Text(
                                          "*",
                                          style: AppTextStyle.normalBold12
                                              .copyWith(
                                            color: AppColors.appbarRed,
                                          ),
                                        ),
                                      ],
                                    ),
                                    h8,
                                    DropDownCustom<DropdownRegion>(
                                      validator: (value) {
                                        if (value!.district!.isEmpty) {
                                          return "require_region_district".tr;
                                        }
                                        return null;
                                      },
                                      onChange: (value) async {
                                        cnt.regionValue.value = value!;
                                        if (!cnt.textChanged.value) {
                                          cnt.textChanged.value = true;
                                        }
                                        cnt.checkColor();
                                        cnt.selectedSchoolValue.value =
                                            DropdownSchool();
                                        cnt.schoolList.clear();

                                        await cnt.getAllschoolData(
                                            region: value.region.toString(),
                                            district:
                                                value.district.toString());
                                      },
                                      selectedValue:
                                          cnt.regionValue.value.district == null
                                              ? null
                                              : cnt.regionValue,
                                      items: cnt.regionList
                                          .map((e) =>
                                              DropdownMenuItem<DropdownRegion>(
                                                  enabled: e.enable ?? true,
                                                  value: e,
                                                  child: Text(
                                                    "${e.district}",
                                                    style: e.enable!
                                                        ? AppTextStyle
                                                            .normalRegular12
                                                        : AppTextStyle
                                                            .normalRegular12
                                                            .copyWith(
                                                                color: Colors
                                                                    .black54),
                                                  )))
                                          .toList(),
                                    ),

                                    h12,
                                    Row(
                                      children: [
                                        Text(
                                          'school_name'.tr,
                                          style: AppTextStyle.normalBold12
                                              .copyWith(
                                            color: AppColors.primaryBlack,
                                          ),
                                        ),
                                        w4,
                                        Text(
                                          "*",
                                          style: AppTextStyle.normalBold12
                                              .copyWith(
                                            color: AppColors.appbarRed,
                                          ),
                                        ),
                                      ],
                                    ),
                                    h8,
                                    DropDownCustom<DropdownSchool>(
                                      hint: Text("${"select_school_name".tr}"),
                                      selectedValue: cnt.selectedSchoolValue
                                                  .value.scSchoolId ==
                                              null
                                          ? null
                                          : cnt.selectedSchoolValue,
                                      items: cnt.schoolList
                                          .map(
                                            (e) => DropdownMenuItem<
                                                DropdownSchool>(
                                              value: e,
                                              child: Text(
                                                "${e.scSchoolName}",
                                                style: AppTextStyle
                                                    .normalRegular12,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      validator: (value) {
                                        if (value!.scSchoolName!.isEmpty) {
                                          return "require_schoolname".tr;
                                        }
                                        return null;
                                      },
                                      onChange: (value) async {
                                        cnt.selectedSchoolValue.value = value!;
                                        if (!cnt.textChanged.value) {
                                          cnt.textChanged.value = true;
                                        }
                                        cnt.checkColor();
                                      },
                                    ),

                                    h46,
                                    // h40,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text("parent_details".tr,
                                              style: FontStyleUtilities.h6(
                                                  fontColor:
                                                      AppColors.grey500)),
                                        ),
                                        h25,
                                        TextfieldwithTitle(
                                            onChanged: (value) {
                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                              cnt.checkColor();
                                            },
                                            hint: "enter_parent_name".tr,
                                            title: 'parent_name'.tr,
                                            keyboardType: TextInputType.text,
                                            controller: cnt.parentName.value),
                                        h12,
                                        TextfieldwithTitle(
                                            onChanged: (value) {
                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                              cnt.checkColor();
                                            },
                                            validator: (value) =>
                                                Validators.validateParentMobile(
                                                    value),
                                            hint: "enter_parent_mobile".tr,
                                            title: 'parent_mobile'.tr,
                                            isrequired: true,
                                            keyboardType: TextInputType.number,
                                            controller:
                                                cnt.parentmobileNumber.value),
                                        h12,
                                        TextfieldwithTitle(
                                            onChanged: (value) {
                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                              cnt.checkColor();
                                            },
                                            hint: "enter_parent_email".tr,
                                            title: 'parent_email'.tr,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller: cnt.parentemail.value),
                                        h12,
                                      ],
                                    ),

                                    h48,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Obx(
                                          () => SaveChangesButton(
                                              width: 178.0,
                                              height: 44,
                                              isTextChanged:
                                                  cnt.textChanged.value),
                                        ),
                                      ],
                                    ),
                                    h48,
                                  ],
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
  }
}
