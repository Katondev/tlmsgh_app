import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/screens/auth/login/login_cnt.dart';
import 'package:katon/screens/auth/signup/signup_cnt.dart';
import 'package:katon/screens/auth/signup/widgets/dropdown_formfield_widget.dart';
import 'package:katon/utils/route_const.dart';

import '../../../models/argument_model.dart';
import '../../../models/sign_in_model.dart';
import '../../../utils/app_binding.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/font_style.dart';
import '../../../utils/validators.dart';
import '../../../widgets/app_webview/app_webview.dart';
import '../../../widgets/button.dart';
import '../../../widgets/svgIcon.dart';
import '../../../widgets/textfiled_with_title.dart';

class SignupMobilePage extends StatefulWidget {
  SignupMobilePage({Key? key}) : super(key: key);

  @override
  State<SignupMobilePage> createState() => _SignupMobilePageState();
}

class _SignupMobilePageState extends State<SignupMobilePage> {
  final cnt = Get.find<SignupCnt>();

  final logincnt = Get.find<LoginCnt>();

  GlobalKey<FormState> learnerKey = GlobalKey<FormState>();

  GlobalKey<FormState> teacherKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Positioned(
        bottom: 0,
        top: Get.height / 7,
        child: Container(
          // height: Get.height / 1.5,
          decoration: BoxDecoration(
            borderRadius: onlyTopLeftRight42,
            color: AppColors.white,
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("signup".tr,
                    style: FontStyleUtilities.h1(fontWeight: FWT.bold)
                        .copyWith(fontSize: 32)),
              ),
              h20,
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: all10,
                  decoration: BoxDecoration(
                    color: AppColors.blueType2,
                    borderRadius: cr24,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cnt.isteacher.value = true;
                              Get.find<LoginCnt>().radioIndex.value = 1;
                            },
                            child: Container(
                              // height: 40,
                              // width: 150,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              alignment: Alignment.center,

                              child: Column(
                                children: [
                                  Text(
                                    "Freelance Teacher",
                                    style: cnt.isteacher.value
                                        ? FontStyleUtilities.h5(
                                                fontColor: AppColors.white,
                                                fontWeight: FWT.semiBold)
                                            .copyWith(fontSize: 14)
                                        : FontStyleUtilities.h5(
                                                fontColor: AppColors.white)
                                            .copyWith(fontSize: 14),
                                  ),
                                  h6,
                                  (cnt.isteacher.value)
                                      ? Container(
                                          width: 50,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.white,
                                          ),
                                        )
                                      : SizedBox(
                                          height: 3,
                                        ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cnt.isteacher.value = false;
                              Get.find<LoginCnt>().radioIndex.value = 0;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    "Premium Learner",
                                    style: !cnt.isteacher.value
                                        ? FontStyleUtilities.h5(
                                                fontColor: AppColors.white,
                                                fontWeight: FWT.semiBold)
                                            .copyWith(fontSize: 14)
                                        : FontStyleUtilities.h5(
                                                fontColor: AppColors.white)
                                            .copyWith(fontSize: 14),
                                  ),
                                  h6,
                                  (!cnt.isteacher.value)
                                      ? Container(
                                          width: 50,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.white,
                                          ),
                                        )
                                      : SizedBox(
                                          height: 3,
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      h14,
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.white, borderRadius: cr24),
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 15, bottom: 15),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: (cnt.isteacher.value)
                                ? Form(
                                    key: teacherKey,
                                    child: Column(
                                      children: [
                                        TextFiledWithTitle(
                                          onChanged: (value) {
                                            if (!cnt.textChanged.value) {
                                              cnt.textChanged.value = true;
                                            }
                                            // cnt.checkColor();
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "signup_require_fullname"
                                                  .tr;
                                            }
                                            return null;
                                          },
                                          hint: "full_name".tr,
                                          title: 'full_name'.tr,
                                          isrequired: true,
                                          keyboardType: TextInputType.text,
                                          controller: cnt.tFullname.value,
                                          scrollPadding: true,
                                        ),
                                        h12,
                                        TextFiledWithTitle(
                                          onChanged: (value) {
                                            if (!cnt.textChanged.value) {
                                              cnt.textChanged.value = true;
                                            }
                                            // cnt.checkColor();
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "signup_require_email".tr;
                                            }
                                            return null;
                                          },
                                          hint: "email".tr,
                                          title: 'email'.tr,
                                          isrequired: true,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: cnt.tEmail.value,
                                          scrollPadding: true,
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
                                                  h2,
                                                  Text('country_code'.tr,
                                                      style:
                                                          FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .grey500)),
                                                  h8,
                                                  DropdownWidget(
                                                    value: cnt
                                                                .tSelectedcountrycode
                                                                .value
                                                                .countrycode ==
                                                            null
                                                        ? null
                                                        : cnt
                                                            .tSelectedcountrycode
                                                            .value,
                                                    items: cnt.countryCodeList
                                                        .map(
                                                          (e) => DropdownMenuItem<
                                                              DropdownCountrycode>(
                                                            // enabled: e.enable ?? true,
                                                            value: e,
                                                            child: Text(
                                                              e.countrycode
                                                                  .toString(),
                                                              style: FontStyleUtilities
                                                                      .h6()
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .black),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      cnt.tSelectedcountrycode
                                                          .value = value!;
                                                    },
                                                    hint: Text(
                                                      "country_code".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .gray400)
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            w20,
                                            Expanded(
                                              child: TextFiledWithTitle(
                                                onChanged: (value) {
                                                  if (!cnt.textChanged.value) {
                                                    cnt.textChanged.value =
                                                        true;
                                                  }
                                                  // cnt.checkColor();
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
                                                    cnt.tMobileNumber.value,
                                                scrollPadding: true,
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
                                                  Row(
                                                    children: [
                                                      Text('region_district'.tr,
                                                          style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .grey500)),
                                                      w4,
                                                      Text(
                                                        "*",
                                                        style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .appbarRed),
                                                      ),
                                                    ],
                                                  ),
                                                  h8,
                                                  DropdownWidget<
                                                      DropdownRegion>(
                                                    value: cnt
                                                                .tSelectedregion
                                                                .value
                                                                .district ==
                                                            null
                                                        ? null
                                                        : cnt.tSelectedregion
                                                            .value,
                                                    items: cnt.regionList
                                                        .map((e) =>
                                                            DropdownMenuItem<
                                                                    DropdownRegion>(
                                                                enabled:
                                                                    e.enable ??
                                                                        true,
                                                                value: e,
                                                                child: Text(
                                                                  "${e.district}",
                                                                  style: e.enable!
                                                                      ? FontStyleUtilities.h6().copyWith(
                                                                          color: AppColors
                                                                              .black)
                                                                      : FontStyleUtilities
                                                                              .t4()
                                                                          .copyWith(
                                                                              color: Colors.black54),
                                                                )))
                                                        .toList(),
                                                    onChanged: (value) async {
                                                      cnt.tSelectedregion
                                                          .value = value!;
                                                      //  cnt.checkColor();
                                                      if (!cnt
                                                          .textChanged.value) {
                                                        cnt.textChanged.value =
                                                            true;
                                                      }

                                                      cnt.tSelectedschool
                                                              .value =
                                                          DropdownSchoolTeacher();
                                                      cnt.schoolList.clear();

                                                      await cnt
                                                          .getAllschoolData(
                                                              region: value
                                                                  .region
                                                                  .toString(),
                                                              district: value
                                                                  .district
                                                                  .toString());
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "require_region_district"
                                                            .tr;
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      "region_district".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .gray400)
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
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
                                                      Text('school_name'.tr,
                                                          style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .grey500)),
                                                      w4,
                                                      Text(
                                                        "*",
                                                        style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .appbarRed),
                                                      ),
                                                    ],
                                                  ),
                                                  h8,
                                                  DropdownWidget<
                                                      DropdownSchoolTeacher>(
                                                    value: cnt
                                                                .tSelectedschool
                                                                .value
                                                                .tcSchoolId ==
                                                            null
                                                        ? null
                                                        : cnt.tSelectedschool
                                                            .value,
                                                    items: cnt.schoolList
                                                        .map(
                                                          (e) => DropdownMenuItem<
                                                              DropdownSchoolTeacher>(
                                                            value: e,
                                                            child: Text(
                                                              e.tcSchoolName
                                                                  .toString(),
                                                              style: FontStyleUtilities
                                                                      .h6()
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .black),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      cnt.tSelectedschool
                                                          .value = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "require_schoolname"
                                                            .tr;
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      "school_name".tr,
                                                      style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .gray400)
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
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
                                                  Row(
                                                    children: [
                                                      Text('select_level'.tr,
                                                          style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .grey500)),
                                                      w4,
                                                      Text(
                                                        "*",
                                                        style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .appbarRed),
                                                      ),
                                                    ],
                                                  ),
                                                  h8,
                                                  DropdownWidget(
                                                    value: cnt.tSelectedlevel
                                                                .value.value ==
                                                            null
                                                        ? null
                                                        : cnt.tSelectedlevel
                                                            .value,
                                                    items: cnt.levelList
                                                        .map(
                                                          (e) => DropdownMenuItem<
                                                              CertificateList>(
                                                            value: e,
                                                            child: Text(
                                                              e.value
                                                                  .toString(),
                                                              style: FontStyleUtilities
                                                                      .h6()
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .black),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      cnt.tSelectedlevel.value =
                                                          value!;
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "require_level"
                                                            .tr;
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      "select_level".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .gray400)
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
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
                                                      Expanded(
                                                        child: Text(
                                                            'years_of_experience'
                                                                .tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: FontStyleUtilities.t2(
                                                                fontColor:
                                                                    AppColors
                                                                        .grey500)),
                                                      ),
                                                      w4,
                                                      Text(
                                                        "*",
                                                        style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .appbarRed),
                                                      ),
                                                    ],
                                                  ),
                                                  h8,
                                                  DropdownWidget<
                                                      CertificateList>(
                                                    value: cnt.tSelectedYearofexp
                                                                .value.value ==
                                                            null
                                                        ? null
                                                        : cnt.tSelectedYearofexp
                                                            .value,
                                                    items: cnt.yearsofExpList
                                                        .map(
                                                          (e) => DropdownMenuItem<
                                                              CertificateList>(
                                                            // enabled: e.enable ?? true,
                                                            value: e,
                                                            child: Text(
                                                              e.value
                                                                  .toString(),
                                                              style: FontStyleUtilities
                                                                      .h6()
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .black),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      cnt.tSelectedYearofexp
                                                          .value = value!;
                                                      // cnt.checkColor();
                                                      if (!cnt
                                                          .textChanged.value) {
                                                        cnt.textChanged.value =
                                                            true;
                                                      }
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "require_years_of_exp"
                                                            .tr;
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      "years_of_experience".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .gray400)
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
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
                                                  Row(
                                                    children: [
                                                      Text('select_language'.tr,
                                                          style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .grey500)),
                                                      w4,
                                                      Text(
                                                        "*",
                                                        style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .appbarRed),
                                                      ),
                                                    ],
                                                  ),
                                                  h8,
                                                  DropdownWidget(
                                                    value: cnt.tSelectedlanguage
                                                                .value.value ==
                                                            null
                                                        ? null
                                                        : cnt.tSelectedlanguage
                                                            .value,
                                                    items: cnt.languageList
                                                        .map(
                                                          (e) => DropdownMenuItem<
                                                              CertificateList>(
                                                            // enabled: e.enable ?? true,
                                                            value: e,
                                                            child: Text(
                                                              e.value
                                                                  .toString(),
                                                              style: FontStyleUtilities
                                                                      .h6()
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .black),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      cnt.tSelectedlanguage
                                                          .value = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "require_language"
                                                            .tr;
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      "select_language".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .gray400)
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
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
                                                          'select_certificate'
                                                              .tr,
                                                          style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .grey500)),
                                                      w4,
                                                      Text(
                                                        "*",
                                                        style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .appbarRed),
                                                      ),
                                                    ],
                                                  ),
                                                  h8,
                                                  DropdownWidget(
                                                    value: cnt.tSelectedcertificate
                                                                .value.value ==
                                                            null
                                                        ? null
                                                        : cnt
                                                            .tSelectedcertificate
                                                            .value,
                                                    items: cnt.certificateList
                                                        .map(
                                                          (e) => DropdownMenuItem<
                                                              CertificateList>(
                                                            // enabled: e.enable ?? true,
                                                            value: e,
                                                            child: Text(
                                                              e.value
                                                                  .toString(),
                                                              style: FontStyleUtilities
                                                                      .h6()
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .black),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      cnt.tSelectedcertificate
                                                          .value = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "require_certificate"
                                                            .tr;
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      "select_certificate".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .gray400)
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        h12,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('subject'.tr,
                                                    style:
                                                        FontStyleUtilities.t2(
                                                            fontColor: AppColors
                                                                .grey500)),
                                                w4,
                                                Text(
                                                  "*",
                                                  style: FontStyleUtilities.h6(
                                                      fontColor:
                                                          AppColors.appbarRed),
                                                ),
                                              ],
                                            ),
                                            h8,
                                            DropdownWidget(
                                              value: cnt.tSelectedsubject.value
                                                          .value ==
                                                      null
                                                  ? null
                                                  : cnt.tSelectedsubject.value,
                                              items: cnt.subjectList
                                                  .map(
                                                    (e) => DropdownMenuItem<
                                                        CertificateList>(
                                                      // enabled: e.enable ?? true,
                                                      value: e,
                                                      child: Text(
                                                        e.value.toString(),
                                                        style: FontStyleUtilities
                                                                .h6()
                                                            .copyWith(
                                                                color: AppColors
                                                                    .black),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (value) {
                                                cnt.tSelectedsubject.value =
                                                    value!;
                                              },
                                              validator: (value) {
                                                if (value == null) {
                                                  return "require_subject".tr;
                                                }
                                                return null;
                                              },
                                              hint: Text(
                                                "subject".tr,
                                                overflow: TextOverflow.ellipsis,
                                                style: FontStyleUtilities.t2(
                                                        fontColor:
                                                            AppColors.gray400)
                                                    .copyWith(fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                        h12,
                                        Obx(
                                          () => TextFiledWithTitle(
                                            onChanged: (value) {
                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                              // cnt.checkColor();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "please_enter_password"
                                                    .tr;
                                              } else if (value.length <= 6) {
                                                return "password_validate".tr;
                                              }
                                              return null;
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.deny(
                                                  RegExp(r'\s')),
                                            ],
                                            icon: GestureDetector(
                                              onTap: () {
                                                cnt.tisobsPass.value =
                                                    !cnt.tisobsPass.value;
                                              },
                                              child: !cnt.tisobsPass.value
                                                  ? Icon(
                                                      Icons.visibility_off,
                                                      size: 22,
                                                    )
                                                  : const Icon(
                                                      Icons.visibility,
                                                      color: AppColors.iconGrey,
                                                      size: 22,
                                                    ),
                                            ),
                                            obscureText: cnt.tisobsPass.value,
                                            hint: "enter_password".tr,
                                            title: 'enter_password'.tr,
                                            isrequired: true,
                                            keyboardType: TextInputType.text,
                                            controller: cnt.tPassword.value,
                                            scrollPadding: true,
                                          ),
                                        ),
                                        h12,
                                        Obx(
                                          () => TextFiledWithTitle(
                                            onChanged: (value) {
                                              if (!cnt.textChanged.value) {
                                                cnt.textChanged.value = true;
                                              }
                                              // cnt.checkColor();
                                            },
                                            validator: (value) {
                                              if (value !=
                                                  cnt.tPassword.value.text) {
                                                return "password_not_match".tr;
                                              }
                                              return null;
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.deny(
                                                  RegExp(r'\s')),
                                            ],
                                            icon: GestureDetector(
                                              onTap: () {
                                                cnt.tisobscPass.value =
                                                    !cnt.tisobscPass.value;
                                              },
                                              child: !cnt.tisobscPass.value
                                                  ? Icon(
                                                      Icons.visibility_off,
                                                      size: 22,
                                                    )
                                                  : const Icon(
                                                      Icons.visibility,
                                                      color: AppColors.iconGrey,
                                                      size: 22,
                                                    ),
                                            ),
                                            hint: "confirm_password".tr,
                                            title: 'confirm_password'.tr,
                                            keyboardType: TextInputType.text,
                                            controller: cnt.tCpassword.value,
                                            scrollPadding: true,
                                            obscureText: cnt.tisobscPass.value,
                                          ),
                                        ),
                                        h12,
                                        TextFiledWithTitle(
                                          hint: "enter_brief_profile".tr,
                                          title: 'brief_profile'.tr,
                                          isrequired: true,
                                          maxLines: 5,
                                          keyboardType: TextInputType.text,
                                          controller: cnt.tBriefProfile.value,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "require_brief_profile".tr;
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // cnt.checkColor();
                                            if (!cnt.textChanged.value) {
                                              cnt.textChanged.value = true;
                                            }
                                          },
                                          scrollPadding: true,
                                        ),
                                        h30,
                                        LargeButton(
                                          height: 45,
                                          onPressed: () {
                                            if (teacherKey.currentState!
                                                .validate()) {
                                              cnt.showConfirmSignupDialog(
                                                  context: context);
                                              // cnt.signupTeacher(context);
                                            }
                                            // Get.toNamed(RoutesConst
                                            //     .emailVerificationPage);
                                          },
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            'signup'.tr,
                                            style: FontStyleUtilities.h6(
                                                fontWeight: FWT.medium,
                                                fontColor: AppColors.white),
                                          ),
                                        ),
                                        h30,
                                        Center(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text:
                                                    "Already have an account? ",
                                                style: FontStyleUtilities.h6(
                                                    fontColor:
                                                        AppColors.gray600),
                                                children: [
                                                  TextSpan(
                                                    text: "Login",
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //       builder:
                                                            //           (context) =>
                                                            //               LoginPage()),
                                                            // );
                                                            logincnt.isLogin
                                                                .value = true;
                                                            // Get.to(() =>
                                                            //     LoginPage());
                                                          },
                                                    style:
                                                        FontStyleUtilities.h6(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.primary,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        h10,
                                        Center(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text: "Read our ",
                                                style: FontStyleUtilities.h6(
                                                        fontColor:
                                                            AppColors.gray600)
                                                    .copyWith(fontSize: 14),
                                                children: [
                                                  TextSpan(
                                                    text: "Privacy Policy",
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            navigatorKey
                                                                .currentState!
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AppWebView(
                                                                  url:
                                                                      "https://katondev.in/privacy-policy",
                                                                  arguments: Arguments(
                                                                      title:
                                                                          "Privacy Policy",
                                                                      description:
                                                                          ""),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                    style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .primary)
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                  TextSpan(
                                                    text: " and ",
                                                    style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .gray600)
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "Terms and Conditions",
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            navigatorKey
                                                                .currentState!
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AppWebView(
                                                                  url:
                                                                      "https://katondev.in/terms-of-use",
                                                                  arguments: Arguments(
                                                                      title:
                                                                          "Terms and Conditions",
                                                                      description:
                                                                          ""),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                    style:
                                                        FontStyleUtilities.h6(
                                                      fontColor:
                                                          AppColors.primary,
                                                    ).copyWith(fontSize: 14),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        h20,
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                      ],
                                    ),
                                  )
                                : Form(
                                    key: learnerKey,
                                    child: Column(
                                      // shrinkWrap: true,
                                      // physics: BouncingScrollPhysics(),
                                      children: [
                                        TextFiledWithTitle(
                                          // onChanged: (value) {
                                          //   if (!cnt.textChanged.value) {
                                          //     cnt.textChanged.value =
                                          //         true;
                                          //   }
                                          //   cnt.checkColor();
                                          // },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "signup_require_fullname"
                                                  .tr;
                                            }
                                            return null;
                                          },
                                          hint: "full_name".tr,
                                          title: 'full_name'.tr,
                                          isrequired: true,
                                          keyboardType: TextInputType.text,
                                          controller: cnt.stFullname.value,
                                          scrollPadding: true,
                                        ),
                                        h12,
                                        TextFiledWithTitle(
                                          // onChanged: (value) {
                                          //   if (!cnt.textChanged.value) {
                                          //     cnt.textChanged.value =
                                          //         true;
                                          //   }
                                          //   cnt.checkColor();
                                          // },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "signup_require_email".tr;
                                            }
                                            return null;
                                          },
                                          hint: "email".tr,
                                          title: "email".tr,
                                          isrequired: true,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: cnt.stEmail.value,
                                          scrollPadding: true,
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
                                                  h2,
                                                  Text('country_code'.tr,
                                                      style:
                                                          FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .grey500)),
                                                  h8,
                                                  DropdownWidget(
                                                    value: cnt
                                                                .stSelectedcountrycode
                                                                .value
                                                                .countrycode ==
                                                            null
                                                        ? null
                                                        : cnt
                                                            .stSelectedcountrycode
                                                            .value,
                                                    items: cnt.countryCodeList
                                                        .map(
                                                          (e) => DropdownMenuItem<
                                                              DropdownCountrycode>(
                                                            // enabled: e.enable ?? true,
                                                            value: e,
                                                            child: Text(
                                                              e.countrycode
                                                                  .toString(),
                                                              style: FontStyleUtilities
                                                                      .h6()
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .black),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      cnt.stSelectedcountrycode
                                                          .value = value!;
                                                    },
                                                    hint: Text(
                                                      "country_code".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .gray400)
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            w20,
                                            Expanded(
                                              child: TextFiledWithTitle(
                                                // onChanged: (value) {
                                                //   if (!cnt.textChanged.value) {
                                                //     cnt.textChanged.value = true;
                                                //   }
                                                //   cnt.checkColor();
                                                // },
                                                validator: (value) =>
                                                    Validators.validateMobile(
                                                        value),
                                                hint: "Mobile_number".tr,
                                                title: 'Mobile_number'.tr,
                                                isrequired: true,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    cnt.stMobileNumber.value,
                                                scrollPadding: true,
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
                                                  Row(
                                                    children: [
                                                      Text('region_district'.tr,
                                                          style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .grey500)),
                                                      w4,
                                                      Text(
                                                        "*",
                                                        style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .appbarRed),
                                                      ),
                                                    ],
                                                  ),
                                                  h8,
                                                  DropdownWidget<
                                                      DropdownRegion>(
                                                    value: cnt
                                                                .stSelectedregion
                                                                .value
                                                                .district ==
                                                            null
                                                        ? null
                                                        : cnt.stSelectedregion
                                                            .value,
                                                    items: cnt.regionList
                                                        .map((e) =>
                                                            DropdownMenuItem<
                                                                    DropdownRegion>(
                                                                enabled:
                                                                    e.enable ??
                                                                        true,
                                                                value: e,
                                                                child: Text(
                                                                  "${e.district}",
                                                                  style: e.enable!
                                                                      ? FontStyleUtilities.h6().copyWith(
                                                                          color: AppColors
                                                                              .black)
                                                                      : FontStyleUtilities
                                                                              .t4()
                                                                          .copyWith(
                                                                              color: Colors.black54),
                                                                )))
                                                        .toList(),
                                                    onChanged: (value) async {
                                                      cnt.stSelectedregion
                                                          .value = value!;
                                                      //  cnt.checkColor();
                                                      if (!cnt
                                                          .textChanged.value) {
                                                        cnt.textChanged.value =
                                                            true;
                                                      }

                                                      cnt.stSelectedschool
                                                              .value =
                                                          DropdownSchoolTeacher();
                                                      cnt.schoolList.clear();

                                                      await cnt
                                                          .getAllschoolData(
                                                              region: value
                                                                  .region
                                                                  .toString(),
                                                              district: value
                                                                  .district
                                                                  .toString());
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "require_region_district"
                                                            .tr;
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      "region_district".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .gray400)
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
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
                                                      Text('school_name'.tr,
                                                          style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .grey500)),
                                                      w4,
                                                      Text(
                                                        "*",
                                                        style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .appbarRed),
                                                      ),
                                                    ],
                                                  ),
                                                  h8,
                                                  DropdownWidget<
                                                      DropdownSchoolTeacher>(
                                                    value: cnt
                                                                .stSelectedschool
                                                                .value
                                                                .tcSchoolId ==
                                                            null
                                                        ? null
                                                        : cnt.stSelectedschool
                                                            .value,
                                                    items: cnt.schoolList
                                                        .map(
                                                          (e) => DropdownMenuItem<
                                                              DropdownSchoolTeacher>(
                                                            value: e,
                                                            child: Text(
                                                              e.tcSchoolName
                                                                  .toString(),
                                                              style: FontStyleUtilities
                                                                      .h6()
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .black),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      cnt.stSelectedschool
                                                          .value = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "require_schoolname"
                                                            .tr;
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      "school_name".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .gray400)
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        h12,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('class_grade'.tr,
                                                    style:
                                                        FontStyleUtilities.t2(
                                                            fontColor: AppColors
                                                                .grey500)),
                                                w4,
                                                Text(
                                                  "*",
                                                  style: FontStyleUtilities.h6(
                                                      fontColor:
                                                          AppColors.appbarRed),
                                                ),
                                              ],
                                            ),
                                            h8,
                                            DropdownWidget(
                                              value: cnt.stSelectedclass.value
                                                          .label ==
                                                      null
                                                  ? null
                                                  : cnt.stSelectedclass.value,
                                              items: cnt.classList
                                                  .map((e) => DropdownMenuItem<
                                                          DropdownClasses>(
                                                      enabled: e.enable ?? true,
                                                      value: e,
                                                      child: Text(
                                                        "${e.label}",
                                                        style: e.enable!
                                                            ? FontStyleUtilities
                                                                    .h6()
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .black)
                                                            : FontStyleUtilities
                                                                    .t4()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black54),
                                                      )))
                                                  .toList(),
                                              onChanged: (value) {
                                                cnt.stSelectedclass.value =
                                                    value!;
                                                // cnt.checkColor();
                                              },
                                              validator: (value) {
                                                if (value == null) {
                                                  return "require_class".tr;
                                                }
                                                return null;
                                              },
                                              hint: Text(
                                                "class_grade".tr,
                                                overflow: TextOverflow.ellipsis,
                                                style: FontStyleUtilities.t2(
                                                        fontColor:
                                                            AppColors.gray400)
                                                    .copyWith(fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                        h12,
                                        Obx(
                                          () => TextFiledWithTitle(
                                            // onChanged: (value) {
                                            //   if (!cnt.textChanged.value) {
                                            //     cnt.textChanged.value =
                                            //         true;
                                            //   }
                                            //   cnt.checkColor();
                                            // },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "please_enter_password"
                                                    .tr;
                                              } else if (value.length <= 6) {
                                                return "password_validate".tr;
                                              }
                                              return null;
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.deny(
                                                  RegExp(r'\s')),
                                            ],
                                            icon: GestureDetector(
                                              onTap: () {
                                                cnt.stisobsPass.value =
                                                    !cnt.stisobsPass.value;
                                              },
                                              child: !cnt.stisobsPass.value
                                                  ? Icon(
                                                      Icons.visibility_off,
                                                      size: 22,
                                                    )
                                                  : const Icon(
                                                      Icons.visibility,
                                                      color: AppColors.iconGrey,
                                                      size: 22,
                                                    ),
                                            ),
                                            hint: "enter_password".tr,
                                            title: 'enter_password'.tr,
                                            isrequired: true,
                                            keyboardType: TextInputType.text,
                                            controller: cnt.stPassword.value,
                                            scrollPadding: true,
                                            obscureText: cnt.stisobsPass.value,
                                          ),
                                        ),
                                        h12,
                                        TextFiledWithTitle(
                                          // onChanged: (value) {
                                          //   if (!cnt.textChanged.value) {
                                          //     cnt.textChanged.value =
                                          //         true;
                                          //   }
                                          //   cnt.checkColor();
                                          // },
                                          validator: (value) {
                                            if (value !=
                                                cnt.stPassword.value.text) {
                                              return "password_not_match".tr;
                                            }
                                            return null;
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r'\s')),
                                          ],
                                          icon: GestureDetector(
                                            onTap: () {
                                              cnt.stisobscPass.value =
                                                  !cnt.stisobscPass.value;
                                            },
                                            child: !cnt.stisobscPass.value
                                                ? Icon(
                                                    Icons.visibility_off,
                                                    size: 22,
                                                  )
                                                : const Icon(
                                                    Icons.visibility,
                                                    color: AppColors.iconGrey,
                                                    size: 22,
                                                  ),
                                          ),
                                          hint: "confirm_password".tr,
                                          title: 'confirm_password'.tr,
                                          keyboardType: TextInputType.text,
                                          controller: cnt.stCpassword.value,
                                          scrollPadding: true,
                                          obscureText: cnt.stisobscPass.value,
                                        ),
                                        h30,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("parent_details".tr,
                                                style: FontStyleUtilities.h4(
                                                    fontColor:
                                                        AppColors.blueType2,
                                                    fontWeight: FWT.medium)),
                                            h25,
                                            TextFiledWithTitle(
                                              // onChanged: (value) {
                                              //   if (!cnt.textChanged.value) {
                                              //     cnt.textChanged.value = true;
                                              //   }
                                              //   cnt.checkColor();
                                              // },
                                              hint: "enter_parent_name".tr,
                                              title: 'parent_name'.tr,
                                              keyboardType: TextInputType.text,
                                              controller:
                                                  cnt.stParentName.value,
                                              scrollPadding: true,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      h2,
                                                      Text('country_code'.tr,
                                                          style: FontStyleUtilities.t2(
                                                              fontColor:
                                                                  AppColors
                                                                      .grey500)),
                                                      h8,
                                                      DropdownWidget(
                                                        value: cnt
                                                                    .stSelectedparentcountrycode
                                                                    .value
                                                                    .countrycode ==
                                                                null
                                                            ? null
                                                            : cnt
                                                                .stSelectedparentcountrycode
                                                                .value,
                                                        items:
                                                            cnt.countryCodeList
                                                                .map(
                                                                  (e) => DropdownMenuItem<
                                                                      DropdownCountrycode>(
                                                                    // enabled: e.enable ?? true,
                                                                    value: e,
                                                                    child: Text(
                                                                      e.countrycode
                                                                          .toString(),
                                                                      style: FontStyleUtilities
                                                                              .h6()
                                                                          .copyWith(
                                                                              color: AppColors.black),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                        onChanged: (value) {
                                                          cnt.stSelectedparentcountrycode
                                                              .value = value!;
                                                        },
                                                        hint: Text(
                                                          "country_code".tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: FontStyleUtilities.t2(
                                                                  fontColor:
                                                                      AppColors
                                                                          .gray400)
                                                              .copyWith(
                                                                  fontSize: 14),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                w20,
                                                Expanded(
                                                  child: TextFiledWithTitle(
                                                    // onChanged: (value) {
                                                    //   if (!cnt.textChanged.value) {
                                                    //     cnt.textChanged.value = true;
                                                    //   }
                                                    //   cnt.checkColor();
                                                    // },
                                                    validator: (value) =>
                                                        Validators
                                                            .validateParentMobile(
                                                                value),
                                                    hint: "parent_phone".tr,
                                                    title: 'parent_phone'.tr,
                                                    isrequired: true,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: cnt
                                                        .stParentmobileNo.value,
                                                    scrollPadding: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            h12,
                                            TextFiledWithTitle(
                                              // onChanged: (value) {
                                              //   if (!cnt.textChanged.value) {
                                              //     cnt.textChanged.value = true;
                                              //   }
                                              //   cnt.checkColor();
                                              // },
                                              hint: "enter_parent_email".tr,
                                              title: 'parent_email'.tr,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              controller:
                                                  cnt.stParentemail.value,
                                              scrollPadding: true,
                                            ),
                                            h12,
                                          ],
                                        ),
                                        h30,
                                        LargeButton(
                                          height: 45,
                                          onPressed: () {
                                            if (learnerKey.currentState!
                                                .validate()) {
                                              // cnt.signupStudent(context);
                                              cnt.showConfirmSignupDialog(
                                                  context: context);
                                            }
                                          },
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            'signup'.tr,
                                            style: FontStyleUtilities.h6(
                                                fontWeight: FWT.medium,
                                                fontColor: AppColors.white),
                                          ),
                                        ),
                                        h30,
                                        Center(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text:
                                                    "Already have an account? ",
                                                style: FontStyleUtilities.h6(
                                                    fontColor:
                                                        AppColors.gray600),
                                                children: [
                                                  TextSpan(
                                                    text: "Login",
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //       builder:
                                                            //           (context) =>
                                                            //               LoginPage()),
                                                            // );
                                                            logincnt.isLogin
                                                                .value = true;
                                                            // Get.offAllNamed(
                                                            //     RoutesConst
                                                            //         .loginPage);
                                                          },
                                                    style:
                                                        FontStyleUtilities.h6(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.primary,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        h10,
                                        Center(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text: "Read our ",
                                                style: FontStyleUtilities.h6(
                                                        fontColor:
                                                            AppColors.gray600)
                                                    .copyWith(fontSize: 14),
                                                children: [
                                                  TextSpan(
                                                    text: "Privacy Policy",
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            navigatorKey
                                                                .currentState!
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AppWebView(
                                                                  url:
                                                                      "https://katondev.in/privacy-policy",
                                                                  arguments: Arguments(
                                                                      title:
                                                                          "Privacy Policy",
                                                                      description:
                                                                          ""),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                    style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .primary)
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                  TextSpan(
                                                    text: " and ",
                                                    style: FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .gray600)
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "Terms and Conditions",
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            navigatorKey
                                                                .currentState!
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AppWebView(
                                                                  url:
                                                                      "https://katondev.in/terms-of-use",
                                                                  arguments: Arguments(
                                                                      title:
                                                                          "Terms and Conditions",
                                                                      description:
                                                                          ""),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                    style:
                                                        FontStyleUtilities.h6(
                                                      fontColor:
                                                          AppColors.primary,
                                                    ).copyWith(fontSize: 14),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        h20,
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                      ],
                                    ),
                                  ),
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
