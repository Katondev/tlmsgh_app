class TeacherProfileUpdateModel {
  TeacherProfileUpdateModel({
      this.status,
      this.message, 
      this.data,});

  TeacherProfileUpdateModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? json['data'].cast<int>() : [];
  }
  bool? status;
  String? message;
  List<int>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}