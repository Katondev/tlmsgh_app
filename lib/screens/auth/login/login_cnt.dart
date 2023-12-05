import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/models/elearning_model/sub_category_model.dart';
import 'package:katon/models/filter_category_model/filter_category_model.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/models/teacher_sign_in_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/services/api_service.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/teacher/teacher_home_page.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/drawer/drawer_cnt.dart';
import 'package:katon/widgets/loading_indicator.dart';
import '../../../widgets/responsive.dart';
import '../../edit_profile/student/edit_profile_page.dart';
import '../../edit_profile/teacher/teacher_edit_profile_page.dart';
import '../../edit_profile/teacher/teacher_edit_profile_tablet.dart';

class LoginCnt extends GetxController {
  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool isLoading = false.obs;
  RxBool value = false.obs;
  RxBool isLogin = true.obs;
  final cnt = Get.put(ELearningCnt());
  final dCnt = Get.put(DrawerCnt());
  SignInModel signInM = SignInModel();
  TeacherSignInModel teacherSignInModel = TeacherSignInModel();
  Teacher? teacher;
  Categories subCategories = Categories();
  RxInt radioIndex = 0.obs;
  TextEditingController loginCnt = TextEditingController(text: "");
  TextEditingController passwordCnt = TextEditingController(text: "");
  RxList<BookDetailsM> books = <BookDetailsM>[].obs;
  RxBool isObs = false.obs;

  bool isVerifiedEmail = false;
  bool isVerifiedPhone = false;

  Future onchangePressed(int index) async {
    radioIndex.value = index;
    log("radio val---${radioIndex}");
  }

  List loginList = [
    "student".tr,
    "teacher".tr,
    // "parent".tr,
  ];

  Future login(BuildContext context) async {
    if (passwordCnt.text != "" && loginCnt.text != "") {
      CustomLoadingIndicator.instance.show();
      try {
        if (radioIndex == 1) {
          /// Teacher Login
          await AppPreference().setString(PreferencesKey.uType, "Teacher");
          await TeacherLogin(context);
        } else if (radioIndex == 2) {
          /// Parent Login
          await AppPreference().setString(PreferencesKey.uType, "Parent");
          await ParentLogin();
        } else {
          /// Student Login
          await AppPreference().setString(PreferencesKey.uType, "Student");
          await StudentLogin(context);
        }
      } catch (e, t) {
        // SnackBarService()
        //     .showSnackBar(message: e.toString(), type: SnackBarType.error);
        log(t.toString());
        CustomLoadingIndicator.instance.hide();
      }
    } else {
      CustomLoadingIndicator.instance.hide();
      SnackBarService().showSnackBar(
          message: "valid_information".tr, type: SnackBarType.error);
    }
  }

  Future<void> redirectToForgotPasswordPage() async {
    if (radioIndex == 1) {
      /// Teacher Login
      loginCnt.clear();
      passwordCnt.clear();
      await AppPreference().setString(PreferencesKey.uType, "Teacher");
    } else if (radioIndex == 2) {
      /// Parent Login
      await AppPreference().setString(PreferencesKey.uType, "Parent");
    } else {
      /// Student Login
      loginCnt.clear();
      passwordCnt.clear();
      await AppPreference().setString(PreferencesKey.uType, "Student");
    }
    Get.toNamed(
      RoutesConst.forgetPassword,
    );
  }

