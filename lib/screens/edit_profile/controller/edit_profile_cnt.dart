import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as formData;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katon/models/region_model/region_model.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/services/auth_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/drawer/drawer_cnt.dart';
import 'package:katon/widgets/loading_indicator.dart';
import 'package:http_parser/http_parser.dart';

import '../../../models/school_filter_model/school_filter_model.dart';
import '../../../widgets/custom_dialog.dart';
import '../../home_page.dart';

class EditProfileCnt extends GetxController {
  DateTime selectedDatePick = DateTime.now();
  final formKey = GlobalKey<FormState>();
  RxString selectedBlood = "Select Blood Group".obs;
  Rx<Color>? buttonColor = AppColors.primaryYellow.obs;
  // Rx<Color>? buttonColor = Colors.black.obs;
  RxBool textChanged = false.obs;
  RxBool connection = false.obs;

  // RxList<String> areaList = const [
  //   'Select area',
  //   'berlin',
  //   'tokyo',
  //   'rio',
  //   'Ahafo',
  //   'Northern Region',
  //   'cuba',
  //   'Mexico'
  // ].obs;
  // RxList<String> schoolList = const [
  //   'Select school name',
  //   'berlin',
  //   'tokyo',
  //   'rio',
  //   'Ahafo',
  //   'Northern Region',
  //   'cuba',
  //   'Mexico'
  // ].obs;

  RxList<String> countryCodeList = [
    "233",
  ].obs;

  RxString selectedArea = "".obs;
  RxString selectedSchool = "".obs;

  Rx<Student> student = Student().obs;
  SignInModel signIn = SignInModel();
  final cnt = Get.put(DrawerCnt());
  final appbarCnt = Get.put(AppBarCnt());
  RxList<String> bloodList = <String>[].obs;
  RxList<String> divisionList = <String>[].obs;
  RxString countrycode = "".obs;
  RxString classNumber = "Kindergarten".obs;
  Rx<DropdownClasses> classValue = DropdownClasses().obs;
  RxList<DropdownClasses> classList = <DropdownClasses>[].obs;
  Rx<DropdownRegion> regionValue = DropdownRegion().obs;
  RxList<DropdownRegion> regionList = <DropdownRegion>[].obs;
  RxList<DropdownSchool> schoolList = <DropdownSchool>[].obs;
  RxList<String> classListLabel = <String>[].obs;
  Rx<DropdownSchool> selectedSchoolValue = DropdownSchool().obs;

  String selectedDate = "";
  // RxBool isEditProfile = false.obs;

  Rx<TextEditingController> dateCnt = TextEditingController().obs;
  Rx<TextEditingController> fullName = TextEditingController().obs;
  Rx<TextEditingController> parentName = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> alternativeNumber = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> emailCnt = TextEditingController().obs;
  Rx<TextEditingController> altemailCnt = TextEditingController().obs;
  Rx<TextEditingController> stIdCnt = TextEditingController().obs;
  Rx<TextEditingController> parentmobileNumber = TextEditingController().obs;
  Rx<TextEditingController> parentemail = TextEditingController().obs;
  RxString divisionNumber = "Select Division".obs;

  ImagePicker pick = ImagePicker();

  // XFile? imageFile;

