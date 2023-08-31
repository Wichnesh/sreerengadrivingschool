class LearnerregDataModel {
  String? status;
  List<LRData>? data;

  LearnerregDataModel({this.status, this.data});

  LearnerregDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <LRData>[];
      json['data'].forEach((v) {
        data!.add(LRData.fromJson(v));
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

class LRData {
  String? sId;
  String? admissionDate;
  List<String>? cvString;
  List<String>? scheduleDays;
  String? name;
  int? amount;
  int? advance;
  int? balance;
  String? phoneNumber;
  int? iV;

  LRData(
      {this.sId,
      this.admissionDate,
      this.cvString,
      this.scheduleDays,
      this.name,
      this.amount,
      this.advance,
      this.balance,
      this.phoneNumber,
      this.iV});

  LRData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    admissionDate = json['admissionDate'];
    cvString = json['cvString'].cast<String>();
    scheduleDays = json['scheduleDays'].cast<String>();
    name = json['name'];
    amount = json['amount'];
    advance = json['advance'];
    balance = json['balance'];
    phoneNumber = json['phoneNumber'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['admissionDate'] = this.admissionDate;
    data['cvString'] = this.cvString;
    data['scheduleDays'] = this.scheduleDays;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['advance'] = this.advance;
    data['balance'] = this.balance;
    data['phoneNumber'] = this.phoneNumber;
    data['__v'] = this.iV;
    return data;
  }
}
