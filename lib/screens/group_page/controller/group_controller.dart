import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/loading_indicator.dart';

import '../../../models/group_model/classmate_model.dart';
import '../../../models/group_model/group_detail_model.dart';
import '../../../models/group_model/group_list_model.dart';
import '../../../models/group_model/related_group_model.dart';
import '../../../network/api_constants.dart';
import '../../../services/api_service.dart';
import 'package:dio/src/form_data.dart' as mp;
import 'package:dio/src/multipart_file.dart' as mf;

class GroupController extends GetxController {
  RxBool isLoading = false.obs;
  bool connections = false;
  RxInt groupId = 0.obs;
  Rx<GroupListModel> groupList = GroupListModel().obs;
  Rx<GroupDetailModel> groupDetail = GroupDetailModel().obs;
  Rx<ClassmateModel> classmateData = ClassmateModel().obs;
  Rx<RelatedGroupModel> relatedGroupData = RelatedGroupModel().obs;
  RxBool isloadingrelatedGrp = false.obs;
  RxBool isloadinggroupDetails = false.obs;
  RxBool commentload = false.obs;
  RxBool isloadingclassmate = false.obs;
  RxBool isloadinggroups = false.obs;
  RxBool isshowGroup = false.obs;
  Rx<TextEditingController> groupName = TextEditingController().obs;
  Rx<TextEditingController> groupDesc = TextEditingController().obs;
  Rx<TextEditingController> groupblogTitle = TextEditingController().obs;
  Rx<TextEditingController> groupblogDesc = TextEditingController().obs;

  // void _setLoading(bool val) {
  //   isLoading.value = val;
  // }

  ImagePicker _picker = ImagePicker();
  XFile? xfile;
  File? path;

  Future<void> pickImage() async {
    xfile = await _picker.pickImage(source: ImageSource.gallery);
    path = File(xfile!.path);

    if (path != null) {
      log(path!.path.toString());
    }
  }

  Future<void> getGroupList() async {
    try {
      isloadinggroups.value = true;
      await ApiService.instance
          .getHTTP(ApiRoutes.getGrouplist, queryParameters: {
        "st_id": AppPreference().getInt(PreferencesKey.uId),
      }).then((value) {
        groupList.value = GroupListModel.fromJson(value.data);
        log("-----${groupList.value}");
        groupId.value = groupList.value.data!.group!.first.grpId!;
        connections = false;
      });
      isloadinggroups.value = false;
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isloadinggroups.value = false;
    }
  }

  Future<void> getGroupDetailsbyId() async {
    try {
      isloadinggroupDetails.value = true;

      await ApiService.instance
          .getHTTP(ApiRoutes.getGroupdetailsbyId, queryParameters: {
        "grp_id": groupId.value,
      }).then((value) {
        groupDetail.value = GroupDetailModel.fromJson(value.data);
        log("-----${groupList.value}");
        connections = false;
      });
      isloadinggroupDetails.value = false;
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isloadinggroupDetails.value = false;
    }
  }

  Future<void> addGroup() async {
    try {
      isLoading.value = true;
      await ApiService.instance.postHTTP(url: ApiRoutes.addGroup, body: {
        "grp_name": groupName.value.text.trim(),
        "grp_desc": groupDesc.value.text.trim(),
        "st_id": AppPreference().getInt(PreferencesKey.uId)
      }).then((value) {
        log("-----${groupList.value}");
        groupName.value.clear();
        groupDesc.value.clear();

        getGroupList();
        connections = false;
      });
      isLoading.value = false;
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isLoading.value = false;
    }
  }

  Future<void> getClassmateList() async {
    try {
      isloadingclassmate.value = true;
      await ApiService.instance
          .getHTTP(ApiRoutes.getClassmateData, queryParameters: {
        "st_class": AppPreference().getString(PreferencesKey.student_class),
        "st_schoolId": AppPreference().getInt(PreferencesKey.student_school_Id)
      }).then((value) {
        classmateData.value = ClassmateModel.fromJson(value.data);
        connections = false;
      });
      isloadingclassmate.value = false;
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isloadingclassmate.value = false;
    }
  }

