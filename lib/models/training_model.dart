class TrainingModel {
  bool? status;
  String? message;
  Data? data;

  TrainingModel({this.status, this.message, this.data});

  TrainingModel.fromJson(Map<String, dynamic> json) {
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
  List<TrainingPrograms>? trainingPrograms;

  Data({this.trainingPrograms});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['trainingPrograms'] != null) {
      trainingPrograms = <TrainingPrograms>[];
      json['trainingPrograms'].forEach((v) {
        trainingPrograms!.add(new TrainingPrograms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trainingPrograms != null) {
      data['trainingPrograms'] =
          this.trainingPrograms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrainingPrograms {
  int? tpId;
  String? tpProgramTitle;
  String? tpTypeOfProgram;
  String? tpDescription;
  String? tpWhoCanAttend;
  String? tpBenefitsOfProgram;
  String? tpCertificateTemplate;
  String? tpDuration;
  bool? tpIsFree;
  String? tpCreatedAt;
  String? tpProgramImage;
  int? tpPrice;
  Null tpTrainingFor;
  List<String>? tpWhoCanAttendTraining;

  TrainingPrograms(
      {this.tpId,
      this.tpProgramTitle,
      this.tpTypeOfProgram,
      this.tpDescription,
      this.tpWhoCanAttend,
      this.tpBenefitsOfProgram,
      this.tpCertificateTemplate,
      this.tpDuration,
      this.tpIsFree,
      this.tpCreatedAt,
      this.tpProgramImage,
      this.tpPrice,
      this.tpTrainingFor,
      this.tpWhoCanAttendTraining});

  TrainingPrograms.fromJson(Map<String, dynamic> json) {
    tpId = json['tp_id'];
    tpProgramTitle = json['tp_programTitle'];
    tpTypeOfProgram = json['tp_typeOfProgram'];
    tpDescription = json['tp_description'];
    tpWhoCanAttend = json['tp_whoCanAttend'];
    tpBenefitsOfProgram = json['tp_benefitsOfProgram'];
    tpCertificateTemplate = json['tp_certificateTemplate'];
    tpDuration = json['tp_duration'];
    tpIsFree = json['tp_isFree'];
    tpCreatedAt = json['tp_createdAt'];
    tpProgramImage = json['tp_programImage'];
    tpPrice = json['tp_price'];
    tpTrainingFor = json['tp_trainingFor'];
    tpWhoCanAttendTraining = json['tp_whoCanAttendTraining'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tp_id'] = this.tpId;
    data['tp_programTitle'] = this.tpProgramTitle;
    data['tp_typeOfProgram'] = this.tpTypeOfProgram;
    data['tp_description'] = this.tpDescription;
    data['tp_whoCanAttend'] = this.tpWhoCanAttend;
    data['tp_benefitsOfProgram'] = this.tpBenefitsOfProgram;
    data['tp_certificateTemplate'] = this.tpCertificateTemplate;
    data['tp_duration'] = this.tpDuration;
    data['tp_isFree'] = this.tpIsFree;
    data['tp_createdAt'] = this.tpCreatedAt;
    data['tp_programImage'] = this.tpProgramImage;
    data['tp_price'] = this.tpPrice;
    data['tp_trainingFor'] = this.tpTrainingFor;
    data['tp_whoCanAttendTraining'] = this.tpWhoCanAttendTraining;
    return data;
  }
}
