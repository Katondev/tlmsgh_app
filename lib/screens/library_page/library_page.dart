import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/models/teacher_sign_in_model.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/screens/library_page/library_mobile.dart';
import 'package:katon/screens/library_page/library_tablet.dart';
import 'package:katon/screens/message/message_cnt.dart';
import 'package:katon/utils/global_singlton.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

import '../../models/encode_decode/encode_decode.dart';

class LibraryPage extends StatefulWidget {
  final Arguments arguments;

   LibraryPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> with WidgetsBindingObserver {
  SignInModel signInM = SignInModel();
  ELearningProvider? eLearningPrv;
  final cnt = Get.put(AppBarCnt());
  final messageCnt = Get.put(MessageCnt());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // eLearningPrv?.pages = 1;
    if (AppPreference()
        .getString(PreferencesKey.downloadedvideobookIdList)
        .isNotEmpty) {
      var dd =
          AppPreference().getString(PreferencesKey.downloadedvideobookIdList);
      GlobalSingleton().downloadedvideobookIdList.value =
          EncodeDecode.decode(dd);
      print(
          "-------------------------------->>>>>>${GlobalSingleton().downloadedvideobookIdList}");
    }
    eLearningPrv = Provider.of<ELearningProvider>(context, listen: false);
    init();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    // });
  }

  void init() async {
    log("ssds-------------");
    await eLearningPrv?.getAllCategoryInfo();
    await eLearningPrv?.getAllSubjects();
    await eLearningPrv?.getSubject();
    await eLearningPrv?.resetOnTap();
    if (!AppPreference().isTeacherLogin) {
      Map<String, dynamic> userData =
          jsonDecode(AppPreference().getString(PreferencesKey.studentData));
      eLearningPrv?.signInM = SignInModel.fromJson(userData);
    } else {
      log("inside else---");
      Map<String, dynamic> userData =
          jsonDecode(AppPreference().getString(PreferencesKey.teacherData));
      eLearningPrv?.teachersignInM = TeacherSignInModel.fromJson(userData);
    }
    if (!AppPreference().isTeacherLogin) {
      cnt.getStudentInfo();
      await messageCnt.getAllMessage();
    } else {
      cnt.getTeacherInfo();
      messageCnt.messageResponseModel = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return LibraryPageMobile(arguments: widget.arguments);
    } else {
      return LibraryPageTablet(arguments: widget.arguments);
    }
  }
}
