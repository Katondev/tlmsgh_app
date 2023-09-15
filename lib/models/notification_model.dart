import 'dart:convert';

import 'package:get/get.dart';

class NotificationResponseModel {
  bool? status;
  String? message;
  Data? data;

  NotificationResponseModel({this.status, this.message, this.data});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Notifications>? notification;

  Data({this.notification});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notification'] != null) {
      notification = <Notifications>[];
      json['notification'].forEach((v) {
        notification!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notification != null) {
      data['notification'] = notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? ntId;
  int? ntSchoolId;
  String? ntClass;
  String? ntTitle;
  String? ntDesc;
  String? ntFile;
  bool? ntStatus;
  String? ntCreatedAt;
  RxBool? isDownloading = false.obs;
  RxBool? inProgress = false.obs;

  Notifications(
      {this.ntId,
      this.ntSchoolId,
      this.ntClass,
      this.ntTitle,
      this.ntDesc,
      this.ntFile,
      this.ntStatus,
      this.ntCreatedAt,
      this.isDownloading});

  static String encode(List<Notifications> notifications) => json.encode(
        notifications
            .map<Map<String, dynamic>>(
                (notification) => Notifications.toMap(notification))
            .toList(),
      );
  static List<Notifications> decode(String notifications) =>
      (json.decode(notifications) as List<dynamic>)
          .map<Notifications>((item) => Notifications.fromJson(item))
          .toList();

  static Map<String, dynamic> toMap(Notifications notifications) => {
        "nt_id": notifications.ntId,
        "nt_schoolId":
            notifications.ntSchoolId,
        "nt_class":
            notifications.ntClass,
        "nt_title":
            notifications.ntTitle,
        "nt_desc": notifications.ntDesc,
        "nt_file": notifications.ntFile,
        "nt_status":
            notifications.ntStatus,
        "nt_createdAt": notifications.ntCreatedAt,
      };

  Notifications.fromJson(Map<String, dynamic> json) {
    ntId = json['nt_id'];
    ntSchoolId = json['nt_schoolId'];
    ntClass = json['nt_class'];
    ntTitle = json['nt_title'];
    ntDesc = json['nt_desc'];
    ntFile = json['nt_file'];
    ntStatus = json['nt_status'];
    ntCreatedAt = json['nt_createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nt_id'] = ntId;
    data['nt_schoolId'] = ntSchoolId;
    data['nt_class'] = ntClass;
    data['nt_title'] = ntTitle;
    data['nt_desc'] = ntDesc;
    data['nt_file'] = ntFile;
    data['nt_status'] = ntStatus;
    data['nt_createdAt'] = ntCreatedAt;
    return data;
  }
}
