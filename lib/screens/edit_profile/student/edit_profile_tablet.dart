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
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/font_style.dart';
import '../../../utils/validators.dart';
import '../../../widgets/dropdown.dart';
import '../../../widgets/textfiled_with_title.dart';

class EditProfileTabletPage extends StatefulWidget {
  final Arguments arguments;
  final String title;

  const EditProfileTabletPage(
      {Key? key, required this.arguments, required this.title})
      : super(key: key);

  @override
  State<EditProfileTabletPage> createState() => _EditProfileTabletPageState();
}

class _EditProfileTabletPageState extends State<EditProfileTabletPage> {
  final cnt = Get.find<EditProfileCnt>();
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
              padding: const EdgeInsets.fromLTRB(35, 30, 80, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonAppBar2(
                    title: "Profile",
                  ),
                  customHeight(35),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.boxgreyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.fromLTRB(
                          60, 48, 60, MediaQuery.of(context).viewInsets.bottom),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
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
                                    const Divider(
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
                                                NetworkImageWidget(
                                                  height: 80,
                                                  width: 80,
                                                  imageUrl:
                                                      "${ApiRoutes.imageURL}${cnt.image!.value}",
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
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
                                                          const EdgeInsets.all(
                                                              7),
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
                                                            color: AppColors
                                                                .appbarRed,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    h8,
                                                    DropDownCustom<
                                                        DropdownClasses>(
                                                      onChange: (value) {
                                                        cnt.classValue.value =
                                                            value!;
                                                        if (!cnt.textChanged
                                                            .value) {
                                                          cnt.textChanged
                                                              .value = true;
                                                        }
                                                        cnt.checkColor();
                                                      },
                                                      validator: (value) {
                                                        if (value!
                                                            .label!.isEmpty) {
                                                          return "require_class"
                                                              .tr;
                                                        }
                                                        return null;
                                                      },
                                                      selectedValue: (cnt
                                                                  .classValue
                                                                  .value
                                                                  .label ==
                                                              null)
                                                          ? null
                                                          : cnt.classValue,
                                                      items: cnt.classList
                                                          .map((e) =>
                                                              DropdownMenuItem<
                                                                      DropdownClasses>(
                                                                  enabled:
                                                                      e.enable ??
                                                                          true,
                                                                  value: e,
                                                                  child: Text(
                                                                    "${e.label}",
                                                                    style: e.enable!
                                                                        ? AppTextStyle
                                                                            .normalRegular12
                                                                        : AppTextStyle
                                                                            .normalRegular12
                                                                            .copyWith(color: Colors.black54),
                                                                  )))
                                                          .toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // w10,
                                              // Expanded(
                                              //   child: Column(
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.start,
                                              //     children: [
                                              //       Row(
                                              //         children: [
                                              //           Text(
                                              //             'division'.tr,
                                              //             style: AppTextStyle
                                              //                 .normalBold12
                                              //                 .copyWith(
                                              //               color: AppColors
                                              //                   .primaryBlack,
                                              //             ),
                                              //           ),
                                              //           w4,
                                              //           Text(
                                              //             "*",
                                              //             style: AppTextStyle
                                              //                 .normalBold12
                                              //                 .copyWith(
                                              //               color: AppColors
                                              //                   .appbarRed,
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //       h8,
                                              //       DropDown(
                                              //         dropDowns:
                                              //             cnt.divisionList,
                                              //         selectedValue: cnt
                                              //             .divisionNumber.value,
                                              //         onChange: (value) {
                                              //           cnt.divisionNumber
                                              //                   .value =
                                              //               value ?? "";
                                              //           if (!cnt.textChanged
                                              //               .value) {
                                              //             cnt.textChanged
                                              //                 .value = true;
                                              //           }
                                              //           cnt.checkColor();
                                              //         },
                                              //         validator: (value) {
                                              //           if (value!.isEmpty) {
                                              //             return "require_division"
                                              //                 .tr;
                                              //           }
                                              //           return null;
                                              //         },
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
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
                                              cnt.selectedSchoolValue.value =
                                                  DropdownSchool();
                                              cnt.schoolList.clear();

                                              await cnt.getAllschoolData(
                                                  region:
                                                      value.region.toString(),
                                                  district: value.district
                                                      .toString());
                                            },
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
                                            hint: Text(
                                                "${"select_school_name".tr}"),
                                            selectedValue: cnt
                                                        .selectedSchoolValue
                                                        .value
                                                        .scSchoolId ==
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
                                              if (value!
                                                  .scSchoolName!.isEmpty) {
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

                                          h46,
                                          // h40,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text("parent_details".tr,
                                                    style:
                                                        FontStyleUtilities.h6(
                                                            fontColor: AppColors
                                                                .grey500)),
                                              ),
                                              h25,
                                              TextfieldwithTitle(
                                                  onChanged: (value) {
                                                    if (!cnt
                                                        .textChanged.value) {
                                                      cnt.textChanged.value =
                                                          true;
                                                    }
                                                    cnt.checkColor();
                                                  },
                                                  hint: "enter_parent_name".tr,
                                                  title: 'parent_name'.tr,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  controller:
                                                      cnt.parentName.value),
                                              h12,
                                              TextfieldwithTitle(
                                                  onChanged: (value) {
                                                    if (!cnt
                                                        .textChanged.value) {
                                                      cnt.textChanged.value =
                                                          true;
                                                    }
                                                    cnt.checkColor();
                                                  },
                                                  validator: (value) => Validators
                                                      .validateParentMobile(
                                                          value),
                                                  hint:
                                                      "enter_parent_mobile".tr,
                                                  title: 'parent_mobile'.tr,
                                                  isrequired: true,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: cnt
                                                      .parentmobileNumber
                                                      .value),
                                              h12,
                                              TextfieldwithTitle(
                                                  onChanged: (value) {
                                                    if (!cnt
                                                        .textChanged.value) {
                                                      cnt.textChanged.value =
                                                          true;
                                                    }
                                                    cnt.checkColor();
                                                  },
                                                  hint: "enter_parent_email".tr,
                                                  title: 'parent_email'.tr,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  controller:
                                                      cnt.parentemail.value),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'dart:developer';
// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:katon/models/argument_model.dart';
// import 'package:katon/models/school_filter_model/school_filter_model.dart';
// import 'package:katon/network/api_constants.dart';
// import 'package:katon/screens/edit_profile/controller/edit_profile_cnt.dart';
// import 'package:katon/screens/edit_profile/widgets/common_widgets.dart';
// import 'package:katon/screens/edit_profile/widgets/custom_textFileds.dart';
// import 'package:katon/utils/config.dart';
// import 'package:katon/widgets/common_appbar.dart';
// import 'package:katon/widgets/common_container.dart';
// import 'package:katon/widgets/dropdown.dart';
// import 'package:katon/widgets/loader.dart';
// import 'package:katon/widgets/svgIcon.dart';
// import 'package:katon/widgets/textfiled_with_title.dart';

// import '../../models/sign_in_model.dart';
// import '../../utils/validators.dart';
// import '../../widgets/no_data_found.dart';

// class EditProfileTabletPage extends StatelessWidget {
//   final Arguments arguments;
//   final String title;
//   EditProfileTabletPage(
//       {Key? key, required this.arguments, required this.title})
//       : super(key: key);
//   final cnt = Get.put(EditProfileCnt());
//   final aCnt = Get.put(AppBarCnt());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.transparent,
//         appBar: commonAppBar(
//             title: arguments.title, description: arguments.description),
//         endDrawer: endDrawer(),
//         body: Form(
//           key: cnt.formKey,
//           child: Obx(
//             () => cnt.isLoading.value
//                 ? Loader(message: "loading".tr)
//                 : Column(
//                     children: [
//                       ConnectionWidget.connection,
//                       ColorContainer(
//                         margin: t5l20r20b15,
//                         color: AppColors.blueType2,
//                         title: title,
//                         textStyle: FontStyleUtilities.h4(
//                             fontColor: AppColors.white,
//                             fontWeight: FWT.semiBold),
//                         svgImage: Images.editProfileSvg,
//                         child: Expanded(
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: AppColors.white, borderRadius: cr24),
//                             padding: EdgeInsets.only(
//                                 left: 32,
//                                 right: 32,
//                                 top: 15,
//                                 bottom:
//                                     MediaQuery.of(context).viewInsets.bottom),
//                             child: ListView(
//                               physics: BouncingScrollPhysics(),
//                               children: [
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           // Text("profile_image".tr,
//                                           //     style: FontStyleUtilities.h6(
//                                           //         fontColor: AppColors.grey500)),
//                                           h18,
//                                           cnt.imageFile == null
//                                               ? ClipRRect(
//                                                   borderRadius: cr12,
//                                                   child: CachedNetworkImage(
//                                                     height: 243,
//                                                     width: 243,
//                                                     fit: BoxFit.cover,
//                                                     imageUrl:
//                                                         "${cnt.image?.value}",
//                                                     errorWidget: (context, url,
//                                                             error) =>
//                                                         Image.asset(
//                                                             Images.walkThrough,
//                                                             height: 243,
//                                                             width: 243,
//                                                             fit: BoxFit.cover),
//                                                   ),
//                                                 )
//                                               : SizedBox(
//                                                   height: 243,
//                                                   width: 245,
//                                                   child: cnt.loading.value
//                                                       ? const Center(
//                                                           child:
//                                                               CircularProgressIndicator())
//                                                       : ClipRRect(
//                                                           borderRadius: cr12,
//                                                           child: Image.file(
//                                                             File(cnt.imageFile!
//                                                                 .path),
//                                                             fit: BoxFit.cover,
//                                                           ))),
//                                           h14,
//                                           SizedBox(
//                                             width: 245,
//                                             child: InkWell(
//                                               onTap: () => cnt.getFromGallery(),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   SvgIcon(Images.galleryEdit),
//                                                   w6,
//                                                   Text(
//                                                       "change_profile_image".tr,
//                                                       style:
//                                                           FontStyleUtilities.t4(
//                                                               fontColor:
//                                                                   AppColors
//                                                                       .primary,
//                                                               fontWeight:
//                                                                   FWT.medium))
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           h70,
//                                           CustomTextFiledS()
//                                         ],
//                                       ),
//                                     ),
//                                     w70,
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         // mainAxisAlignment: MainAxisAlignment.end,
//                                         children: [
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(
//                                                 width: 100,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text('country_code'.tr,
//                                                         style: FontStyleUtilities
//                                                             .t2(
//                                                                 fontColor:
//                                                                     AppColors
//                                                                         .grey500)),
//                                                     h10,
//                                                     DropDown(
//                                                       dropDowns:
//                                                           cnt.countryCodeList,
//                                                       selectedValue:
//                                                           cnt.countrycode.value,
//                                                       onChange: (value) {
//                                                         cnt.countrycode.value =
//                                                             value ?? "";
//                                                         if (!cnt.textChanged
//                                                             .value) {
//                                                           cnt.textChanged
//                                                               .value = true;
//                                                         }
//                                                         cnt.checkColor();
//                                                       },
//                                                       // validator: (value) {
//                                                       //   if (value!.isEmpty) {
//                                                       //     return "require_division"
//                                                       //         .tr;
//                                                       //   }
//                                                       //   return null;
//                                                       // },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               w20,
//                                               Expanded(
//                                                 child: TextFiledWithTitle(
//                                                     onChanged: (value) {
//                                                       if (!cnt
//                                                           .textChanged.value) {
//                                                         cnt.textChanged.value =
//                                                             true;
//                                                       }
//                                                       cnt.checkColor();
//                                                     },
//                                                     validator: (value) =>
//                                                         Validators
//                                                             .validateMobile(
//                                                                 value),
//                                                     hint: "Mobile_number".tr,
//                                                     title: 'Mobile_number'.tr,
//                                                     isrequired: true,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     controller:
//                                                         cnt.mobileNumber.value),
//                                               ),
//                                             ],
//                                           ),
//                                           h12,
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Expanded(child: ClassDropDown()),
//                                               w10,
//                                               Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Row(
//                                                       children: [
//                                                         Text('division'.tr,
//                                                             style: FontStyleUtilities.t2(
//                                                                 fontColor:
//                                                                     AppColors
//                                                                         .grey500)),
//                                                         w4,
//                                                         Text(
//                                                           "*",
//                                                           style: FontStyleUtilities.h6(
//                                                               fontColor: AppColors
//                                                                   .appbarRed),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     h8,
//                                                     DropDown(
//                                                       dropDowns:
//                                                           cnt.divisionList,
//                                                       selectedValue: cnt
//                                                           .divisionNumber.value,
//                                                       onChange: (value) {
//                                                         cnt.divisionNumber
//                                                                 .value =
//                                                             value ?? "";
//                                                         if (!cnt.textChanged
//                                                             .value) {
//                                                           cnt.textChanged
//                                                               .value = true;
//                                                         }
//                                                         cnt.checkColor();
//                                                       },
//                                                       validator: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return "require_division"
//                                                               .tr;
//                                                         }
//                                                         return null;
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),

//                                           h12,

//                                           Row(
//                                             children: [
//                                               Text('region_district'.tr,
//                                                   style: FontStyleUtilities.t2(
//                                                       fontColor:
//                                                           AppColors.grey500)),
//                                               w4,
//                                               Text(
//                                                 "*",
//                                                 style: FontStyleUtilities.h6(
//                                                     fontColor:
//                                                         AppColors.appbarRed),
//                                               ),
//                                             ],
//                                           ),
//                                           h8,
//                                           // Text(cnt.regionValue.value.district
//                                           //     .toString()),
//                                           // Text(cnt.regionValue.value.region
//                                           //     .toString()),
//                                           // Text(cnt.regionList.length.toString()),

//                                           Container(
//                                             height: 50,
//                                             padding: l12r12,
//                                             decoration: BoxDecoration(
//                                                 borderRadius: cr10,
//                                                 color: AppColors.white,
//                                                 border: Border.all(
//                                                     color:
//                                                         AppColors.borderColor)),
//                                             child: Obx(
//                                               () => DropdownButtonFormField<
//                                                   DropdownRegion>(
//                                                 icon: Padding(
//                                                     padding: l14,
//                                                     child: const Icon(Icons
//                                                         .keyboard_arrow_down_rounded)),
//                                                 // hint: Text(
//                                                 //     "${"select_school_name".tr}"),
//                                                 decoration: InputDecoration(
//                                                     border: InputBorder.none),
//                                                 // value: cnt.regionValue.value,
//                                                 value: cnt.regionValue.value
//                                                             .district ==
//                                                         null
//                                                     ? null
//                                                     : cnt.regionValue.value,
//                                                 items: cnt.regionList
//                                                     .map((e) =>
//                                                         DropdownMenuItem<
//                                                                 DropdownRegion>(
//                                                             enabled: e.enable ??
//                                                                 true,
//                                                             value: e,
//                                                             child: Text(
//                                                               "${e.district}",
//                                                               style: e.enable!
//                                                                   ? FontStyleUtilities
//                                                                           .h6()
//                                                                       .copyWith(
//                                                                           color: AppColors
//                                                                               .black)
//                                                                   : FontStyleUtilities
//                                                                           .t4()
//                                                                       .copyWith(
//                                                                           color:
//                                                                               Colors.black54),
//                                                             )))
//                                                     .toList(),
//                                                 // hint: Text(""),
//                                                 validator: (value) {
//                                                   if (value!
//                                                       .district!.isEmpty) {
//                                                     return "require_region_district"
//                                                         .tr;
//                                                   }
//                                                   return null;
//                                                 },
//                                                 onChanged: (value) async {
//                                                   cnt.regionValue.value =
//                                                       value!;
//                                                   if (!cnt.textChanged.value) {
//                                                     cnt.textChanged.value =
//                                                         true;
//                                                   }
//                                                   cnt.checkColor();
//                                                   cnt.selectedSchoolValue
//                                                       .value = DropdownSchool();
//                                                   cnt.schoolList.clear();

//                                                   await cnt.getAllschoolData(
//                                                       region: value.region
//                                                           .toString(),
//                                                       district: value.district
//                                                           .toString());
//                                                 },
//                                                 borderRadius: cr10,
//                                                 // alignment: Alignment.centerRight,
//                                                 isDense: true,
//                                                 isExpanded: true,
//                                               ),
//                                             ),
//                                           ),
//                                           h12,
//                                           Row(
//                                             children: [
//                                               Text('school_name'.tr,
//                                                   style: FontStyleUtilities.t2(
//                                                       fontColor:
//                                                           AppColors.grey500)),
//                                               w4,
//                                               Text(
//                                                 "*",
//                                                 style: FontStyleUtilities.h6(
//                                                     fontColor:
//                                                         AppColors.appbarRed),
//                                               ),
//                                             ],
//                                           ),
//                                           h8,
//                                           Container(
//                                             height: 50,
//                                             padding: l12r12,
//                                             decoration: BoxDecoration(
//                                                 borderRadius: cr10,
//                                                 color: AppColors.white,
//                                                 border: Border.all(
//                                                     color:
//                                                         AppColors.borderColor)),
//                                             child: Obx(
//                                               () => DropdownButtonFormField<
//                                                   DropdownSchool>(
//                                                 icon: Padding(
//                                                     padding: l14,
//                                                     child: const Icon(Icons
//                                                         .keyboard_arrow_down_rounded)),
//                                                 hint: Text(
//                                                     "${"select_school_name".tr}"),
//                                                 decoration: InputDecoration(
//                                                     border: InputBorder.none),
//                                                 value: cnt.selectedSchoolValue
//                                                             .value.scSchoolId ==
//                                                         null
//                                                     ? null
//                                                     : cnt.selectedSchoolValue
//                                                         .value,
//                                                 items: cnt.schoolList
//                                                     .map(
//                                                       (e) => DropdownMenuItem<
//                                                           DropdownSchool>(
//                                                         value: e,
//                                                         child: Text(
//                                                           "${e.scSchoolName}",
//                                                           style: FontStyleUtilities
//                                                                   .h6()
//                                                               .copyWith(
//                                                                   color: AppColors
//                                                                       .black),
//                                                         ),
//                                                       ),
//                                                     )
//                                                     .toList(),

//                                                 // validator: (value) {
//                                                 //   if (value!
//                                                 //       .scSchoolName!.isEmpty) {
//                                                 //     return "require_schoolname".tr;
//                                                 //   }
//                                                 //   return null;
//                                                 // },
//                                                 onChanged: (value) async {
//                                                   cnt.selectedSchoolValue
//                                                       .value = value!;
//                                                   if (!cnt.textChanged.value) {
//                                                     cnt.textChanged.value =
//                                                         true;
//                                                   }
//                                                   cnt.checkColor();
//                                                 },
//                                                 borderRadius: cr10,
//                                                 // alignment: Alignment.centerRight,
//                                                 isDense: true,
//                                                 isExpanded: true,
//                                               ),
//                                             ),
//                                           ),
//                                           h46,
//                                           // h40,
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Center(
//                                                 child: Text("parent_details".tr,
//                                                     style:
//                                                         FontStyleUtilities.h6(
//                                                             fontColor: AppColors
//                                                                 .grey500)),
//                                               ),
//                                               h25,
//                                               TextFiledWithTitle(
//                                                   onChanged: (value) {
//                                                     if (!cnt
//                                                         .textChanged.value) {
//                                                       cnt.textChanged.value =
//                                                           true;
//                                                     }
//                                                     cnt.checkColor();
//                                                   },
//                                                   hint: "enter_parent_name".tr,
//                                                   title: 'parent_name'.tr,
//                                                   keyboardType:
//                                                       TextInputType.text,
//                                                   controller:
//                                                       cnt.parentName.value),
//                                               h12,
//                                               TextFiledWithTitle(
//                                                   onChanged: (value) {
//                                                     if (!cnt
//                                                         .textChanged.value) {
//                                                       cnt.textChanged.value =
//                                                           true;
//                                                     }
//                                                     cnt.checkColor();
//                                                   },
//                                                   validator: (value) => Validators
//                                                       .validateParentMobile(
//                                                           value),
//                                                   hint:
//                                                       "enter_parent_mobile".tr,
//                                                   title: 'parent_mobile'.tr,
//                                                   isrequired: true,
//                                                   keyboardType:
//                                                       TextInputType.number,
//                                                   controller: cnt
//                                                       .parentmobileNumber
//                                                       .value),
//                                               h12,
//                                               TextFiledWithTitle(
//                                                   onChanged: (value) {
//                                                     if (!cnt
//                                                         .textChanged.value) {
//                                                       cnt.textChanged.value =
//                                                           true;
//                                                     }
//                                                     cnt.checkColor();
//                                                   },
//                                                   hint: "enter_parent_email".tr,
//                                                   title: 'parent_email'.tr,
//                                                   keyboardType: TextInputType
//                                                       .emailAddress,
//                                                   controller:
//                                                       cnt.parentemail.value),
//                                               h12,
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 // TextFiledWithTitle(
//                                 //     onChanged: (p0) {
//                                 //       if (!cnt.textChanged.value) {
//                                 //         cnt.textChanged.value = true;
//                                 //       }
//                                 //       cnt.checkColor();
//                                 //     },
//                                 //     hint:
//                                 //         "Cecilia Chapman711-2880 Nulla St.Mankato Mississippi 96522",
//                                 //     title: 'full_address'.tr,
//                                 //     controller: cnt.address.value,
//                                 //     maxLines: 2),
//                                 h48,
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Obx(
//                                       () => SaveChangesButton(
//                                           width: 178.0,
//                                           height: 56,
//                                           isTextChanged: cnt.textChanged.value),
//                                     ),
//                                   ],
//                                 ),
//                                 // Row(
//                                 //   mainAxisAlignment: MainAxisAlignment.center,
//                                 //   children: [
//                                 //     w16,
//                                 //     CancelButton(width: 178.0, height: 56),
//                                 //   ],
//                                 // ),
//                                 h20
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//           ),
//         ));
//   }
// }
