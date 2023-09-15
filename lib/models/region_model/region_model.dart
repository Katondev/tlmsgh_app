class RegionModel {
  bool? status;
  String? message;
  RegionData? data;

  RegionModel({this.status, this.message, this.data});

  RegionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new RegionData.fromJson(json['data']) : null;
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

class RegionData {
  List<Circuits>? circuits;

  RegionData({this.circuits});

  RegionData.fromJson(Map<String, dynamic> json) {
    if (json['circuits'] != null) {
      circuits = <Circuits>[];
      json['circuits'].forEach((v) {
        circuits!.add(new Circuits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.circuits != null) {
      data['circuits'] = this.circuits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Circuits {
  int? regionId;
  String? regionTitle;
  List<District>? district;

  Circuits({this.regionId, this.regionTitle, this.district});

  Circuits.fromJson(Map<String, dynamic> json) {
    regionId = json['regionId'];
    regionTitle = json['regionTitle'];
    if (json['district'] != null) {
      district = <District>[];
      json['district'].forEach((v) {
        district!.add(new District.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regionId'] = this.regionId;
    data['regionTitle'] = this.regionTitle;
    if (this.district != null) {
      data['district'] = this.district!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  int? districtId;
  String? districtTitle;
  List<Null>? circuit;

  District({this.districtId, this.districtTitle, this.circuit});

  District.fromJson(Map<String, dynamic> json) {
    districtId = json['districtId'];
    districtTitle = json['districtTitle'];
    // if (json['circuit'] != null) {
    //   circuit = <Null>[];
    // json['circuit'].forEach((v) {
    //   circuit!.add(new Null.fromJson(v));
    // });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtId'] = this.districtId;
    data['districtTitle'] = this.districtTitle;
    // if (this.circuit != null) {
    //   data['circuit'] = this.circuit!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
