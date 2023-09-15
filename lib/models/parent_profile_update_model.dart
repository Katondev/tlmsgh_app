class ParentProfileUpdateModel {
  ParentProfileUpdateModel({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ParentProfileUpdateModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;

  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      List<int>? student,}){
    _student = student;
}

  Data.fromJson(dynamic json) {
    _student = json['student'] != null ? json['student'].cast<int>() : [];
  }
  List<int>? _student;

  List<int>? get student => _student;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['student'] = _student;
    return map;
  }

}