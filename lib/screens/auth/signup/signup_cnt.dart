import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/signup_model.dart';
import 'package:katon/models/static_data_model/static_data_model.dart';
import 'package:katon/screens/auth/login/login_cnt.dart';
import 'package:katon/utils/config.dart';

import '../../../models/region_model/region_model.dart';
import '../../../models/school_filter_model/school_filter_model.dart';
import '../../../models/sign_in_model.dart';
import '../../../models/snackbar_datamodel.dart';
import '../../../models/student_signup_model.dart';
import '../../../network/api_constants.dart';
import '../../../services/api_service.dart';
import '../../../services/snackbar_service.dart';
import '../../../widgets/button.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/responsive.dart';

class Countries {
  static DropdownCountrycode ghana =
      DropdownCountrycode(countrycode: "233", country: "Ghana");
  static DropdownCountrycode india =
      DropdownCountrycode(countrycode: "91", country: "India");
}

class SignupCnt extends GetxController {
  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ///Student

  Rx<TextEditingController> stFullname = TextEditingController().obs;
  Rx<TextEditingController> stEmail = TextEditingController().obs;
  Rx<TextEditingController> stMobileNumber = TextEditingController().obs;
  Rx<TextEditingController> stPassword = TextEditingController().obs;
  Rx<TextEditingController> stCpassword = TextEditingController().obs;
  Rx<TextEditingController> stBriefProfile = TextEditingController().obs;
  Rx<TextEditingController> stParentName = TextEditingController().obs;
  Rx<TextEditingController> stParentmobileNo = TextEditingController().obs;
  Rx<TextEditingController> stParentemail = TextEditingController().obs;
  Rx<DropdownRegion> stSelectedregion = DropdownRegion().obs;
  Rx<DropdownSchoolTeacher> stSelectedschool = DropdownSchoolTeacher().obs;

  Rx<DropdownClasses> stSelectedclass = DropdownClasses().obs;
  Rx<DropdownCountrycode> stSelectedcountrycode = Countries.ghana.obs;
  Rx<DropdownCountrycode> stSelectedparentcountrycode = Countries.ghana.obs;
  RxBool stisobsPass = true.obs;
  RxBool stisobscPass = true.obs;

  ///Teacher

  Rx<TextEditingController> tFullname = TextEditingController().obs;
  Rx<TextEditingController> tEmail = TextEditingController().obs;
  Rx<TextEditingController> tMobileNumber = TextEditingController().obs;
  Rx<TextEditingController> tPassword = TextEditingController().obs;
  Rx<TextEditingController> tCpassword = TextEditingController().obs;
  Rx<TextEditingController> tBriefProfile = TextEditingController().obs;
  Rx<DropdownRegion> tSelectedregion = DropdownRegion().obs;
  Rx<DropdownSchoolTeacher> tSelectedschool = DropdownSchoolTeacher().obs;
  Rx<CertificateList> tSelectedlevel = CertificateList().obs;
  Rx<CertificateList> tSelectedYearofexp = CertificateList().obs;
  Rx<CertificateList> tSelectedlanguage = CertificateList().obs;
  Rx<CertificateList> tSelectedcertificate = CertificateList().obs;
  Rx<CertificateList> tSelectedsubject = CertificateList().obs;
  Rx<DropdownClasses> tSelectedclass = DropdownClasses().obs;
  Rx<DropdownCountrycode> tSelectedcountrycode = Countries.ghana.obs;
  // DropdownCountrycode(countrycode: "233", country: "Ghana").obs;

  RxBool tisobsPass = true.obs;
  RxBool tisobscPass = true.obs;

  /// Verify Otp
  Rx<TextEditingController> tEmailotpcnt = TextEditingController().obs;
  Rx<TextEditingController> tPhoneotpcnt = TextEditingController().obs;

  ///

  RxList<DropdownCountrycode> get countryCodeList =>
      [Countries.ghana, Countries.india].obs;

  RxList<DropdownRegion> regionList = <DropdownRegion>[].obs;
  RxList<DropdownSchoolTeacher> schoolList = <DropdownSchoolTeacher>[].obs;

