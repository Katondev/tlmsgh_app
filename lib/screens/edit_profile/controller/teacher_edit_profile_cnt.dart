import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as formData;
import 'package:image_picker/image_picker.dart';
import 'package:katon/models/parent_profile_model.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/models/teacher_sign_in_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/services/parent_profile_service.dart';
import 'package:katon/services/parent_profile_update_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/services/teacher_profile_update_service.dart';
import 'package:katon/teacher/teacher_home_page.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/loading_indicator.dart';
import 'package:http_parser/http_parser.dart';

import '../../../models/region_model/region_model.dart';
import '../../../models/school_filter_model/school_filter_model.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/custom_dialog.dart';

class TeacherEditProfileCnt extends GetxController {
  XFile? imageFile;
  RxBool loading = false.obs;
  RxBool connection = false.obs;
  ImagePicker pick = ImagePicker();
  Rx<TextEditingController> fullName = TextEditingController().obs;
  Rx<TextEditingController> emailCnt = TextEditingController().obs;
  Rx<TextEditingController> altemailCnt = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> knownasCnt = TextEditingController().obs;
  Rx<TextEditingController> staffidCnt = TextEditingController().obs;
  Rx<TextEditingController> briefproCnt = TextEditingController().obs;

  final appbarCnt = Get.put(AppBarCnt());
  // TeacherProfileModel? teacherProfileModel;
  ParentProfileModel? parentProfileModel;
  Rx<Color>? buttonColor = Color(0xffD9DFFC).obs;

  // Rx<Teacher> teacher = Teacher().obs;
  // Rx<TeacherData> teacher = TeacherData().obs;
  TeacherSignInModel teacherProfileModel = TeacherSignInModel();
  Rx<Teacher> teacher = Teacher().obs;
  RxBool isLoading = false.obs;
  RxBool textChanged = false.obs;
  RxList<CertificatesList> certificateList = <CertificatesList>[].obs;
  Rx<CertificatesList> selectedCertificateVal = CertificatesList().obs;
  RxList<CertificatesList> levelList = <CertificatesList>[].obs;
  Rx<CertificatesList> selectedLevelVal = CertificatesList().obs;
  RxList<CertificatesList> languageList = <CertificatesList>[].obs;
  Rx<CertificatesList> selectedlanguageVal = CertificatesList().obs;
  RxString yearsofExpVal = "".obs;
  Rx<DropdownRegion> regionValue = DropdownRegion().obs;
  RxList<DropdownRegion> regionList = <DropdownRegion>[].obs;
  RxList<DropdownSchoolTeacher> schoolList = <DropdownSchoolTeacher>[].obs;
  Rx<DropdownSchoolTeacher> selectedSchoolValue = DropdownSchoolTeacher().obs;
  Rx<SchoolFilterModel> schoolfilterModel = SchoolFilterModel().obs;
  Rx<RegionModel> regionModel = RegionModel().obs;

