class loginModel {
  bool? status;
  bool? admin;

  loginModel({this.status, this.admin});

  loginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    admin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['isAdmin'] = this.admin;
    return data;
  }
}
