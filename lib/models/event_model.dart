class EventResponseModel {
  bool? status;
  String? message;
  Data? data;

  EventResponseModel({this.status, this.message, this.data});

  EventResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Events>? events;

  Data({this.events});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  int? ecId;
  int? ecSchoolId;
  String? ecClass;
  String? ecEventtype;
  String? ecEventDate;
  String? ecEventTitle;
  bool? ecStatus;
  String? ecCreatedAt;

  Events(
      {this.ecId,
        this.ecSchoolId,
        this.ecClass,
        this.ecEventtype,
        this.ecEventDate,
        this.ecEventTitle,
        this.ecStatus,
        this.ecCreatedAt});

  Events.fromJson(Map<String, dynamic> json) {
    ecId = json['ec_id'];
    ecSchoolId = json['ec_schoolId'];
    ecClass = json['ec_class'];
    ecEventtype = json['ec_eventtype'];
    ecEventDate = json['ec_eventDate'];
    ecEventTitle = json['ec_eventTitle'];
    ecStatus = json['ec_status'];
    ecCreatedAt = json['ec_createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ec_id'] = ecId;
    data['ec_schoolId'] = ecSchoolId;
    data['ec_class'] = ecClass;
    data['ec_eventtype'] = ecEventtype;
    data['ec_eventDate'] = ecEventDate;
    data['ec_eventTitle'] = ecEventTitle;
    data['ec_status'] = ecStatus;
    data['ec_createdAt'] = ecCreatedAt;
    return data;
  }
}