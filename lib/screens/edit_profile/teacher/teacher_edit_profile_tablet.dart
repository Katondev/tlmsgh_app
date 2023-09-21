// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/edit_profile/controller/teacher_edit_profile_cnt.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/svgIcon.dart';
import 'package:katon/widgets/textfiled_with_title.dart';
import '../../../components/app_text_style.dart';
import '../../../components/image/image_widget.dart';
import '../../../models/sign_in_model.dart';
import '../../../models/teacher_sign_in_model.dart';
import '../../../res.dart';
import '../../../utils/validators.dart';
import '../../../widgets/dropdown.dart';
import '../widgets/custom_textFileds.dart';

class TeacherEditProfileTablet extends StatefulWidget {
  final Arguments arguments;
  final String title;

  const TeacherEditProfileTablet(
      {Key? key, required this.arguments, required this.title})
      : super(key: key);

  @override
  State<TeacherEditProfileTablet> createState() =>
      _TeacherEditProfileTabletState();
}

class _TeacherEditProfileTabletState extends State<TeacherEditProfileTablet> {
  final cnt = Get.put(TeacherEditProfileCnt());
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          // endDrawer: endDrawer(),
          body: Obx(
            () => Container(
              padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile",
                      style: AppTextStyle.normalBold28.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    customHeight(35),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.boxgreyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.fromLTRB(60, 48, 60,
                            MediaQuery.of(context).viewInsets.bottom),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
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
                                        padding: const EdgeInsets.fromLTRB(
                                            24, 12, 0, 12),
                                        child: Text(
                                          "Edit Profile",
                                          style: AppTextStyle.normalSemiBold15
                                              .copyWith(
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
                                      padding: const EdgeInsets.fromLTRB(
                                          100, 40, 100, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          h18,
                                          //! Circle Avatar
                                          Align(
                                            alignment: Alignment.center,
                                            child: Stack(
                                              children: [
                                                // Container(
                                                //   height: 80,
                                                //   width: 80,
                                                //   alignment: Alignment.center,
                                                //   decoration: BoxDecoration(
                                                //     shape: BoxShape.circle,
                                                //     color: AppColors.avatarColor,
                                                //   ),
                                                //   child:
                                                NetworkImageWidget(
                                                  height: 80,
                                                  width: 80,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  imageUrl:
                                                      "${ApiRoutes.imageURL}${cnt.image!.value}",
                                                  fit: BoxFit.cover,
                                                ),
                                                // ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      cnt.getFromGallery();
                                                    },
                                                    child: Container(
                                                      height: 27,
                                                      width: 27,
                                                      padding:
                                                          EdgeInsets.all(7),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors
                                                            .primaryBlack
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
                                          TextfieldwithTitle(
                                            isrequired: true,
                                            hint: "full_name".tr,
                                            title: 'full_name'.tr,
                                            controller: cnt.fullName.value,
                                            onChanged: (value) {
                                              cnt.checkColor();
                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                            },
                                          ),
                                          h12,
                                          TextfieldwithTitle(
                                            hint: "email_id".tr,
                                            title: 'email_id'.tr,
                                            isrequired: true,
                                            controller: cnt.emailCnt.value,
                                            validator: (value) {
                                              String pattern =
                                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]+.com"
                                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                                  r"{0,253}[a-zA-Z0-9])?)*$";
                                              RegExp regex = RegExp(pattern);
                                              if (!regex.hasMatch(value!)) {
                                                return 'valid_email'.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                            copyOnTap: () {
                                              FocusScope.of(context).unfocus();
                                              if (cnt.emailCnt.value.text !=
                                                  "") {
                                                Clipboard.setData(ClipboardData(
                                                    text: cnt
                                                        .emailCnt.value.text));

                                                SnackBarService().showSnackBar(
                                                  message:
                                                      "copy_successfully".tr,
                                                  type: SnackBarType.success,
                                                );
                                              } else {
                                                SnackBarService().showSnackBar(
                                                  message:
                                                      "please_enter_email".tr,
                                                  type: SnackBarType.error,
                                                );
                                              }
                                            },
                                            icon: SvgIcon(Images.copy),
                                            onChanged: (value) {
                                              cnt.checkColor();
                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                            },
                                          ),
                                          h12,
                                          TextfieldwithTitle(
                                            onChanged: (value) {
                                              cnt.checkColor();
                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                            },
                                            isrequired: true,
                                            hint: "enter_alternative_email".tr,
                                            title: 'alternative_email'.tr,
                                            trailingTitle:
                                                "alternative_email_ideal".tr,
                                            controller: cnt.altemailCnt.value,
                                            copyOnTap: () {
                                              FocusScope.of(context).unfocus();
                                              if (cnt.altemailCnt.value.text !=
                                                  "") {
                                                Clipboard.setData(ClipboardData(
                                                    text: cnt.altemailCnt.value
                                                        .text));

                                                SnackBarService().showSnackBar(
                                                  message:
                                                      "copy_successfully".tr,
                                                  type: SnackBarType.success,
                                                );
                                              } else {
                                                SnackBarService().showSnackBar(
                                                  message:
                                                      "please_enter_email".tr,
                                                  type: SnackBarType.error,
                                                );
                                              }
                                            },
                                            icon: SvgIcon(Images.copy),
                                          ),
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
                                                      style: AppTextStyle
                                                          .normalBold12
                                                          .copyWith(
                                                        color: AppColors
                                                            .primaryBlack,
                                                      ),
                                                    ),
                                                    h10,
                                                    DropDown(
                                                      dropDowns:
                                                          cnt.countryCodeList,
                                                      selectedValue: cnt
                                                              .countrycode
                                                              .value
                                                              .isEmpty
                                                          ? null
                                                          : cnt.countrycode
                                                              .value,
                                                      onChange: (value) {
                                                        cnt.countrycode.value =
                                                            value ?? "";
                                                        if (!cnt.textChanged
                                                            .value) {
                                                          cnt.textChanged
                                                              .value = true;
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
                                                      if (!cnt
                                                          .textChanged.value) {
                                                        cnt.textChanged.value =
                                                            true;
                                                      }
                                                      cnt.checkColor();
                                                    },
                                                    validator: (value) =>
                                                        Validators
                                                            .validateMobile(
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

                                          TextfieldwithTitle(
                                            hint: "enter_also_known_as".tr,
                                            title: 'also_known_as'.tr,
                                            keyboardType: TextInputType.text,
                                            controller: cnt.knownasCnt.value,
                                            onChanged: (value) {
                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                              cnt.checkColor();
                                            },
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
                                                          'certificates'.tr,
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
                                                            color: AppColors
                                                                .appbarRed,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    h10,
                                                    DropDownCustom<
                                                        CertificatesList>(
                                                      validator: (value) {
                                                        if (value!
                                                            .value!.isEmpty) {
                                                          return "require_schoolname"
                                                              .tr;
                                                        }
                                                        return null;
                                                      },
                                                      onChange: (value) async {
                                                        cnt.selectedCertificateVal
                                                            .value = value!;
                                                        if (!cnt.textChanged
                                                            .value) {
                                                          cnt.textChanged
                                                              .value = true;
                                                        }
                                                        cnt.checkColor();
                                                      },
                                                      selectedValue: cnt
                                                                  .selectedCertificateVal
                                                                  .value
                                                                  .value ==
                                                              null
                                                          ? null
                                                          : cnt
                                                              .selectedCertificateVal,
                                                      items: cnt.certificateList
                                                          .map(
                                                            (e) => DropdownMenuItem<
                                                                CertificatesList>(
                                                              value: e,
                                                              child: Text(
                                                                "${e.value}",
                                                                style: AppTextStyle
                                                                    .normalRegular12,
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              w20,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'years_of_experience'
                                                              .tr,
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
                                                            color: AppColors
                                                                .appbarRed,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    h10,
                                                    DropDownCustom<String>(
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "require_years_of_exp"
                                                              .tr;
                                                        }
                                                        return null;
                                                      },
                                                      onChange: (value) async {
                                                        cnt.yearsofExpVal
                                                            .value = value!;
                                                        if (!cnt.textChanged
                                                            .value) {
                                                          cnt.textChanged
                                                              .value = true;
                                                        }
                                                        cnt.checkColor();
                                                      },
                                                      selectedValue: cnt
                                                                  .yearsofExpVal
                                                                  .value ==
                                                              ""
                                                          ? null
                                                          : cnt.yearsofExpVal,
                                                      items: cnt.yearsofExpList
                                                          .map(
                                                            (e) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                              value: e,
                                                              child: Text(
                                                                "${e}",
                                                                style: AppTextStyle
                                                                    .normalRegular12
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .black),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ],
                                                ),
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
                                                    TextfieldwithTitle(
                                                      hint: 'enter_staff_id'.tr,
                                                      title: "staff_id".tr,
                                                      isrequired: true,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          cnt.staffidCnt.value,
                                                      validator: (val) {
                                                        if (val!.isEmpty) {
                                                          return "require_staff_id"
                                                              .tr;
                                                        }
                                                        return null;
                                                      },
                                                      onChanged: (value) {
                                                        if (!cnt.textChanged
                                                            .value) {
                                                          cnt.textChanged
                                                              .value = true;
                                                        }
                                                        cnt.checkColor();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              w20,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    h5,
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'level'.tr,
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
                                                                  color: AppColors
                                                                      .appbarRed),
                                                        ),
                                                      ],
                                                    ),
                                                    h10,
                                                    DropDownCustom<
                                                        CertificatesList>(
                                                      validator: (value) {
                                                        if (value!
                                                            .value!.isEmpty) {
                                                          return "require_level"
                                                              .tr;
                                                        }
                                                        return null;
                                                      },
                                                      onChange: (value) async {
                                                        cnt.selectedLevelVal
                                                            .value = value!;
                                                        if (!cnt.textChanged
                                                            .value) {
                                                          cnt.textChanged
                                                              .value = true;
                                                        }
                                                        cnt.checkColor();
                                                      },
                                                      selectedValue: cnt
                                                                  .selectedLevelVal
                                                                  .value
                                                                  .value ==
                                                              null
                                                          ? null
                                                          : cnt
                                                              .selectedLevelVal,
                                                      items: cnt.levelList
                                                          .map(
                                                            (e) => DropdownMenuItem<
                                                                CertificatesList>(
                                                              value: e,
                                                              child: Text(
                                                                "${e.value}",
                                                                style: AppTextStyle
                                                                    .normalRegular12
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .primaryBlack),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          h12,
                                          Row(
                                            children: [
                                              Text('region_district'.tr,
                                                  style: AppTextStyle
                                                      .normalBold12
                                                      .copyWith(
                                                    color:
                                                        AppColors.primaryBlack,
                                                  )),
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
                                          h10,
                                          DropDownCustom<DropdownRegion>(
                                            selectedValue: cnt.regionValue.value
                                                        .district ==
                                                    null
                                                ? null
                                                : cnt.regionValue,
                                            items: cnt.regionList
                                                .map((e) => DropdownMenuItem<
                                                        DropdownRegion>(
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
                                            // hint: Text(""),
                                            validator: (value) {
                                              if (value!.district!.isEmpty) {
                                                return "require_region_district"
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            onChange: (value) async {
                                              cnt.regionValue.value = value!;

                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                              cnt.checkColor();
                                              log("message");
                                              cnt.selectedSchoolValue.value =
                                                  DropdownSchoolTeacher();
                                              cnt.schoolList.clear();

                                              await cnt.getAllschoolData(
                                                  region:
                                                      value.region.toString(),
                                                  district: value.district
                                                      .toString());
                                            },
                                          ),
                                          h12,
                                          Row(
                                            children: [
                                              Text('school_name'.tr,
                                                  style: AppTextStyle
                                                      .normalBold12
                                                      .copyWith(
                                                    color:
                                                        AppColors.primaryBlack,
                                                  )),
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

                                          h10,
                                          DropDownCustom<DropdownSchoolTeacher>(
                                            selectedValue: cnt
                                                        .selectedSchoolValue
                                                        .value
                                                        .tcSchoolId ==
                                                    null
                                                ? null
                                                : cnt.selectedSchoolValue,
                                            items: cnt.schoolList
                                                .map(
                                                  (e) => DropdownMenuItem<
                                                      DropdownSchoolTeacher>(
                                                    value: e,
                                                    child: Text(
                                                      "${e.tcSchoolName}",
                                                      style: AppTextStyle
                                                          .normalRegular12,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            validator: (value) {
                                              if (value!
                                                  .tcSchoolName!.isEmpty) {
                                                return "require_schoolname".tr;
                                              }
                                              return null;
                                            },
                                            onChange: (value) async {
                                              cnt.selectedSchoolValue.value =
                                                  value!;

                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                              cnt.checkColor();
                                            },
                                          ),
                                          h12,
                                          Row(
                                            children: [
                                              Text('languages_spoken'.tr,
                                                  style: AppTextStyle
                                                      .normalBold12
                                                      .copyWith(
                                                    color:
                                                        AppColors.primaryBlack,
                                                  )),
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

                                          h10,
                                          DropDownCustom<CertificatesList>(
                                            selectedValue: cnt
                                                        .selectedlanguageVal
                                                        .value
                                                        .value ==
                                                    null
                                                ? null
                                                : cnt.selectedlanguageVal,
                                            items: cnt.languageList
                                                .map(
                                                  (e) => DropdownMenuItem<
                                                      CertificatesList>(
                                                    value: e,
                                                    child: Text(
                                                      "${e.value}",
                                                      style: AppTextStyle
                                                          .normalRegular12,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            validator: (value) {
                                              if (value!.value!.isEmpty) {
                                                return "require_language".tr;
                                              }
                                              return null;
                                            },
                                            onChange: (value) async {
                                              cnt.selectedlanguageVal.value =
                                                  value!;

                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                              cnt.checkColor();
                                            },
                                          ),
                                          //!

                                          h10,
                                          TextfieldwithTitle(
                                            ismaxline: true,
                                            hint: "enter_brief_profile".tr,
                                            title: 'brief_profile'.tr,
                                            isrequired: true,
                                            maxLines: 5,
                                            keyboardType: TextInputType.text,
                                            controller: cnt.briefproCnt.value,
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return "require_brief_profile"
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                              cnt.checkColor();
                                            },
                                          ),
                                          h16,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Obx(
                                                  () => LargeButton(
                                                      height: 45,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          cnt.textChanged
                                                                  .value
                                                              ? cnt.buttonColor
                                                                  ?.value
                                                              : AppColors
                                                                  .gray300,
                                                      onPressed:
                                                          (cnt.checkColor())
                                                              ? () async {
                                                                  // print(">>>>${widget.title}");
                                                                  if (formkey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    if (cnt.imageFile !=
                                                                        null) {
                                                                      cnt.updateProfilePic();
                                                                    }
                                                                    await cnt
                                                                        .teacherUpdateProfile()
                                                                        .then(
                                                                            (value) {
                                                                      if (AppPreference()
                                                                              .getInt(PreferencesKey.isLoggedInFirstTimeT) !=
                                                                          1) {
                                                                        Future.delayed(
                                                                            Duration(milliseconds: 100),
                                                                            () {
                                                                          cnt.showFirstTimeEditCompleteDialog(
                                                                              context);
                                                                        });
                                                                      }
                                                                      cnt.checkColor();
                                                                    });
                                                                    primaryFocus
                                                                        ?.unfocus();
                                                                  } else {
                                                                    // print("else called");
                                                                    await cnt
                                                                        .parentUpdateProfile();
                                                                  }
                                                                  cnt.checkColor();
                                                                }
                                                              : () {},
                                                      child: Text(
                                                        "save_changes".tr,
                                                        style: AppTextStyle
                                                            .normalBold14,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                          h50,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