  Future<void> getRelatedGroup() async {
    try {
      isloadingrelatedGrp.value = true;
      await ApiService.instance
          .getHTTP(ApiRoutes.getRelatedGroup, queryParameters: {
        "sc_id": AppPreference().getInt(PreferencesKey.student_school_Id),
        "grp_class": AppPreference().getString(PreferencesKey.student_class),
        "st_id": AppPreference().getInt(PreferencesKey.student_Id)
      }).then((value) {
        // classmateData.value = ClassmateModel.fromJson(value.data);
        relatedGroupData.value = RelatedGroupModel.fromJson(value.data);
        connections = false;
      });
      isloadingrelatedGrp.value = false;
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isloadingrelatedGrp.value = false;
    }
  }

  Future<void> deleteGroup() async {
    try {
      // isLoading.value = true;
      CustomLoadingIndicator.instance.show();
      await ApiService.instance
          .deleteHTTP(url: "${ApiRoutes.deleteGroup}${groupId}")
          .then((value) async {
        log("-----${groupList.value}");
        await getGroupList();

        groupId.value = groupList.value.data!.group!.first.grpId!;
        await getGroupDetailsbyId();
        Get.back();
        connections = false;
      });
      // isLoading.value = false;
      CustomLoadingIndicator.instance.hide();
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      // isLoading.value = false;
      CustomLoadingIndicator.instance.hide();
    }
  }

  Future<void> joinGroup() async {
    try {
      isLoading.value = true;
      // CustomLoadingIndicator.instance.show();
      await ApiService.instance.postHTTP(url: "${ApiRoutes.joinGroup}", body: {
        "grp_id": groupId.value,
        "st_id": AppPreference().getInt(PreferencesKey.uId)
      }).then((value) async {
        await getGroupList();
        await getRelatedGroup();
        // groupId.value = 1;
        // groupId.value = groupList.value.data!.group!.first.grpId!;
        // await getGroupDetailsbyId();
        Get.back();
        connections = false;
      });
      isLoading.value = false;
      CustomLoadingIndicator.instance.hide();
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isLoading.value = false;
      CustomLoadingIndicator.instance.hide();
    }
  }

  Future<void> exitGroup() async {
    try {
      isLoading.value = true;
      await ApiService.instance.getHTTP(
        "${ApiRoutes.exitGroup}",
        queryParameters: {
          "grp_id": groupId.value,
          "st_id": AppPreference().getInt(PreferencesKey.uId)
        },
      ).then((value) async {
        await getGroupList();
        await getRelatedGroup();
        await getGroupDetailsbyId();
        // groupId.value = groupList.value.data!.group!.first.grpId!;
        Get.back();
        connections = false;
      });
      isLoading.value = false;
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isLoading.value = false;
    }
  }

  Future<void> addGroupBlog() async {
    String token = AppPreference().getString(PreferencesKey.token);
    try {
      // isLoading.value = true;
      CustomLoadingIndicator.instance.show();
      mp.FormData formData = mp.FormData.fromMap({
        "bl_title": groupblogTitle.value.text.trim(),
        "bl_desc": groupblogDesc.value.text.trim(),
        "bl_creation_type": AppPreference().getString(PreferencesKey.uType),
        "bl_creatorId": AppPreference().getInt(PreferencesKey.uId),
        "grp_id": groupId.value,
        "bl_image": (path != null)
            ? mf.MultipartFile.fromBytes(
                path!.readAsBytesSync(),
                filename: "${path!.path.toString().split("/").last}",
              )
            : "",
      });
      await ApiService.instance
          .postHTTP(
        url: ApiRoutes.addBlog,
        queryParameters: {
          "from": "studentApp",
          "key": "xsv321sa2ds4235reuy354FE4rsd"
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': "application/json"
        },
        body: formData,
      )
          .then((value) async {
        await getGroupDetailsbyId();
        groupblogTitle.value.clear();
        groupblogDesc.value.clear();
        path = null;
        Get.back();
        connections = false;
      });
      CustomLoadingIndicator.instance.hide();
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      CustomLoadingIndicator.instance.hide();
    }
  }
}