  RxString? image = "".obs;
  // 'https://images.pexels.com/photos/301920/pexels-photo-301920.jpeg?cs=srgb&dl=pexels-pixabay-301920.jpg&fm=jpg'
  //     .obs;
  RxBool isLoading = false.obs;
  RxBool loading = false.obs;
  Student students = Student();
  SignInModel signInM = SignInModel();
  Rx<RegionModel> regionModel = RegionModel().obs;
  Rx<SchoolFilterModel> schoolfilterModel = SchoolFilterModel().obs;

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
              AppPreference().setInt(PreferencesKey.isLoggedInFirstTimeSt, 1);
              Get.offAll(() => HomePage());
            },
            // child: Container(
            //   height: 100,
            //   width: 300,
            //   decoration: BoxDecoration(color: AppColors.white),
            // ),
          );
        });
  }

  Future updateProfile() async {
    try {
      CustomLoadingIndicator.instance.show();
      connection.value = true;
      await AuthServices()
          .updateProfileAuth(
        st_fullName: fullName.value.text,
        st_email: emailCnt.value.text,
        st_altEmail: altemailCnt.value.text,
        st_id: int.parse(stIdCnt.value.text),
        st_region: regionValue.value.region.toString(),
        st_district: regionValue.value.district.toString(),
        // sc_schoolName: selectedSchoolValue.value,
        sc_schoolId: int.parse(selectedSchoolValue.value.scSchoolId.toString()),
        st_countrycode: countrycode.value,
        st_phoneNumber:
            int.parse(mobileNumber.value.text.toString()).toString(),
        st_address: address.value.text,

        st_class: classValue.value.label.toString(),
        stLevel: classValue.value.level.toString(),
        st_division: divisionNumber.value,
        // st_dateOfBirth: dateCnt.value.text,
        st_parentName: parentName.value.text,
        st_parentPhoneNumber:
            int.parse(parentmobileNumber.value.text.toString()).toString(),
        st_parentEmail: parentemail.value.text,
        // isFirstTimeLogin: 1,
      )
          .then((value) {
        students = Student.fromJson(value?.data['data'][1][0]);
        AppPreference()
            .setString(PreferencesKey.uName, students.stFullName.toString());
      });

      Map<String, dynamic> userData =
          jsonDecode(AppPreference().getString(PreferencesKey.studentData));
      final signIn = SignInModel.fromJson(userData);
      final updatedData = SignInModel(
          status: signIn.status,
          message: signIn.message,
          data: SignInData(
            student: students,
            classes: signIn.data?.classes,
            bloodGroups: signIn.data?.bloodGroups,
            divisions: signIn.data?.divisions,
            categories: signIn.data?.categories,
          ));
      String studentData = jsonEncode(updatedData);
      await AppPreference().setString(PreferencesKey.studentData, studentData);
      getStudentInfo();
      CustomLoadingIndicator.instance.hide();
      SnackBarService().showSnackBar(
          message: "student_updated_successfully".tr,
          type: SnackBarType.success);
      appbarCnt.getStudentInfo();
    } catch (e) {
      CustomLoadingIndicator.instance.hide();
      if (e == "No Internet") {
        connection.value = false;
      }
      rethrow;
    }
  }

  void getStudentInfo() async {
    try {
      bloodList.clear();
      classList.clear();
      isLoading.value = true;
      connection.value = true;
      Map<String, dynamic> userData =
          jsonDecode(AppPreference().getString(PreferencesKey.studentData));
      student.value = Student.fromJson(userData['data']['student']);
      // print("student division${student.value.stDivision}");
      signIn = SignInModel.fromJson(userData);
      // print("division list${divisionList}");
      if (divisionList.isEmpty) {
        print("division list${divisionList}>>>${divisionList.length}");
        signIn.data?.divisions?.forEach((element) {
          divisionList.add(element);
        });
      }
      print("division list${divisionList}>>>${divisionList.length}");
      if (bloodList.isEmpty) {
        bloodList.add('Select Blood Group');
        signIn.data?.bloodGroups?.forEach((element) {
          bloodList.add(element);
        });
      }
      if (classList.isEmpty) {
        signIn.data?.classes?.forEach((e) {
          classList.add(
              DropdownClasses(level: e.label, label: e.label, enable: false));
          e.options?.forEach((element) {
            classList.add(DropdownClasses(
                level: e.label, label: element.label, enable: true));
            log("classes---${element.label}");
          });
        });
      }
      classValue.value = classList[1];
      // classValue.value =
      //     DropdownClasses(label: signIn.data?.student?.stClass, enable: true);

      // log("data iii----${signIn.data!.student!.stClass.toString()}");

      fullName.value.text = student.value.stFullName ?? "";
      classValue.value.label = student.value.stClass ?? "SHS 2";
      divisionNumber.value = student.value.stDivision?.isEmpty ?? true
          ? "A"
          : student.value.stDivision!;
      emailCnt.value.text = student.value.stEmail ?? "";
      dateCnt.value.text = student.value.stDateOfBirth ?? "";
      parentName.value.text = student.value.stParentName ?? "";
      mobileNumber.value.text = student.value.stPhoneNumber ?? "";
      alternativeNumber.value.text = student.value.stAltPhoneNumber ?? "";
      image?.value = student.value.stProfilePic ?? "";
      address.value.text = student.value.stAddress ?? "";
      selectedBlood.value = student.value.stBloodGroup?.isEmpty ?? true
          ? "Select Blood Group"
          : student.value.stBloodGroup ?? "Select Blood Group";

      // regionValue.value = regionList.firstWhere((element) =>
      //     (element.region == student.value.stRegion &&
      //         element.district == student.value.stDistrict));
      // getAllschoolData(
      //     region: regionValue.value.region.toString(),
      //     district: regionValue.value.district.toString());

      log("region-district------${regionValue.value.region}----${regionValue.value.district}");

      log("school---------${student.value.stSchoolId.toString()}");

      ///
      countrycode.value = student.value.stCountryCode.toString();
      parentmobileNumber.value.text =
          (student.value.stParentPhoneNumber == null)
              ? ""
              : student.value.stParentPhoneNumber.toString();
      parentemail.value.text = (student.value.stParentEmail == null)
          ? ""
          : student.value.stParentEmail.toString();
      altemailCnt.value.text = (student.value.stAltEmail == null)
          ? ""
          : student.value.stAltEmail.toString();
      stIdCnt.value.text =
          (student.value.stId == null) ? "" : student.value.stId.toString();

      // : student.value.stRegion ?? "Select area";
      print("divisionNumber>>>${divisionNumber}");
      log("selected area>>>${selectedArea.value}");
      isLoading.value = false;
    } on Exception {
      isLoading.value = false;
    }
  }

  // void getFromGallery() async {
  //   loading.value = true;
  //   XFile? pickedFile = await pick.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedFile != null) {
  //     imageFile = pickedFile;
  //     image?.value = imageFile!.path;
  //     image?.value = imageFile!.path.split('/').last;
  //   }
  //   loading.value = false;
  // }
 
  XFile? image1;
  double uploadProgress = 0.0;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    
      image1 = pickedImage;
    
  }

  Future updateProfilePic() async {
    String token = AppPreference().getString(PreferencesKey.token);
    try {
      // CustomLoadingIndicator.instance.show();
      loading.value = true;
      connection.value = true;
      if (image1 != null) {
      var imageUpload = formData.FormData.fromMap({
        "st_profilePic": await formData.MultipartFile.fromFile(
          image1!.path,
          filename: "cafeteria.png",
          // contentType: MediaType("image", 'jpg'),
        ),
      });
      await ApiService.instance
          .putHTTP(
        url: "${ApiRoutes.updateProfilePic}${student.value.stId}?from=studentApp&key=xsv321sa2ds4235reuy354FE4rsd",
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': "application/json"
        },
        onSendProgress: (int sent, int total){
          uploadProgress = sent / total;
          
        },
        body: imageUpload,
      )
          .then((value) {
            print(value.data['data']);
        students = Student.fromJson(value.data["data"]['student'][1][0]);
      });
      }
      Map<String, dynamic> userData =
          jsonDecode(AppPreference().getString(PreferencesKey.studentData));

      final signIn = SignInModel.fromJson(userData);
      final updatedData = SignInModel(
          status: signIn.status,
          message: signIn.message,
          data: SignInData(
            student: students,
            classes: signIn.data?.classes,
            bloodGroups: signIn.data?.bloodGroups,
            divisions: signIn.data?.divisions,
            categories: signIn.data?.categories,
          ));

      String studentData = jsonEncode(updatedData);
      await AppPreference().setString(PreferencesKey.studentData, studentData);
      loading.value = false;
    } on Exception catch (e) {
      if (e == "No Internet") {
        connection.value = false;
      }
      SnackBarService()
          .showSnackBar(message: e.toString(), type: SnackBarType.error);
      // CustomLoadingIndicator.instance.hide();
      loading.value = false;
    }
  }

  Future getAllRegions(context) async {
    try {
      // CustomLoadingIndicator.instance.show();
      connection.value = true;
      loading.value = true;
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
        regionValue.value = regionList.firstWhere((element) =>
            (element.region == student.value.stRegion &&
                element.district == student.value.stDistrict));
        getAllschoolData(
            region: regionValue.value.region.toString(),
            district: regionValue.value.district.toString());
      });
      // CustomLoadingIndicator.instance.hide();
      loading.value = false;
      if (AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeSt) != 1) {
        Future.delayed(Duration(milliseconds: 100), () {
          showFirstTimeDialog(context);
        });
      }
    } on Exception catch (e) {
      if (e == "No Internet") {
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
            schoolList.add(DropdownSchool(
                scSchoolId: element.scSchoolId,
                scSchoolName: element.scSchoolName));
          });
        }
        log("school----${schoolList.length}");

        selectedSchoolValue.value = schoolList.firstWhere((element) {
          log("ddsdsd    ${element.scSchoolId.toString()} ${student.value.stSchoolId.toString()}");
          return element.scSchoolId == student.value.stSchoolId.toString();
        });

        log("data fetched---${selectedSchoolValue.value}");
        //  regionValue.value = regionList[1];
      });
      // CustomLoadingIndicator.instance.hide();
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
    if (fullName.value.text != student.value.stFullName.toString() ||
        classValue.value.label != student.value.stClass.toString() ||
        divisionNumber.value != student.value.stDivision.toString() ||
        emailCnt.value.text != student.value.stEmail.toString() ||
        mobileNumber.value.text != student.value.stPhoneNumber.toString() ||
        image?.value != student.value.stProfilePic ||
        address.value.text != student.value.stAddress.toString() ||
        altemailCnt.value.text != student.value.stAltEmail.toString() ||
        stIdCnt.value.text != student.value.stId.toString() ||
        parentName.value.text != student.value.stParentName.toString() ||
        parentmobileNumber.value.text !=
            student.value.stParentPhoneNumber.toString() ||
        parentemail.value.text != student.value.stParentEmail.toString() ||
        regionValue.value.region != student.value.stRegion ||
        regionValue.value.district != student.value.stDistrict ||
        selectedSchoolValue.value.scSchoolId !=
            student.value.stSchoolId.toString()) {
      // print(
      //     "dsd-----${classValue.value.label}----${student.value.stClass}------${classValue.value.label != student.value.stClass.toString()}");
      // log("--...${stIdCnt.value.text != student.value.stId}");
      buttonColor?.value = AppColors.primaryYellow;
      return true;
    } else {
      buttonColor?.value = Color(0xffD9DFFC);
      return false;
    }
  }
}
