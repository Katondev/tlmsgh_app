class LiveClassModel {
  LiveClassModel({
    this.status,
    this.message,
    this.data,
  });

  LiveClassModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.liveSession,
  });

  Data.fromJson(dynamic json) {
    if (json['liveSession'] != null) {
      liveSession = [];
      json['liveSession'].forEach((v) {
        liveSession?.add(LiveSession.fromJson(v));
      });
    }
  }
  List<LiveSession>? liveSession;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (liveSession != null) {
      map['liveSession'] = liveSession?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class LiveSession {
  LiveSession({
    this.lsId,
    this.tcId,
    this.lsTitle,
    this.lsImage,
    this.lsDate,
    this.lsTime,
    this.lsDesc,
    this.lsRoomURL,
    this.lsVideoURL,
    this.lsisVideoFetched,
    this.lsMainCategory,
    this.lsCategory,
    this.lsSubCategory,
    this.lsCreatedAt,
    this.lsStatus,
    this.lsTeacher,
  });

  LiveSession.fromJson(dynamic json) {
    lsId = json['ls_id'];
    tcId = json['tc_id'];
    lsTitle = json['ls_title'];
    lsImage = json['ls_image'];
    lsDate = json['ls_date'];
    lsTime = json['ls_time'];
    lsDesc = json['ls_desc'];
    lsRoomURL = json['ls_roomURL'];
    lsVideoURL = json['ls_videoUrl'];
    lsisVideoFetched = json['ls_isVideoFetched'];
    lsMainCategory = json['ls_mainCategory'];
    lsCategory = json['ls_category'];
    lsSubCategory = json['ls_subCategory'];
    lsCreatedAt = json['ls_createdAt'];
    lsStatus = json['ls_status'];
    lsTeacher = json['ls_teacher'] != null
        ? LsTeacher.fromJson(json['ls_teacher'])
        : null;
  }
  int? lsId;
  int? tcId;
  String? lsTitle;
  String? lsImage;
  String? lsDate;
  String? lsTime;
  String? lsDesc;
  String? lsRoomURL;
  String? lsVideoURL;
  int? lsisVideoFetched;
  String? lsMainCategory;
  String? lsCategory;
  String? lsSubCategory;
  String? lsCreatedAt;
  bool? lsStatus;
  LsTeacher? lsTeacher;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ls_id'] = lsId;
    map['tc_id'] = tcId;
    map['ls_title'] = lsTitle;
    map['ls_image'] = lsImage;
    map['ls_date'] = lsDate;
    map['ls_time'] = lsTime;
    map['ls_desc'] = lsDesc;
    map['ls_roomURL'] = lsRoomURL;
    map['ls_videoUrl'] = lsVideoURL;
    map['ls_isVideoFetched'] = lsisVideoFetched;
    map['ls_mainCategory'] = lsMainCategory;
    map['ls_category'] = lsCategory;
    map['ls_subCategory'] = lsSubCategory;
    map['ls_createdAt'] = lsCreatedAt;
    map['ls_status'] = lsStatus;
    if (lsTeacher != null) {
      map['ls_teacher'] = lsTeacher?.toJson();
    }
    return map;
  }
}

class LsTeacher {
  LsTeacher({
    this.tcFullName,
    this.tcProfilePic,
  });

  LsTeacher.fromJson(dynamic json) {
    tcFullName = json['tc_fullName'];
    tcProfilePic = json['tc_profilePic'];
  }
  String? tcFullName;
  String? tcProfilePic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tc_fullName'] = tcFullName;
    map['tc_profilePic'] = tcProfilePic;
    return map;
  }
}