  Future showVerifyDialog({required BuildContext context}) async {
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
                          "Account Verification",
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
                          child: Text(
                            "Please verify your account details.",
                            style: (Responsive.isMobilenew(context))
                                ? FontStyleUtilities.t1(fontWeight: FWT.regular)
                                : FontStyleUtilities.h5(
                                    fontWeight: FWT.regular),
                          ),
                        ),
                        h20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              radioIndex.value == 0
                                  ? signInM.data!.student!.stEmail!
                                  : teacherSignInModel.data!.teacher!.tcEmail!,
                              style: FontStyleUtilities.t1(
                                  fontWeight: FWT.semiBold),
                            ),
                            Text(
                              radioIndex.value == 0
                                  ? (signInM.data!.student!.stIsEmailVerified!)
                                      ? "Verified"
                                      : "Pending"
                                  : (teacherSignInModel
                                          .data!.teacher!.tcIsEmailVerified!)
                                      ? "Verified"
                                      : "Pending",
                              style: (Responsive.isMobilenew(context))
                                  ? FontStyleUtilities.t1(
                                      fontWeight: FWT.semiBold,
                                      fontColor: ((radioIndex.value == 0)
                                              ? signInM.data!.student!
                                                  .stIsEmailVerified!
                                              : teacherSignInModel.data!
                                                  .teacher!.tcIsEmailVerified!)
                                          ? AppColors.green
                                          : AppColors.black,
                                    )
                                  : FontStyleUtilities.h5(
                                      fontWeight: FWT.semiBold,
                                      fontColor: ((radioIndex.value == 0)
                                              ? signInM.data!.student!
                                                  .stIsEmailVerified!
                                              : teacherSignInModel.data!
                                                  .teacher!.tcIsEmailVerified!)
                                          ? AppColors.green
                                          : AppColors.black,
                                    ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "+${(radioIndex.value == 0) ? signInM.data!.student!.stCountryCode : teacherSignInModel.data!.teacher!.tcCountryCode!} ${(radioIndex.value == 0) ? signInM.data!.student!.stPhoneNumber : teacherSignInModel.data!.teacher!.tcPhoneNumber!}",
                              style: (Responsive.isMobilenew(context))
                                  ? FontStyleUtilities.t1(
                                      fontWeight: FWT.semiBold)
                                  : FontStyleUtilities.h5(
                                      fontWeight: FWT.semiBold),
                            ),
                            Text(
                              (radioIndex.value == 0)
                                  ? (signInM.data!.student!.stIsPhoneVerified!)
                                      ? "Verified"
                                      : "Pending"
                                  : (teacherSignInModel
                                          .data!.teacher!.tcIsPhoneVerified!)
                                      ? "Verified"
                                      : "Pending",
                              style: (Responsive.isMobilenew(context))
                                  ? FontStyleUtilities.t1(
                                      fontWeight: FWT.semiBold,
                                      fontColor: ((radioIndex.value == 0)
                                              ? signInM.data!.student!
                                                  .stIsPhoneVerified!
                                              : teacherSignInModel.data!
                                                  .teacher!.tcIsPhoneVerified!)
                                          ? AppColors.green
                                          : AppColors.black,
                                    )
                                  : FontStyleUtilities.h5(
                                      fontWeight: FWT.semiBold,
                                      fontColor: ((radioIndex.value == 0)
                                              ? signInM.data!.student!
                                                  .stIsPhoneVerified!
                                              : teacherSignInModel.data!
                                                  .teacher!.tcIsPhoneVerified!)
                                          ? AppColors.green
                                          : AppColors.black,
                                    ),
                            ),
                          ],
                        ),
                        h40,
                        LargeButton(
                          height: (Responsive.isMobilenew(context)) ? 40 : 50,
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (radioIndex.value == 0) {
                              if (!signInM.data!.student!.stIsEmailVerified! &&
                                  signInM.data!.student!.stIsPhoneVerified!) {
                                Navigator.of(context).pushNamed(
                                    RoutesConst.emailVerificationPage);
                              } else if (signInM
                                      .data!.student!.stIsEmailVerified! &&
                                  !signInM.data!.student!.stIsPhoneVerified!) {
                                Navigator.of(context).pushNamed(
                                    RoutesConst.phoneVerificationPage);
                              } else if (!signInM
                                      .data!.student!.stIsEmailVerified! &&
                                  !signInM.data!.student!.stIsPhoneVerified!) {
                                Navigator.of(context).pushNamed(
                                    RoutesConst.emailVerificationPage);
                                // Navigator.of(context)
                                //     .pushNamed(RoutesConst.signupSuccessPage);
                              }
                            } else {
                              if (!teacherSignInModel
                                      .data!.teacher!.tcIsEmailVerified! &&
                                  teacherSignInModel
                                      .data!.teacher!.tcIsPhoneVerified!) {
                                Navigator.of(context).pushNamed(
                                    RoutesConst.emailVerificationPage);
                              } else if (teacherSignInModel
                                      .data!.teacher!.tcIsEmailVerified! &&
                                  !teacherSignInModel
                                      .data!.teacher!.tcIsPhoneVerified!) {
                                Navigator.of(context).pushNamed(
                                    RoutesConst.phoneVerificationPage);
                              } else if (!teacherSignInModel
                                      .data!.teacher!.tcIsEmailVerified! &&
                                  !teacherSignInModel
                                      .data!.teacher!.tcIsPhoneVerified!) {
                                Navigator.of(context).pushNamed(
                                    RoutesConst.emailVerificationPage);
                                // Navigator.of(context)
                                //     .pushNamed(RoutesConst.signupSuccessPage);
                              }
                            }
                          },
                          child: Text(
                            "Verify Now",
                            style: (Responsive.isMobilenew(context))
                                ? FontStyleUtilities.t1(
                                    fontColor: AppColors.white)
                                : FontStyleUtilities.h5(
                                    fontColor: AppColors.white),
                          ),
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

  Future TeacherLogin(context) async {
    List<FilterCategoryModel> mainCategoryList = [];
    List<SubCategoryModel> subCategoryList = [];
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.teacherLogin,
            body: json.encode({
              "userName": loginCnt.text,
              "password": passwordCnt.text,
            }))
        .then((value) async {
      // signInM = SignInModel.fromJson(value.data);
      if (value.data["data"]["teacher"]["tc_status"] == 0) {
        CustomLoadingIndicator.instance.hide();
        teacherSignInModel = TeacherSignInModel(
          status: value.data["status"],
          message: value.data["message"],
          data: TeacherData(
              teacher: Teacher.fromJson(value.data["data"]["teacher"])),
        );
        isVerifiedEmail = teacherSignInModel.data!.teacher!.tcIsEmailVerified!;
        isVerifiedPhone = teacherSignInModel.data!.teacher!.tcIsPhoneVerified!;
        await AppPreference().setString(
            "signupEmail", teacherSignInModel.data!.teacher!.tcEmail!);
        await AppPreference().setString(
            "signupPhone", teacherSignInModel.data!.teacher!.tcPhoneNumber!);
        if (teacherSignInModel.data!.teacher!.tcIsEmailVerified! &&
            teacherSignInModel.data!.teacher!.tcIsPhoneVerified!) {
          // SnackBarService().showSnackBar(
          //     message:
          //         "Please wait, admin team will approve your account soon.",
          //     type: SnackBarType.error);
        } else {
          showVerifyDialog(context: context);
          log("dialog shown");
        }
        log("message---${teacherSignInModel.data!.teacher!.tcIsEmailVerified!}");
      } else {
        teacherSignInModel = TeacherSignInModel.fromJson(value.data);

        teacher = teacherSignInModel.data?.teacher;
        await AppPreference()
            .setString(PreferencesKey.token, '${value.data['data']['token']}');
        log("in....teacher--- ${AppPreference().getInt(PreferencesKey.uId)}=====${teacher?.tcId}");

        // if (teacher?.tcId != AppPreference().getInt(PreferencesKey.uId) &&
        //     AppPreference().getString(PreferencesKey.uType) == "Teacher") {
        //   log("in....");
        //   // log("library data----$libraryData");
        // }
        // await cnt.getLibraryBook();

        Map<String, dynamic> decodeData = teacherSignInModel.toJson();
        String teacherData =
            jsonEncode(TeacherSignInModel.fromJson(decodeData));
        await AppPreference()
            .setString(PreferencesKey.teacherData, teacherData);
        await AppPreference()
            .setString(PreferencesKey.staffId, teacher!.tcStaffId!);
        await AppPreference()
            .setInt(PreferencesKey.schoolId, teacher!.tcSchoolId!);
        await AppPreference()
            .setString(PreferencesKey.region, teacher!.tcRegion!);
        await AppPreference()
            .setString(PreferencesKey.district, teacher!.tcDistrict!);
        await AppPreference()
            .setString(PreferencesKey.level, teacher!.tcLevel!);
        // var data =
        //     jsonDecode(AppPreference().getString(PreferencesKey.teacherData));

        await AppPreference().setBool(
            PreferencesKey.isLoggedIn,
            AppPreference().getString(PreferencesKey.token) != ""
                ? true
                : false);
        await AppPreference().setString(PreferencesKey.uType, "Teacher");
        await AppPreference().setString(PreferencesKey.uName,
            "${teacherSignInModel.data?.teacher?.tcFullName}");
        await AppPreference()
            .setInt(PreferencesKey.uId, value.data['data']['teacher']['tc_id']);
        await AppPreference().setString(PreferencesKey.profilePic,
            "${teacherSignInModel.data?.teacher?.tcProfilePic}");

        await AppPreference().setString(PreferencesKey.categories,
            '${value.data['data']['subCategories']}');

        final dData = <FilterCategoryModel>[];
        // List<List<CategoryCategory>>? data = teacherSignInModel
        //     .data?.categories!
        //     .map((e) => e.category)
        //     .toList();

        teacherSignInModel.data?.categories!.forEach((element) {
          dData.add(FilterCategoryModel(
              // categoryId: element.categoryId,
              // categoryName: element.categoryName,
              maincategoryName: element.categoryName,
              isenabled: false));
          element.category.forEach((e) {
            dData.add(FilterCategoryModel(
              categoryId: e.categoryId,
              categoryName: e.categoryName,
              maincategoryName: element.categoryName,
              isenabled: true,
            ));
          });
          // teacherSignInModel.data?.categories!
          //     .map((e) => e.category)
          //     .toList()
          //     .map((ee) => ee
          //         .map((e) => CategoryModel(
          //               subcategory: e.subCategory
          //                   .map((eee) => SubCategoryModel(
          //                       categoryId: e.categoryId,
          //                       categoryName: e.categoryName,
          //                       subCategoryId: eee.subCateId))
          //                   .toList(),
          //               categoryId: e.categoryId,
          //               categoryName: e.categoryName,
          //               isenabled: true,
          //             ))
          //         .toList())
          //     .toList()
          //     .forEach((element_) {
          //   dData.addAll(element_);
          // });
        });

        mainCategoryList.addAll(dData);
        mainCategoryList.forEach((e) {
          log("main----" + e.maincategoryName.toString());
          log("category----" + e.categoryName.toString());
          log("isenable----" + e.isenabled.toString());
        });
        log("category length----${mainCategoryList.length}");
        // log("length---------++--${signInM.data?.categories?.length}");

        // teacherSignInModel.data?.categories?.forEach((mainCategory) {
        //   mainCategory.category.forEach((category) {
        //     mainCategoryList.add(CategoryModel(
        //       categoryId: category.categoryId,
        //       categoryName: category.categoryName,
        //     ));
        //     category.subCategory.forEach((subCategory) {
        //       subCategoryList.add(SubCategoryModel(
        //         categoryId: category.categoryId,
        //         categoryName: subCategory.subCateName,
        //         subCategoryId: subCategory.subCateId,
        //       ));
        //     });
        //   });
        // });
        final String encodedData = json.encode(
            mainCategoryList.map((e) => FilterCategoryModel.toMap(e)).toList());
        await AppPreference()
            .setString(PreferencesKey.mainCategory, encodedData);

        /// Store sub category in list
        final String subCategoryEncodedData =
            SubCategoryModel.encode(subCategoryList);
        await AppPreference()
            .setString(PreferencesKey.subCategory, subCategoryEncodedData);

        Map<String, dynamic> decodedData = teacherSignInModel.toJson();
        String teacherdData =
            jsonEncode(TeacherSignInModel.fromJson(decodedData));
        await AppPreference()
            .setString(PreferencesKey.teacherData, teacherdData);
        await AppPreference().setBool(PreferencesKey.isLoggedIn, true);
        await AppPreference().setBool(PreferencesKey.isTeacherLoggedIn, true);
        String libraryData =
            AppPreference().getString(PreferencesKey.myLibraryData);

        // if (cnt.books.isEmpty) {
        //   log("library data----$libraryData");
        //   await cnt.getLibraryBook();
        // }
        CustomLoadingIndicator.instance.hide();

        AppPreference().setInt(
            PreferencesKey.isLoggedInFirstTimeT, teacher!.isFirstTimeLogin!);
        if (teacher!.isFirstTimeLogin! != 1) {
          // AppPreference().setBool(PreferencesKey.isFirstTime, true);
          Get.offAll(() => TeacherEditProfilePage(
              arguments:
                  StudentRouteArguments().getArgument(RoutesConst.editProfile),
              title: 'teacher_profile'.tr));
          dCnt.index.value = 13;
        } else if (teacherSignInModel.data?.teacher?.isFirstTimeLogin == 1 &&
            teacherSignInModel.data?.teacher?.tcStatus == 1) {
          Get.offAll(() => TeacherHomePage());
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     RoutesConst.teacherHome, (route) => false);
        }
      }
    });
  }

  Future ParentLogin() async {
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.parentsLogin,
            body: json.encode({
              "userName": loginCnt.text,
              "password": passwordCnt.text,
            }))
        .then((value) async {
      signInM = SignInModel.fromJson(value.data);
      await AppPreference()
          .setString(PreferencesKey.token, '${value.data['data']['token']}');
    });
    AppPreference().setBool(PreferencesKey.isLoggedIn, false);
    AppPreference().setBool(PreferencesKey.isTeacherLoggedIn, false);
    await AppPreference().setString(PreferencesKey.uType, "Parent");
    // SnackBarService().showSnackBar(
    //     message: signInM.message, type: SnackBarType.success);
    CustomLoadingIndicator.instance.hide();
    Get.off(() => TeacherEditProfileTablet(
        arguments: StudentRouteArguments().getArgument(RoutesConst.editProfile),
        title: 'Parent Edit Profile'));
  }

  Future StudentLogin(context) async {
    List<FilterCategoryModel> mainCategoryList = [];
    List<Subject> subjectList = [];
    List<Topics> topicsList = [];
    List<SubCategoryModel> subCategoryList = [];
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.login,
            body: json.encode({
              "userName": loginCnt.text,
              "password": passwordCnt.text,
            }))
        .then((value) async {
      // String libraryData =
      //     AppPreference().getString(PreferencesKey.myLibraryData);
      log(value.data.toString());
      if (value.data["data"]["student"]["st_status"] == 0) {
        CustomLoadingIndicator.instance.hide();
        signInM = SignInModel(
          status: value.data["status"],
          message: value.data["message"],
          data: SignInData(
              student: Student.fromJson(value.data["data"]["student"])),
        );
        isVerifiedEmail = signInM.data!.student!.stIsEmailVerified!;
        isVerifiedPhone = signInM.data!.student!.stIsPhoneVerified!;
        await AppPreference()
            .setString("signupEmail", signInM.data!.student!.stEmail!);
        await AppPreference()
            .setString("signupPhone", signInM.data!.student!.stPhoneNumber!);
        if (isVerifiedEmail && isVerifiedPhone) {
          // SnackBarService().showSnackBar(
          //     message:
          //         "Please wait, admin team will approve your account soon.",
          //     type: SnackBarType.error);
        } else {
          showVerifyDialog(context: context);
          log("dialog shown");
        }
        log("message---${isVerifiedEmail}");
      } else {
        signInM = SignInModel.fromJson(value.data);

        await AppPreference()
            .setString(PreferencesKey.token, '${value.data['data']['token']}');
        log("in....student--- ${AppPreference().getInt(PreferencesKey.uId)}=====${signInM.data?.student?.stId}");
        if (signInM.data?.student?.stId !=
                AppPreference().getInt(PreferencesKey.uId) &&
            AppPreference().getString(PreferencesKey.uType) == "Student") {
          log("in....");
          // log("library data----$libraryData");
          // await cnt.getLibraryBook();
        }

        await AppPreference().setString(PreferencesKey.uType, "Student");
        await AppPreference()
            .setString(PreferencesKey.region, signInM.data!.student!.stRegion!);
        await AppPreference().setString(
            PreferencesKey.student_level,'JHS');
        await AppPreference()
            .setString(PreferencesKey.level, 'JHS');
        await AppPreference().setString(
            PreferencesKey.district, signInM.data!.student!.stDistrict!);
        log("uType" + AppPreference().getString(PreferencesKey.uType));
        await AppPreference().setString(
            PreferencesKey.uName, "${signInM.data?.student?.stFullName}");
        await AppPreference().setString(PreferencesKey.profilePic,
            "${signInM.data?.student?.stProfilePic}");
        await AppPreference()
            .setInt(PreferencesKey.uId, signInM.data?.student?.stId ?? 0);

        await AppPreference().setString(PreferencesKey.categories,
            '${value.data['data']['subCategories']}');
        await AppPreference().setString(PreferencesKey.topic,
            '${json.encode(value.data['data']['topics'])}');
        await AppPreference()
            .setInt(PreferencesKey.student_Id, signInM.data!.student!.stId!);
        if (signInM.data!.student!.stClassRoomId != null) {
          await AppPreference().setInt(PreferencesKey.student_class_Id,
              signInM.data!.student!.stClassRoomId!);
        }
        await AppPreference().setInt(PreferencesKey.student_school_Id,
            signInM.data!.student!.stSchoolId!);
        await AppPreference().setString(
            PreferencesKey.student_class, signInM.data!.student!.stClass!);
        // log("data----" + signInM.data!.student!.stSchoolId!.toString());

        final dData = <FilterCategoryModel>[];
        List<Categories> categories = <Categories>[];
        categories = (signInM.data?.categories?.where((element) =>
                    !(element.categoryName?.contains("Teacher") ?? true)) ??
                [])
            .toList();
        log("ddddddd----${categories.length}");
        categories.forEach((element) {
          dData.add(FilterCategoryModel(
              // categoryId: element.categoryId,
              // categoryName: element.categoryName,
              maincategoryName: element.categoryName,
              isenabled: false));
          element.category?.forEach((e) {
            dData.add(FilterCategoryModel(
              categoryId: e.categoryId,
              categoryName: e.categoryName,
              maincategoryName: element.categoryName,
              isenabled: true,
            ));
          });
        });

        mainCategoryList.addAll(dData);
        subjectList.addAll(signInM.data!.subjectList!);
        log("category length----${mainCategoryList.length}");
        dData.forEach((e) {
          log("main----" + e.maincategoryName.toString());
          log("category----" + e.categoryName.toString());
          log("isenable----" + e.isenabled.toString());
        });
        log("length---------++--${signInM.data?.categories?.length}");

        ///
        /// Store main category in list
        final String encodedData = jsonEncode(
            mainCategoryList.map((e) => FilterCategoryModel.toMap(e)).toList());
        await AppPreference()
            .setString(PreferencesKey.mainCategory, encodedData);
        final String encodedSubject =
            jsonEncode(subjectList.map((e) => Subject.toMap(e)).toList());
        await AppPreference().setString(PreferencesKey.subject, encodedSubject);

        /// Store sub category in list
        final String subCategoryEncodedData =
            SubCategoryModel.encode(subCategoryList);
        await AppPreference()
            .setString(PreferencesKey.subCategory, subCategoryEncodedData);
        print(
            "Main category-----${AppPreference().getString(PreferencesKey.mainCategory)}");
        print(
            "Sub category-----${AppPreference().getString(PreferencesKey.subCategory)}");
        print(
            "Subject-----${AppPreference().getString(PreferencesKey.subject)}");

        /// continue
        Map<String, dynamic> decodeData = signInM.toJson();
        String studentData = jsonEncode(SignInModel.fromJson(decodeData));
        await AppPreference()
            .setString(PreferencesKey.studentData, studentData);

        CustomLoadingIndicator.instance.hide();
        await AppPreference().setBool(PreferencesKey.isLoggedIn, true);
        await AppPreference().setBool(PreferencesKey.isTeacherLoggedIn, false);

        await AppPreference().setInt(PreferencesKey.isLoggedInFirstTimeSt,
            signInM.data!.student!.isFirstTimeLogin!);
        log("st----${AppPreference().getInt(PreferencesKey.isLoggedInFirstTimeSt).toString()}");

        ///
        if (signInM.data?.student?.isFirstTimeLogin != 1 &&
            signInM.data!.student!.stStatus == 1) {
          // await cnt.getLibraryBook();
          // AppPreference().setBool(PreferencesKey.isFirstTime, true);
          Get.offAll(() => EditProfilePage(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.editProfile),
                title: "student_profile".tr,
              ));
          dCnt.index.value = 13;
        } else if (signInM.data?.student?.isFirstTimeLogin == 1 &&
            signInM.data!.student!.stStatus == 1) {
          dCnt.index.value = 1;
          Get.offAll(() => HomePage());
          // navigatorKey.currentState
          //     ?.pushNamedAndRemoveUntil(RoutesConst.home, (route) => false);
        }
      }
    });
  }
}
