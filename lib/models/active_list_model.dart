import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class ActiveList {
  bool active;
  List<ActiveListModel> activeList = [];
  String event;

  ActiveList(this.active, this.activeList, this.event);

  factory ActiveList.fromJson(Map<dynamic, dynamic> json) {
    return ActiveList(
      json['active'] as bool,
      (json['activeList'] as List).map((i) {
        return ActiveListModel.fromJson(i);
      }).toList(),
      json['event'] as String,
    );
  }
}

class ActiveListModel {
  String name;
  int streamId;
  String clientId;
  String videoaspectratio;
  String mediatype;
  bool videomuted;

  ActiveListModel(this.name, this.streamId, this.clientId,
      this.videoaspectratio, this.mediatype, this.videomuted);

  // convert Json to an exercise object
  factory ActiveListModel.fromJson(Map<dynamic, dynamic> json) {
    int sId = int.parse(json['streamId'].toString());
    return ActiveListModel(
      json['name'] as String,
      sId,
//      json['streamId'] as int,
      json['clientId'] as String,
      json['videoaspectratio'] as String,
      json['mediatype'] as String,
      json['videomuted'] as bool,
    );
  }
}

class PermissionService {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<Map<Permission, PermissionStatus>> _requestPermission() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      int sdkversionandroid = androidInfo.version.sdkInt;
      // var iosInfo = await DeviceInfoPlugin().iosInfo;

      log("===========${sdkversionandroid.toString()}==========");

      if (sdkversionandroid < 33) {
        return await [
          Permission.microphone,
          Permission.camera,
          Permission.storage,
        ].request();
      } else {
        return await [
          Permission.microphone,
          Permission.camera,
          Permission.photos,
          Permission.videos,
          Permission.audio,
        ].request();
      }
    } else {
      return await [
        Permission.microphone,
        Permission.camera,
        Permission.storage,
      ].request();
    }
  }

  Future requestPermission() async {
    var data = await _requestPermission();
    log(data.toString());
  }

  Future requestStoragePermission() async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    int sdkversion = androidInfo.version.sdkInt;

    if (Platform.isAndroid) {
      if (sdkversion < 33) {
        await Permission.storage.request();
      } else {
        return await [
          Permission.photos,
          Permission.videos,
          Permission.audio,
        ].request();
      }
    } else {
      await Permission.storage.request();
    }
  }
}