  RxList<String> countryCodeList = [
    "233",
  ].obs;
  RxList<String> yearsofExpList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
  ].obs;

  RxString countrycode = "".obs;

  RxString? image =
      'https://images.pexels.com/photos/301920/pexels-photo-301920.jpeg?cs=srgb&dl=pexels-pixabay-301920.jpg&fm=jpg'
          .obs;

  showFirstTimeDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            message: "complete_profile".tr,
            title1: "ok".tr,
            onFirstButtonTap: () => Navigator.of(context).pop(),
            // child: Container(
            //   height: 100,
            //   width: 300,
            //   decoration: BoxDecoration(color: AppColors.white),
            // ),
          );
        });
  }

  showFirstTimeEditCompleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            message: "first_time_logged_in_detail".tr,
            title1: "ok".tr,
            onFirstButtonTap: () {
              AppPreference().setInt(PreferencesKey.isLoggedInFirstTimeT, 1);
              Get.offAll(() => TeacherHomePage());
            },
            // child: Container(
            //   height: 100,
            //   width: 300,
            //   decoration: BoxDecoration(color: AppColors.white),
            // ),
          );
        });
  }

  init(String? title) async {
    if (teacherProfileModel.data == null) {
      loading.value = false;
      connection.value = false;
    } else {
      loading.value = true;
      log("message");
      connection.value = true;
    }

    log("region-----${regionValue.value.region.toString()}");

    Map<String, dynamic> userData =
        jsonDecode(AppPreference().getString(PreferencesKey.teacherData));
    teacher.value = Teacher.fromJson(userData['data']['teacher']);
    teacherProfileModel = TeacherSignInModel.fromJson(userData);
    if (title == "teacher_profile".tr) {
      // await TeacherProfileServices()
      //     .getTeacherProfile()
      //     .then((value) => teacherProfileModel = value);
      log("full name   ${teacher.value.tcFullName}");
      image?.value = teacher.value.tcProfilePic ?? "";
      mobileNumber.value.text = "${teacher.value.tcPhoneNumber}";
      emailCnt.value.text = "${teacher.value.tcEmail}";
      fullName.value.text = teacher.value.tcFullName ?? "";
      countrycode.value = teacher.value.tcCountryCode.toString();
      altemailCnt.value.text = teacher.value.tcAltEmail ?? "";
      knownasCnt.value.text = teacher.value.tcAlsoKnownAs ?? "";
      staffidCnt.value.text = teacher.value.tcStaffId ?? "";
      briefproCnt.value.text = teacher.value.tcBriefProfile ?? "";

      certificateList.value = teacherProfileModel.data!.certificateList!;
      // selectedCertificateVal.value = teacherProfileModel.data!.certificateList!.;
      selectedCertificateVal.value = certificateList.firstWhere((element) {
        return element.value == teacher.value.tcCertificate.toString();
      });
      levelList.value = teacherProfileModel.data!.levels!;
      selectedLevelVal.value = levelList.firstWhere((element) {
        return element.value == teacher.value.tcLevel.toString();
      });
      languageList.value = teacherProfileModel.data!.languages!;
      selectedlanguageVal.value = languageList.firstWhere((element) {
        return element.value == teacher.value.tcLanguageSpoken.first.toString();
      });

      yearsofExpVal.value = teacher.value.tcExperience;
      languageList.value = teacherProfileModel.data!.languages!;
    } else {
      await ParentProfileServices()
          .getParentProfile()
          .then((value) => parentProfileModel = value);
      image?.value =
          parentProfileModel?.data?.parentProfile?.ptProfilePic ?? "";
      mobileNumber.value.text =
          "${parentProfileModel?.data?.parentProfile?.ptPhoneNumber}";
      emailCnt.value.text =
          "${parentProfileModel?.data?.parentProfile?.ptEmail}";
      fullName.value.text =
          "${parentProfileModel?.data?.parentProfile?.ptFullName}";
    }
    loading.value = false;
  }

  void getFromGallery() async {
    loading.value = true;
    XFile? pickedFile = await pick.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imageFile = pickedFile;
      image?.value = imageFile!.path;
      image?.value = imageFile!.path.split('/').last;
    }
    loading.value = false;
    // print("object${image?.value}");
  }

  Future teacherUpdateProfile() async {
    try {
      CustomLoadingIndicator.instance.show();
      loading.value = true;
      connection.value = true;
      // log("id---" + int.parse(mobileNumber.toString()).toString());
      await TeacherProfileUpdateServices()
          .updateTeacherProfile(
        tcId: 50,
        fullName: fullName.value.text,
        emailId: emailCnt.value.text,
        altEmail: altemailCnt.value.text,
        mobileNo: int.parse(mobileNumber.value.text.toString()).toString(),
        tcalsoKnownAs: knownasCnt.value.text,
        tcregion: regionValue.value.region,
        tcdistrict: regionValue.value.district,
        tcexperience: yearsofExpVal.value,
        tcstaffId: staffidCnt.value.text,
        tcschoolId: int.parse(selectedSchoolValue.value.tcSchoolId.toString()),
        tclevel: selectedLevelVal.value.value,
        tclanguageSpoken: selectedlanguageVal.value.value,
        tcBriefProfile: briefproCnt.value.text,
        tcCertificate: selectedCertificateVal.value.value,
      )
          .then((value) async {
        teacher.value = Teacher.fromJson(value?.data['data']?[1][0]);
        await AppPreference().setString(
            PreferencesKey.uName, teacher.value.tcFullName.toString());
        await AppPreference().setInt(PreferencesKey.staffId,
            int.parse(teacher.value.tcStaffId.toString()));
        await AppPreference()
            .setString(PreferencesKey.region, teacher.value.tcRegion!);
        await AppPreference()
            .setString(PreferencesKey.district, teacher.value.tcDistrict!);
        await AppPreference()
            .setString(PreferencesKey.staffId, staffidCnt.value.text.trim());
        if (selectedSchoolValue.value.tcSchoolId !=
            teacherProfileModel.data?.teacher?.tcSchoolId.toString()) {
          await AppPreference().setInt(
              PreferencesKey.schoolId,
              int.parse(
                  selectedSchoolValue.value.tcSchoolId.toString().trim()));
        }
      });
      Map<String, dynamic> userData =
          jsonDecode(AppPreference().getString(PreferencesKey.teacherData));
      final signIn = TeacherSignInModel.fromJson(userData);
      final updatedData = TeacherSignInModel(
          status: signIn.status,
          message: signIn.message,
          data: TeacherData(
            teacher: teacher.value,
            // classes: signIn.data?.classes,
            bloodGroups: signIn.data?.bloodGroups,
            certificateList: signIn.data?.certificateList,
            languages: signIn.data?.languages,
            levels: signIn.data?.levels,
            mainCategories: signIn.data?.mainCategories,
            subjects: signIn.data?.subjects,
            categories: signIn.data?.categories,
            subCategories: signIn.data?.subCategories,
          ));
      String teacherData = jsonEncode(updatedData);
      await AppPreference().setString(PreferencesKey.teacherData, teacherData);
      init("teacher_profile".tr);
      log("Edit success----${teacher}");
      CustomLoadingIndicator.instance.hide();
      loading.value = false;
      SnackBarService().showSnackBar(
          message: "teacher_updated_successfully".tr,
          type: SnackBarType.success);
      appbarCnt.getTeacherInfo();
    } catch (e) {
      if (e == "No Internet") {
        connection.value = false;
      }
      CustomLoadingIndicator.instance.hide();
      loading.value = false;
    }
  }

  Future updateProfilePic() async {
    String token = AppPreference().getString(PreferencesKey.token);
    try {
      // CustomLoadingIndicator.instance.show();
      loading.value = true;
      connection.value = true;
      var imageUpload = formData.FormData.fromMap({
        "tc_profilePic": await formData.MultipartFile.fromFile(
          imageFile!.path,
          filename: image?.value,
          contentType: MediaType("image", 'jpg'),
        ),
      });
      await ApiService.instance.putHTTP(
        url: "${ApiRoutes.updateProfilePicTeacher}${AppPreference().uId}",
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': "application/json"
        },
        body: imageUpload,
      );
      //     .then((value) {
      //   teacher.value = Teacher.fromJson(value.data["data"]['teacher']);
      // });
      Map<String, dynamic> userData =
          jsonDecode(AppPreference().getString(PreferencesKey.teacherData));

      final signIn = TeacherSignInModel.fromJson(userData);
      final updatedData = TeacherSignInModel(
          status: signIn.status,
          message: signIn.message,
          data: TeacherData(
            teacher: teacher.value,
            // classes: signIn.data?.classes,
            bloodGroups: signIn.data?.bloodGroups,
            certificateList: signIn.data?.certificateList,
            languages: signIn.data?.languages,
            levels: signIn.data?.levels,
            mainCategories: signIn.data?.mainCategories,
            subjects: signIn.data?.subjects,
            categories: signIn.data?.categories,
            subCategories: signIn.data?.subCategories,
          ));

      String teacherData = jsonEncode(updatedData);
      await AppPreference().setString(PreferencesKey.teacherData, teacherData);
    } catch (e) {
      print("error ${e}");
      if (e == "No Internet") {
        connection.value = false;
      }
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      // CustomLoadingIndicator.instance.hide();
      loading.value = false;
    }
  }

  Future parentUpdateProfile() async {
    try {
      // CustomLoadingIndicator.instance.show();
      loading.value = false;
      connection.value = true;
      await ParentProfileUpdateServices().updateParentProfile(
          emailId: emailCnt.value.text,
          fullName: fullName.value.text,
          mobileNo: mobileNumber.value.text);
      // CustomLoadingIndicator.instance.hide();
      loading.value = false;
    } catch (e) {
      if (e == "No Internet") {
        connection.value = false;
      }
      // CustomLoadingIndicator.instance.hide();
      loading.value = false;
    }
  }

  Future getAllRegions(context) async {
    try {
      if (teacherProfileModel.data == null) {
        loading.value = false;
        connection.value = false;
        // CustomLoadingIndicator.instance.hide();
      } else {
        // CustomLoadingIndicator.instance.show();
        loading.value = true;
        log("message");
        connection.value = true;
      }

      await ApiService.instance
          .getHTTP(
        "${ApiRoutes.getAllregion}",
      )
          .then((value) {
        regionModel.value = RegionModel.fromJson(value.data);
        regionList.clear();
        if (regionList.isEmpty) {
          log("region list---");
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
        log("region list---" + regionList.length.toString());
        regionValue.value = regionList.firstWhere((element) {
          log("ddd---------${element.region} == ${teacher.value.tcRegion} && ${element.district} == ${teacher.value.tcDistrict}");
          return (element.region == teacher.value.tcRegion &&
              element.district == teacher.value.tcDistrict);
        });

        getAllschoolData(
            region: regionValue.value.region.toString(),
            district: regionValue.value.district.toString());
      });
      // CustomLoadingIndicator.instance.hide();
      loading.value = false;
      if (AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeT) != 1) {
        Future.delayed(Duration(milliseconds: 100), () {
          showFirstTimeDialog(context);
        });
      }
    } on Exception catch (e) {
      log("${e}");
      if (e.toString() == "No Internet") {
        connection.value = false;
      }
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      // CustomLoadingIndicator.instance.hide();
      loading.value = false;
    }
  }

  Future getAllschoolData(
      {required String region, required String district}) async {
    try {
      // CustomLoadingIndicator.instance.show();
      log("region---$region------$district");
      connection.value = true;
      await ApiService.instance
          .getHTTP("${ApiRoutes.getAllschooldata}", queryParameters: {
        "sc_region": region,
        "sc_district": district,
      }).then((value) {
        schoolfilterModel.value = SchoolFilterModel.fromJson(value.data);
        if (schoolList.isEmpty) {
          schoolfilterModel.value.data?.schools?.forEach((element) {
            schoolList.add(DropdownSchoolTeacher(
                tcSchoolId: element.scId.toString(),
                tcSchoolName: element.scSchoolName));
          });
        }
        log("school----${schoolList.length}");

        // log("selected school----${selectedSchoolValue.value.scSchoolId}---${student.value.stSchoolId}");
        selectedSchoolValue.value = schoolList.firstWhere((element) {
          log("ddsdsd    ${element.tcSchoolId.toString()} ${teacherProfileModel.data?.teacher?.tcSchoolId.toString()}");
          return element.tcSchoolId ==
              teacherProfileModel.data?.teacher?.tcSchoolId.toString();
        });
        // } catch (e) {
        //   log("asas---" + e.toString());
        // }

        log("data fetched---${teacherProfileModel.data?.teacher?.tcSchoolId}");
        //  regionValue.value = regionList[1];
      });
      // CustomLoadingIndicator.instance.hide();
      loading.value = false;
    } on Exception catch (e) {
      log("error----" + e.toString());
      if (e == "No Internet") {
        connection.value = false;
      }
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      // CustomLoadingIndicator.instance.hide();
    }
  }

  bool checkColor() {
    if (mobileNumber.value.text !=
            teacherProfileModel.data?.teacher?.tcPhoneNumber ||
        countrycode.value !=
            teacherProfileModel.data?.teacher?.tcCountryCode.toString() ||
        fullName.value.text != teacherProfileModel.data?.teacher?.tcFullName ||
        emailCnt.value.text != teacherProfileModel.data?.teacher?.tcEmail ||
        altemailCnt.value.text !=
            teacherProfileModel.data?.teacher?.tcAltEmail ||
        knownasCnt.value.text !=
            teacherProfileModel.data?.teacher?.tcAlsoKnownAs ||
        staffidCnt.value.text != teacherProfileModel.data?.teacher?.tcStaffId ||
        selectedCertificateVal.value.value !=
            teacherProfileModel.data?.teacher?.tcCertificate ||
        yearsofExpVal.value !=
            teacherProfileModel.data?.teacher?.tcExperience ||
        selectedLevelVal.value.value !=
            teacherProfileModel.data?.teacher?.tcLevel ||
        regionValue.value.region !=
            teacherProfileModel.data?.teacher?.tcRegion ||
        regionValue.value.district !=
            teacherProfileModel.data?.teacher?.tcDistrict ||
        selectedSchoolValue.value.tcSchoolId !=
            teacherProfileModel.data?.teacher?.tcSchoolId.toString() ||
        selectedlanguageVal.value.value !=
            teacher.value.tcLanguageSpoken.first ||
        briefproCnt.value.text != teacher.value.tcBriefProfile) {
      log("--...${int.parse(mobileNumber.value.text).toString() != teacherProfileModel.data?.teacher?.tcPhoneNumber}");
      buttonColor?.value = AppColors.primary;
      return true;
    } else {
      buttonColor?.value = Color(0xffD9DFFC);
      return false;
    }
  }
}