  Rx<SchoolFilterModel> schoolfilterModel = SchoolFilterModel().obs;
  Rx<RegionModel> regionModel = RegionModel().obs;
  Rx<StaticDataModel> staticdataModel = StaticDataModel().obs;
  RxList<CertificateList> levelList = <CertificateList>[].obs;
  RxList<CertificateList> yearsofExpList = <CertificateList>[].obs;
  RxList<CertificateList> languageList = <CertificateList>[].obs;
  RxList<CertificateList> certificateList = <CertificateList>[].obs;
  RxList<CertificateList> subjectList = <CertificateList>[].obs;
  RxList<DropdownClasses> classList = <DropdownClasses>[].obs;

  RxBool isteacher = true.obs;
  Rx<Color>? buttonColor = Color(0xffD9DFFC).obs;
  RxBool textChanged = false.obs;
  Rx<TeacherSignupModel> teacherSignupM = TeacherSignupModel().obs;
  Rx<StudentSignupModel> studentSignupM = StudentSignupModel().obs;
  Rx<FreelanceTeacher> teacherSignupData = FreelanceTeacher().obs;
  RxInt otpType = 0.obs;

  Future showConfirmSignupDialog({required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              // height: 400,
              width: 500,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Confirm Account Details",
                          style: (Responsive.isMobilenew(context))
                              ? FontStyleUtilities.h4(fontWeight: FWT.semiBold)
                              : FontStyleUtilities.h3(fontWeight: FWT.semiBold),
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            size: 22,
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              text: "Confirm your account details as ",
                              style: FontStyleUtilities.t1(
                                  fontColor: AppColors.black,
                                  fontWeight: FWT.regular),
                              children: [
                                TextSpan(
                                  text:
                                      "${(isteacher.value) ? "Freelance Teacher" : "Premium Learner"}.",
                                  style: FontStyleUtilities.t1(
                                      fontColor: AppColors.black,
                                      fontWeight: FWT.bold),
                                ),
                                TextSpan(
                                  text:
                                      " We will send you a verification code via email and SMS right now to validate the following details in the next step.",
                                  style: FontStyleUtilities.t1(
                                      fontColor: AppColors.black,
                                      fontWeight: FWT.regular),
                                ),
                              ],
                            ),
                          ),
                          // child: Text(
                          //   "Confirm your account details as ",
                          //   style: (Responsive.isMobilenew(context))
                          //       ? FontStyleUtilities.t1(fontWeight: FWT.regular)
                          //       : FontStyleUtilities.h5(
                          //           fontWeight: FWT.regular),
                          // ),
                        ),
                        h40,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email : ${(isteacher.value) ? tEmail.value.text : stEmail.value.text}",
                            style: FontStyleUtilities.t1(
                                fontColor: AppColors.black,
                                fontWeight: FWT.bold),
                          ),
                        ),
                        h10,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Phone : ${(isteacher.value) ? tMobileNumber.value.text : stMobileNumber.value.text}",
                            style: FontStyleUtilities.t1(
                                fontColor: AppColors.black,
                                fontWeight: FWT.bold),
                          ),
                        ),
                        h30,
                        Row(
                          children: [
                            Expanded(
                              child: LargeButton(
                                height:
                                    (Responsive.isMobilenew(context)) ? 40 : 50,
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  if (isteacher.value) {
                                    await signupTeacher(context);
                                  } else {
                                    await signupStudent(context);
                                  }
                                },
                                color: AppColors.green,
                                child: Text(
                                  "Confirm",
                                  style: (Responsive.isMobilenew(context))
                                      ? FontStyleUtilities.t1(
                                          fontColor: AppColors.white)
                                      : FontStyleUtilities.h5(
                                          fontColor: AppColors.white),
                                ),
                              ),
                            ),
                            w20,
                            Expanded(
                              child: LargeButton(
                                height:
                                    (Responsive.isMobilenew(context)) ? 40 : 50,
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Edit",
                                  style: (Responsive.isMobilenew(context))
                                      ? FontStyleUtilities.t1(
                                          fontColor: AppColors.white)
                                      : FontStyleUtilities.h5(
                                          fontColor: AppColors.white),
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
            ),
          );
        });
  }

