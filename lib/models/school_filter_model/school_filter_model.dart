class SchoolFilterModel {
  bool? status;
  String? message;
  SchoolFilterData? data;

  SchoolFilterModel({this.status, this.message, this.data});

  SchoolFilterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new SchoolFilterData.fromJson(json['data'])
        : null;
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

class SchoolFilterData {
  List<Schools>? schools;

  SchoolFilterData({this.schools});

  SchoolFilterData.fromJson(Map<String, dynamic> json) {
    if (json['schools'] != null) {
      schools = <Schools>[];
      json['schools'].forEach((v) {
        schools!.add(new Schools.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schools != null) {
      data['schools'] = this.schools!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schools {
  int? scId;
  String? scSchoolName;
  String? scSchoolType;
  String? scSchoolId;
  Null? scSchoolHeadName;
  String? scRegion;
  String? scDistrict;
  Null? scCircuit;
  Null? scEmail;
  Null? scPhoneNumber;
  Null? scAltPhoneNumber;
  Null? scPassword;
  Null? scAddress;
  bool? scStatus;
  String? scCreatedAt;
  Null? scTown;
  Null? scLatitude;
  Null? scLongitude;
  Null? scNoOfClassroom;
  Null? scBoardingFacilities;
  Null? scSanitaryFacilities;
  Null? scScienceLab;
  Null? scAssemblyHall;
  Null? scLibraryFacilities;
  Null? scDiningFacilities;
  Null? scSchoolBus;
  Null? scSportingFacilities;
  Null? scStaffAccommodation;
  Null? scDescription;

  Schools(
      {this.scId,
      this.scSchoolName,
      this.scSchoolType,
      this.scSchoolId,
      this.scSchoolHeadName,
      this.scRegion,
      this.scDistrict,
      this.scCircuit,
      this.scEmail,
      this.scPhoneNumber,
      this.scAltPhoneNumber,
      this.scPassword,
      this.scAddress,
      this.scStatus,
      this.scCreatedAt,
      this.scTown,
      this.scLatitude,
      this.scLongitude,
      this.scNoOfClassroom,
      this.scBoardingFacilities,
      this.scSanitaryFacilities,
      this.scScienceLab,
      this.scAssemblyHall,
      this.scLibraryFacilities,
      this.scDiningFacilities,
      this.scSchoolBus,
      this.scSportingFacilities,
      this.scStaffAccommodation,
      this.scDescription});

  Schools.fromJson(Map<String, dynamic> json) {
    scId = json['sc_id'];
    scSchoolName = json['sc_schoolName'];
    scSchoolType = json['sc_schoolType'];
    scSchoolId = json['sc_schoolId'];
    scSchoolHeadName = json['sc_schoolHeadName'];
    scRegion = json['sc_region'];
    scDistrict = json['sc_district'];
    scCircuit = json['sc_circuit'];
    scEmail = json['sc_email'];
    scPhoneNumber = json['sc_phoneNumber'];
    scAltPhoneNumber = json['sc_altPhoneNumber'];
    scPassword = json['sc_password'];
    scAddress = json['sc_address'];
    scStatus = json['sc_status'];
    scCreatedAt = json['sc_createdAt'];
    scTown = json['sc_town'];
    scLatitude = json['sc_latitude'];
    scLongitude = json['sc_longitude'];
    scNoOfClassroom = json['sc_noOfClassroom'];
    scBoardingFacilities = json['sc_boardingFacilities'];
    scSanitaryFacilities = json['sc_sanitaryFacilities'];
    scScienceLab = json['sc_scienceLab'];
    scAssemblyHall = json['sc_assemblyHall'];
    scLibraryFacilities = json['sc_libraryFacilities'];
    scDiningFacilities = json['sc_diningFacilities'];
    scSchoolBus = json['sc_schoolBus'];
    scSportingFacilities = json['sc_sportingFacilities'];
    scStaffAccommodation = json['sc_staffAccommodation'];
    scDescription = json['sc_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sc_id'] = this.scId;
    data['sc_schoolName'] = this.scSchoolName;
    data['sc_schoolType'] = this.scSchoolType;
    data['sc_schoolId'] = this.scSchoolId;
    data['sc_schoolHeadName'] = this.scSchoolHeadName;
    data['sc_region'] = this.scRegion;
    data['sc_district'] = this.scDistrict;
    data['sc_circuit'] = this.scCircuit;
    data['sc_email'] = this.scEmail;
    data['sc_phoneNumber'] = this.scPhoneNumber;
    data['sc_altPhoneNumber'] = this.scAltPhoneNumber;
    data['sc_password'] = this.scPassword;
    data['sc_address'] = this.scAddress;
    data['sc_status'] = this.scStatus;
    data['sc_createdAt'] = this.scCreatedAt;
    data['sc_town'] = this.scTown;
    data['sc_latitude'] = this.scLatitude;
    data['sc_longitude'] = this.scLongitude;
    data['sc_noOfClassroom'] = this.scNoOfClassroom;
    data['sc_boardingFacilities'] = this.scBoardingFacilities;
    data['sc_sanitaryFacilities'] = this.scSanitaryFacilities;
    data['sc_scienceLab'] = this.scScienceLab;
    data['sc_assemblyHall'] = this.scAssemblyHall;
    data['sc_libraryFacilities'] = this.scLibraryFacilities;
    data['sc_diningFacilities'] = this.scDiningFacilities;
    data['sc_schoolBus'] = this.scSchoolBus;
    data['sc_sportingFacilities'] = this.scSportingFacilities;
    data['sc_staffAccommodation'] = this.scStaffAccommodation;
    data['sc_description'] = this.scDescription;
    return data;
  }
}
