class WorkEntryModel {
  String? status;
  String? message;

  WorkEntryModel({this.status, this.message});

  WorkEntryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.message;
    return data;
  }
}

class WorkEntryDataModel {
  String? status;
  List<Data>? data;
  int? totalCredited;
  int? totalDebited;
  int? totalBalance;

  WorkEntryDataModel(
      {this.status,
      this.data,
      this.totalCredited,
      this.totalDebited,
      this.totalBalance});

  WorkEntryDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalCredited = json['totalCredited'];
    totalDebited = json['totalDebited'];
    totalBalance = json['totalBalance'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? sId;
  String? date;
  String? registerNumber;
  String? description;
  int? debit;
  int? credit;
  int? balance;
  String? reference;
  String? phoneNumber;
  int? iV;

  Data(
      {this.sId,
      this.date,
      this.registerNumber,
      this.description,
      this.debit,
      this.credit,
      this.balance,
      this.reference,
      this.phoneNumber,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    registerNumber = json['registerNumber'];
    description = json['description'];
    debit = json['debit'];
    credit = json['credit'];
    balance = json['balance'];
    reference = json['reference'];
    phoneNumber = json['phoneNumber'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['registerNumber'] = this.registerNumber;
    data['description'] = this.description;
    data['debit'] = this.debit;
    data['credit'] = this.credit;
    data['balance'] = this.balance;
    data['reference'] = this.reference;
    data['phoneNumber'] = this.phoneNumber;
    data['__v'] = this.iV;
    return data;
  }
}