//Get All Regions
  Future getAllRegions(context) async {
    try {
      // CustomLoadingIndicator.instance.show();

      await ApiService.instance
          .getHTTP(
        "${ApiRoutes.getAllregion}",
      )
          .then((value) {
        regionModel.value = RegionModel.fromJson(value.data);
        if (regionList.isEmpty) {
          regionModel.value.data?.circuits?.forEach((element) {
            regionList.add(
                DropdownRegion(district: element.regionTitle, enable: false));
            element.district?.forEach((e) {
              regionList.add(DropdownRegion(
                  district: e.districtTitle,
                  region: element.regionTitle,
                  enable: true));
            });
          });
        }
      });
      CustomLoadingIndicator.instance.hide();
    } on Exception catch (e) {
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }

//Get Static Data
  Future getStaticData(context) async {
    try {
      // CustomLoadingIndicator.instance.show();

      await ApiService.instance
          .getHTTP(
        "${ApiRoutes.getStaticdata}",
      )
          .then((value) {
        staticdataModel.value = StaticDataModel.fromJson(value.data);

        if (levelList.isEmpty) {
          staticdataModel.value.data?.levels?.forEach((element) {
            levelList.add(
                CertificateList(label: element.label, value: element.value));
          });
        }
        if (yearsofExpList.isEmpty) {
          staticdataModel.value.data?.yearsOfExperience?.forEach((element) {
            yearsofExpList.add(
                CertificateList(label: element.label, value: element.value));
          });
        }
        if (languageList.isEmpty) {
          staticdataModel.value.data?.languages?.forEach((element) {
            languageList.add(
                CertificateList(label: element.label, value: element.value));
          });
        }
        if (certificateList.isEmpty) {
          staticdataModel.value.data?.certificateList?.forEach((element) {
            certificateList.add(
                CertificateList(label: element.label, value: element.value));
          });
        }
        if (subjectList.isEmpty) {
          staticdataModel.value.data?.subjectsMaster?.forEach((element) {
            subjectList.add(
                CertificateList(label: element.label, value: element.value));
          });
        }
        if (classList.isEmpty) {
          staticdataModel.value.data?.classes?.forEach((element) {
            classList.add(DropdownClasses(label: element.label, enable: false));
            element.options?.forEach((element) {
              classList
                  .add(DropdownClasses(label: element.label, enable: true));
            });
          });
        }
      });
      CustomLoadingIndicator.instance.hide();
    } on Exception catch (e) {
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }

//Get All School Data
  Future getAllschoolData(
      {required String region, required String district}) async {
    try {
      // CustomLoadingIndicator.instance.show();
      log("region---$region------$district");
      await ApiService.instance
          .getHTTP("${ApiRoutes.getAllschooldata}", queryParameters: {
        "sc_region": region,
        "sc_district": district,
      }).then((value) {
        schoolfilterModel.value = SchoolFilterModel.fromJson(value.data);
        if (schoolList.isEmpty) {
          schoolfilterModel.value.data?.schools?.forEach((element) {
            schoolList.add(DropdownSchoolTeacher(
                tcSchoolId: element.scSchoolId,
                tcSchoolName: element.scSchoolName));
          });
        }
        log("school----${schoolList.length}");
      });
      // CustomLoadingIndicator.instance.hide();
    } on Exception catch (e) {
      log("error----" + e.toString());
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      // CustomLoadingIndicator.instance.hide();
    }
  }

  // Signup Teacher
  Future signupTeacher(BuildContext context) async {
    try {
      String mobileNo = tMobileNumber.value.text.split("").first == "0"
          ? tMobileNumber.value.text.replaceRange(0, 1, "")
          : tMobileNumber.value.text;
      CustomLoadingIndicator.instance.show();
      await ApiService.instance.postHTTP(
        url: "${ApiRoutes.signupTeacher}",
        body: {
          "tc_fullName": tFullname.value.text.trim(),
          "tc_email": tEmail.value.text.trim(),
          "tc_phoneNumber": mobileNo.trim(),
          "tc_password": tPassword.value.text.trim(),
          "tc_country": tSelectedcountrycode.value.toString(),
          "tc_countryCode":
              "+${tSelectedcountrycode.value.countrycode.toString()}",
          "tc_level": tSelectedlevel.value.value.toString(),
          "tc_experience": tSelectedYearofexp.value.value.toString(),
          "tc_certificate": tSelectedcertificate.value.value.toString(),
          "tc_briefProfile": tBriefProfile.value.text.trim(),
          "tc_region": tSelectedregion.value.region.toString(),
          "tc_district": tSelectedregion.value.district.toString(),
          "tc_circuit": null,
          "tc_languageSpoken": tSelectedlanguage.value.value.toString(),
          "tc_subject": tSelectedsubject.value.value.toString(),
          "tc_staffId": 0,
          "tc_schoolId": tSelectedschool.value.tcSchoolId.toString(),
          "tc_userType": 2,
          "isFirstTimeLogin": 0
        },
      ).then((value) async {
        teacherSignupM.value = TeacherSignupModel.fromJson(value.data);
        await AppPreference().setString("signupEmail", tEmail.value.text);
        await AppPreference()
            .setString("signupPhone", tMobileNumber.value.text);
        Map<String, dynamic> decodeData = teacherSignupM.value.toJson();
        String teacherSignupData = jsonEncode(SignInModel.fromJson(decodeData));
        await AppPreference()
            .setString(PreferencesKey.teacherSignupData, teacherSignupData);
        AppPreference().setBool(PreferencesKey.isLoggedIn, false);
        tFullname.value.clear();
        tEmail.value.clear();
        tMobileNumber.value.clear();
        tPassword.value.clear();
        tCpassword.value.clear();
        tBriefProfile.value.clear();
        tSelectedregion.value = DropdownRegion();
        tSelectedschool.value = DropdownSchoolTeacher();
        tSelectedlevel.value = CertificateList();
        tSelectedYearofexp.value = CertificateList();
        tSelectedlanguage.value = CertificateList();
        tSelectedcertificate.value = CertificateList();
        tSelectedsubject.value = CertificateList();
        tSelectedcountrycode.value = DropdownCountrycode();
        // if (schoolList.isEmpty) {
        //   schoolfilterModel.value.data?.schools?.forEach((element) {
        //     schoolList.add(DropdownSchoolTeacher(
        //         tcSchoolId: element.scSchoolId,
        //         tcSchoolName: element.scSchoolName));
        //   });
        // }
      });
      CustomLoadingIndicator.instance.hide();
      Get.toNamed(RoutesConst.emailVerificationPage);
    } on Exception catch (e) {
      log("error----" + e.toString());
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }

  // Signup Teacher
  Future signupStudent(BuildContext context) async {
    try {
      String mobileNo = stMobileNumber.value.text.split("").first == "0"
          ? stMobileNumber.value.text.replaceRange(0, 1, "")
          : stMobileNumber.value.text;
      CustomLoadingIndicator.instance.show();
      await ApiService.instance.postHTTP(
        url: "${ApiRoutes.signupStudent}",
        body: {
          "st_fullName": stFullname.value.text.toString().trim(),
          "st_email": stEmail.value.text.toString().trim(),
          "st_phoneNumber": int.parse(mobileNo.trim()),
          "st_countryCode":
              "+${stSelectedcountrycode.value.countrycode.toString().trim()}",
          "st_password": stPassword.value.text.toString().trim(),
          "st_schoolId": stSelectedschool.value.tcSchoolId.toString().trim(),
          "st_studentType": 2,
          "st_userType": 1,
          "st_class": stSelectedclass.value.label.toString().trim(),
          "st_parentName": stParentName.value.text.toString().trim(),
          "st_parentPhoneNumber":
              int.parse(stParentmobileNo.value.text.toString().trim()),
          "st_parentCountryCode":
              "+${stSelectedparentcountrycode.value.countrycode.toString().trim()}",
          "st_parentEmail": stParentemail.value.text.toString().trim(),
          "st_region": stSelectedregion.value.region.toString().trim(),
          "st_district": stSelectedregion.value.district.toString().trim(),
          "st_circuit": null,
          "isFirstTimeLogin": 0
        },
      ).then((value) async {
        studentSignupM.value = StudentSignupModel.fromJson(value.data);
        // teacherSignupM.value = TeacherSignupModel.fromJson(value.data);
        // Map<String, dynamic> decodeData = teacherSignupM.value.toJson();
        // String teacherSignupData = jsonEncode(SignInModel.fromJson(decodeData));
        // await AppPreference()
        //     .setString(PreferencesKey.teacherSignupData, teacherSignupData);
        await AppPreference().setString("signupEmail", stEmail.value.text);
        await AppPreference()
            .setString("signupPhone", stMobileNumber.value.text);
        AppPreference().setBool(PreferencesKey.isLoggedIn, false);
        stFullname.value.clear();
        stEmail.value.clear();
        stMobileNumber.value.clear();
        stPassword.value.clear();
        stCpassword.value.clear();
        stBriefProfile.value.clear();
        stSelectedregion.value = DropdownRegion();
        stSelectedschool.value = DropdownSchoolTeacher();
        stParentName.value.clear();
        stParentemail.value.clear();
        stParentmobileNo.value.clear();
        stSelectedcountrycode.value = DropdownCountrycode();
        stSelectedclass.value = DropdownClasses();
        stSelectedparentcountrycode.value = DropdownCountrycode();
        // if (schoolList.isEmpty) {
        //   schoolfilterModel.value.data?.schools?.forEach((element) {
        //     schoolList.add(DropdownSchoolTeacher(
        //         tcSchoolId: element.scSchoolId,
        //         tcSchoolName: element.scSchoolName));
        //   });
        // }
      });
      CustomLoadingIndicator.instance.hide();
      // Navigator.of(context).pushNamed(RoutesConst.emailVerificationPage);
      Get.toNamed(RoutesConst.emailVerificationPage);
    } on Exception catch (e) {
      log("error----" + e.toString());
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }

  Future verifyTeacherOtp(BuildContext context) async {
    try {
      CustomLoadingIndicator.instance.show();
      await ApiService.instance.postHTTP(
        url: "${ApiRoutes.verifyTeacherOtp}",
        body: {
          "otp": tEmailotpcnt.value.text,
          "email": AppPreference().getString("signupEmail"),
          "otpType": otpType.value
        },
      ).then((value) async {
        tEmailotpcnt.value.clear();
        tPhoneotpcnt.value.clear();
      });
      CustomLoadingIndicator.instance.hide();
      if (otpType.value == 1) {
        Navigator.of(context).pushNamed(RoutesConst.phoneVerificationPage);
      } else {
        Get.find<LoginCnt>().isLogin.value = true;
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   RoutesConst.loginPage,
        //   (route) => false,
        // );
        Navigator.of(context).pushNamed(RoutesConst.signupSuccessPage);
      }
    } on Exception catch (e) {
      log("error----" + e.toString());
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }

  Future verifyStudentOtp(BuildContext context) async {
    try {
      CustomLoadingIndicator.instance.show();
      await ApiService.instance.postHTTP(
        url: "${ApiRoutes.verifyStudentOtp}",
        body: {
          "otp": tEmailotpcnt.value.text,
          "email": AppPreference().getString("signupEmail"),
          "otpType": otpType.value
        },
      ).then((value) async {
        tEmailotpcnt.value.clear();
        tPhoneotpcnt.value.clear();
      });
      CustomLoadingIndicator.instance.hide();
      if (otpType.value == 1) {
        Navigator.of(context).pushNamed(RoutesConst.phoneVerificationPage);
      } else {
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   RoutesConst.loginPage,
        //   (route) => false,
        // );
        Navigator.of(context).pushNamed(RoutesConst.signupSuccessPage);
      }
    } on Exception catch (e) {
      log("error----" + e.toString());
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }

  Future resendTeacherOtp() async {
    try {
      CustomLoadingIndicator.instance.show();
      await ApiService.instance.postHTTP(
        url: "${ApiRoutes.resendTeacherOtp}",
        body: {
          "email": AppPreference().getString("signupEmail"),
          "type": otpType.value
        },
      ).then((value) async {
        tEmailotpcnt.value.clear();
        tPhoneotpcnt.value.clear();
        SnackBarService().showSnackBar(
            message: "Verification code has been sent",
            type: SnackBarType.success);
      });
      CustomLoadingIndicator.instance.hide();
    } on Exception catch (e) {
      log("error----" + e.toString());
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }

  Future resendStudentOtp() async {
    try {
      CustomLoadingIndicator.instance.show();
      await ApiService.instance.postHTTP(
        url: "${ApiRoutes.resendStudentOtp}",
        body: {
          "email": AppPreference().getString("signupEmail"),
          "type": otpType.value
        },
      ).then((value) async {
        tEmailotpcnt.value.clear();
        tPhoneotpcnt.value.clear();
        SnackBarService().showSnackBar(
            message: "Verification code has been sent",
            type: SnackBarType.success);
      });
      CustomLoadingIndicator.instance.hide();
    } on Exception catch (e) {
      log("error----" + e.toString());
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      CustomLoadingIndicator.instance.hide();
    }
  }
}
