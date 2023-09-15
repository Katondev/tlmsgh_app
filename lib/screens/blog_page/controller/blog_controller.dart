import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katon/screens/group_page/controller/group_controller.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';

import '../../../models/blog_model/blog_model.dart';
import '../../../models/comment_model/comment_detail_model.dart';
import '../../../network/api_constants.dart';
import '../../../services/api_service.dart';
import 'package:dio/src/form_data.dart' as mp;
import 'package:dio/src/multipart_file.dart' as mf;

class BlogController extends GetxController {
  RxString creatorgroupVal = "1".obs;
  RxBool isLoading = false.obs;

  bool get connection => connections;
  RxBool isLoadingComments = false.obs;
  RxString blogType = "".obs;
  RxInt blogId = 0.obs;
  RxInt selectedComment = 1000.obs;
  bool connections = false;
  RxInt blogPage = 1.obs;
  Rx<BlogModel> blogData = BlogModel().obs;
  RxList<BlogRow> blogdataList = <BlogRow>[].obs;
  Rx<CommentDetailModel> commentData = CommentDetailModel().obs;
  RxList<Comment> commentDataList = <Comment>[].obs;
  Rx<TextEditingController> blogTitle = TextEditingController().obs;
  Rx<TextEditingController> blogDesc = TextEditingController().obs;
  Rx<TextEditingController> comment = TextEditingController().obs;
  final blogcommenttabKey = GlobalKey<FormState>();
  RxList creatorList = ["All", "Teacher", "Student", "Expert"].obs;

  // Future onchangePressed(int index) async {
  //   radioIndex.value = index;
  //   log("radio val---${radioIndex}");
  // }

  RxList blogList = [
    {
      "imageUrl":
          "https://images.pexels.com/photos/14894654/pexels-photo-14894654.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "New blog with Image",
      "description": "Hello, i am testing.",
      "isshowComments": false,
    },
    {
      "imageUrl":
          "https://images.pexels.com/photos/14894654/pexels-photo-14894654.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "New blog with Image",
      "description": "Hello, i am testing.",
      "isshowComments": false,
    },
  ].obs;

  ///
  ImagePicker _picker = ImagePicker();
  XFile? xfile;
  File? path;
  String token = AppPreference().getString(PreferencesKey.token);

  Future<void> pickImage() async {
    xfile = await _picker.pickImage(source: ImageSource.gallery);
    path = File(xfile!.path);

    if (path != null) {
      log(path.toString());
    }
  }

  Future<void> getBlogList() async {
    try {
      isLoading.value = true;

      await ApiService.instance.getHTTP(
        ApiRoutes.getBloglist,
        queryParameters: {
          "bl_creation_type": AppPreference().getString(PreferencesKey.uType),
        },
      ).then((value) {
        blogData.value = BlogModel.fromJson(value.data);
        log("message---blog-----${blogData.value.data?.blog?.rows?.length}");
        update();
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

  Future<void> getBlogListwithpagination() async {
    try {
      if (blogdataList.isEmpty) {
        isLoading.value = true;
      }

      await ApiService.instance.getHTTP(
        ApiRoutes.getBloglistwithpagination,
        queryParameters: {
          "page": blogPage.value,
          "limit": 10,
          "bl_creation_type": blogType.value,
        },
      ).then((value) {
        // blogdataList.clear();
        blogData.value = BlogModel.fromJson(value.data);
        update();

        for (var v in blogData.value.data!.blog!.rows!) {
          blogdataList.add(v);
          blogdataList.refresh();
        }

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

  Future<void> likeBlog() async {
    try {
      // isLoading.value = true;
      await ApiService.instance.postHTTP(
        url: ApiRoutes.likeBlog,
        queryParameters: {"bl_id": blogId.value},
      ).then((value) async {
        // await getBlogList();
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

  Future<void> deleteBlog() async {
    try {
      isLoading.value = true;
      await ApiService.instance
          .deleteHTTP(
        url: "${ApiRoutes.deleteBlog}${blogId.value}",
      )
          .then((value) async {
        log("delete successfull");
        // await getBlogList();
        blogdataList.clear();
        blogPage.value = 1;
        await getBlogListwithpagination();

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

  Future<void> getAllCommentsbyId() async {
    try {
      // isLoading.value = true;
      // isLoadingComments.value = true;
      log("=--------------=");
      log("loading-----" + isLoadingComments.toString());
      await ApiService.instance.getHTTP(
        ApiRoutes.getAllCommentsbyId,
        queryParameters: {"bl_id": blogId.value},
      ).then((value) {
        commentData.value = CommentDetailModel.fromJson(value.data);

        commentDataList.value = commentData.value.data!.comment!;
        log("coment----${commentDataList.length}");
        // commentDataList.refresh();
        connections = false;
      });
      isLoadingComments.value = false;
      log("loading-----" + isLoadingComments.toString());
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isLoadingComments.value = false;
    }
  }

  Future<void> addComment() async {
    try {
      // isLoading.value = true;
      isLoadingComments.value = true;
      await ApiService.instance.postHTTP(url: ApiRoutes.addComment, body: {
        "cmn_comment": comment.value.text.trim(),
        "cmn_userId": AppPreference().getInt(PreferencesKey.uId),
        "cmn_userType": AppPreference().getString(PreferencesKey.uType),
        "bl_id": blogId.value,
        "cmn_date":
            "${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}"
      }, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': "application/json"
      }).then((value) async {
        comment.value.clear();
        await getAllCommentsbyId();
        Get.put(GroupController()).getGroupDetailsbyId();
        // await getBlogListwithpagination();

        connections = false;
      });
      isLoadingComments.value = false;
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      isLoadingComments.value = false;
    }
  }

  Future<void> addBlog() async {
    try {
      isLoading.value = true;
      mp.FormData formData = mp.FormData.fromMap({
        // "bl_title": blogTitle.value.text.trim(),
        "bl_title": "hello",
        "bl_desc": blogDesc.value.text.trim(),
        "bl_creation_type": AppPreference().getString(PreferencesKey.uType),
        "bl_creatorId": AppPreference().getInt(PreferencesKey.uId),
        "grp_id": 0,
        "bl_image": (path != null)
            ? mf.MultipartFile.fromBytes(
                path!.readAsBytesSync(),
                filename: "${path.toString().split("/").last}",
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
        blogdataList.clear();
        await getBlogListwithpagination();
        blogTitle.value.clear();
        blogDesc.value.clear();
        path = null;
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
}
