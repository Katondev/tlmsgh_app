class MessageResponseModel {
  bool? status;
  String? message;
  Data? data;

  MessageResponseModel({this.status, this.message, this.data});

  MessageResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<SendMessage>? sendMessage;

  Data({this.sendMessage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sendMessage'] != null) {
      sendMessage = <SendMessage>[];
      json['sendMessage'].forEach((v) {
        sendMessage!.add(new SendMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sendMessage != null) {
      data['sendMessage'] = this.sendMessage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SendMessage {
  int? smId;
  String? smMsg;
  int? smClass;
  List<int>? smStudent;
  String? smType;
  String? smCreatedAt;

  SendMessage(
      {this.smId,
        this.smMsg,
        this.smClass,
        this.smStudent,
        this.smType,
        this.smCreatedAt});

  SendMessage.fromJson(Map<String, dynamic> json) {
    smId = json['sm_id'];
    smMsg = json['sm_msg'];
    smClass = json['sm_class'];
    smStudent = json['sm_student'].cast<int>();
    smType = json['sm_type'];
    smCreatedAt = json['sm_createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sm_id'] = this.smId;
    data['sm_msg'] = this.smMsg;
    data['sm_class'] = this.smClass;
    data['sm_student'] = this.smStudent;
    data['sm_type'] = this.smType;
    data['sm_createdAt'] = this.smCreatedAt;
    return data;
  }
}