class AttendanceModel {
  String? status;
  List<AData>? data;

  AttendanceModel({this.status, this.data});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AData>[];
      json['data'].forEach((v) {
        data!.add(AData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AData {
  String? sId;
  String? name;

  AData({this.sId, this.name});

  AData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class AttendanceresModel {
  bool? status;
  bool? present;

  AttendanceresModel({this.status, this.present});

  AttendanceresModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    present = json['present'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['present'] = this.present;
    return data;
  }
}

class AttendancereportModel {
  String? status;
  List<ARData>? data;

  AttendancereportModel({this.status, this.data});

  AttendancereportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ARData>[];
      json['data'].forEach((v) {
        data!.add(new ARData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ARData {
  String? name;
  List<String>? attendance;

  ARData({this.name, this.attendance});

  ARData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    attendance = json['attendance'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['attendance'] = this.attendance;
    return data;
  }
}
