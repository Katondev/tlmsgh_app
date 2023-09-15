import 'dart:convert';
import 'dart:developer';

import 'package:katon/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static final AppPreference _appPreference = AppPreference._internal();

  factory AppPreference() {
    return _appPreference;
  }

  AppPreference._internal();

  SharedPreferences? _preferences;

  Future<void> initialAppPreference() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  String getString(String key, {String defValue = ''}) {
    return _preferences?.getString(key) != null
        ? (_preferences?.getString(key) ?? '')
        : defValue;
  }

  Future setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  int getInt(String key, {int defValue = 0}) {
    return _preferences?.getInt(key) != null
        ? (_preferences?.getInt(key) ?? 0)
        : defValue;
  }

  Future setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  bool getBool(String key, {bool defValue = false}) {
    return _preferences?.getBool(key) ?? defValue;
  }

  Future clearSharedPreferences() async {
    await _preferences?.clear();
    // await _preferences!.remove(PreferencesKey.categories);
    // await _preferences!.remove(PreferencesKey.introPage);
    // await _preferences!.remove(PreferencesKey.isLoggedIn);
    // await _preferences!.remove(PreferencesKey.isLoggedInFirstTimeSt);
    // await _preferences!.remove(PreferencesKey.isLoggedInFirstTimeT);
    // await _preferences!.remove(PreferencesKey.isTeacherLoggedIn);
    // await _preferences!.remove(PreferencesKey.language);
    // await _preferences!.remove(PreferencesKey.mainCategory);
    // await _preferences!.remove(PreferencesKey.notificationData);
    // await _preferences!.remove(PreferencesKey.studentData);
    // await _preferences!.remove(PreferencesKey.studentSignupData);
    // await _preferences!.remove(PreferencesKey.student_Id);
    // await _preferences!.remove(PreferencesKey.student_class);
    // await _preferences!.remove(PreferencesKey.student_class_Id);
    // await _preferences!.remove(PreferencesKey.student_school_Id);
    // await _preferences!.remove(PreferencesKey.subCategory);
    // await _preferences!.remove(PreferencesKey.teacherData);
    // await _preferences!.remove(PreferencesKey.teacherSignupData);
    // await _preferences!.remove(PreferencesKey.token);
    // await _preferences!.remove(PreferencesKey.topic);
    // // await _preferences!.remove(PreferencesKey.uId);
    // await _preferences!.remove(PreferencesKey.uName);
    // await _preferences!.remove(PreferencesKey.uType);
    // await _preferences!.remove(PreferencesKey.region);
    // await _preferences!.remove(PreferencesKey.district);
    // await _preferences!.remove(PreferencesKey.staffId);
    // await _preferences!.remove(PreferencesKey.schoolId);
    // // await AppPreference().setBool(PreferencesKey.isLoggedIn, false);
    // // await _preferences?.remove(PreferencesKey.isLoggedIn);
    // await AppPreference().setBool(PreferencesKey.introPage, true);
    // await _preferences?.remove(PreferencesKey.myLibraryData);
    log(AppPreference().getBool(PreferencesKey.isLoggedIn).toString());
  }

  String getStudentInfo() {
    log("-----dwdwdws  " +
        AppPreference().getString(PreferencesKey.studentData));
    Map<String, dynamic> userData =
        jsonDecode(AppPreference().getString(PreferencesKey.studentData));
    String classId = userData['data']['student']['st_class'] ?? "";
    print("Class ID: $classId");
    return classId;
  }

  bool get isLogin => getBool(PreferencesKey.isLoggedIn);
  bool get isTeacherLogin => getBool(PreferencesKey.isTeacherLoggedIn);
  bool get showIntro => getBool(PreferencesKey.introPage);
  String get uType => getString(PreferencesKey.uType);
  String get uName => getString(PreferencesKey.uName);
  int get uId => getInt(PreferencesKey.uId);
  int get isLoginFirstTimeteacher =>
      getInt(PreferencesKey.isLoggedInFirstTimeT);
  int get isLoginFirstTimestudent =>
      getInt(PreferencesKey.isLoggedInFirstTimeSt);

  /// Redirect user with local credentials
  String get initRoute => isLogin
      ? (isTeacherLogin)
          ? (isLoginFirstTimeteacher == 1)
              ? RoutesConst.teacherHome
              : RoutesConst.editProfile
          : (isLoginFirstTimestudent == 1)
              ? RoutesConst.home
              : RoutesConst.editProfile
      // ? RoutesConst.teacherHome
      // : RoutesConst.home
      : showIntro
          ? RoutesConst.loginPage
          : RoutesConst.introPage;
}
