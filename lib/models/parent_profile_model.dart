class ParentProfileModel {
  ParentProfileModel({
    bool? status,
    String? message,
    ParentData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ParentProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? ParentData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  ParentData? _data;

  bool? get status => _status;
  String? get message => _message;
  ParentData? get data => _data;

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

class ParentData {
  ParentData({
    ParentProfile? parentProfile,
  }) {
    _parentProfile = parentProfile;
  }

  ParentData.fromJson(dynamic json) {
    _parentProfile = json['parentProfile'] != null
        ? ParentProfile.fromJson(json['parentProfile'])
        : null;
  }
  ParentProfile? _parentProfile;

  ParentProfile? get parentProfile => _parentProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_parentProfile != null) {
      map['parentProfile'] = _parentProfile?.toJson();
    }
    return map;
  }
}

class ParentProfile {
  ParentProfile({
    int? ptId,
    String? ptFullName,
    String? ptEmail,
    dynamic ptEducation,
    dynamic ptRegion,
    dynamic ptDistrict,
    dynamic ptCircuit,
    String? ptPhoneNumber,
    dynamic ptAltPhoneNumber,
    dynamic ptAddress,
    dynamic ptProfilePic,
    dynamic ptDegreeCertificate,
    bool? ptStatus,
    String? ptCreatedAt,
  }) {
    _ptId = ptId;
    _ptFullName = ptFullName;
    _ptEmail = ptEmail;
    _ptEducation = ptEducation;
    _ptRegion = ptRegion;
    _ptDistrict = ptDistrict;
    _ptCircuit = ptCircuit;
    _ptPhoneNumber = ptPhoneNumber;
    _ptAltPhoneNumber = ptAltPhoneNumber;
    _ptAddress = ptAddress;
    _ptProfilePic = ptProfilePic;
    _ptDegreeCertificate = ptDegreeCertificate;
    _ptStatus = ptStatus;
    _ptCreatedAt = ptCreatedAt;
  }

  ParentProfile.fromJson(dynamic json) {
    _ptId = json['pt_id'];
    _ptFullName = json['pt_fullName'];
    _ptEmail = json['pt_email'];
    _ptEducation = json['pt_education'];
    _ptRegion = json['pt_region'];
    _ptDistrict = json['pt_district'];
    _ptCircuit = json['pt_circuit'];
    _ptPhoneNumber = json['pt_phoneNumber'];
    _ptAltPhoneNumber = json['pt_altPhoneNumber'];
    _ptAddress = json['pt_address'];
    _ptProfilePic = json['pt_profilePic'];
    _ptDegreeCertificate = json['pt_degreeCertificate'];
    _ptStatus = json['pt_status'];
    _ptCreatedAt = json['pt_createdAt'];
  }
  int? _ptId;
  String? _ptFullName;
  String? _ptEmail;
  dynamic _ptEducation;
  dynamic _ptRegion;
  dynamic _ptDistrict;
  dynamic _ptCircuit;
  String? _ptPhoneNumber;
  dynamic _ptAltPhoneNumber;
  dynamic _ptAddress;
  dynamic _ptProfilePic;
  dynamic _ptDegreeCertificate;
  bool? _ptStatus;
  String? _ptCreatedAt;

  int? get ptId => _ptId;
  String? get ptFullName => _ptFullName;
  String? get ptEmail => _ptEmail;
  dynamic get ptEducation => _ptEducation;
  dynamic get ptRegion => _ptRegion;
  dynamic get ptDistrict => _ptDistrict;
  dynamic get ptCircuit => _ptCircuit;
  String? get ptPhoneNumber => _ptPhoneNumber;
  dynamic get ptAltPhoneNumber => _ptAltPhoneNumber;
  dynamic get ptAddress => _ptAddress;
  dynamic get ptProfilePic => _ptProfilePic;
  dynamic get ptDegreeCertificate => _ptDegreeCertificate;
  bool? get ptStatus => _ptStatus;
  String? get ptCreatedAt => _ptCreatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pt_id'] = _ptId;
    map['pt_fullName'] = _ptFullName;
    map['pt_email'] = _ptEmail;
    map['pt_education'] = _ptEducation;
    map['pt_region'] = _ptRegion;
    map['pt_district'] = _ptDistrict;
    map['pt_circuit'] = _ptCircuit;
    map['pt_phoneNumber'] = _ptPhoneNumber;
    map['pt_altPhoneNumber'] = _ptAltPhoneNumber;
    map['pt_address'] = _ptAddress;
    map['pt_profilePic'] = _ptProfilePic;
    map['pt_degreeCertificate'] = _ptDegreeCertificate;
    map['pt_status'] = _ptStatus;
    map['pt_createdAt'] = _ptCreatedAt;
    return map;
  }
}
