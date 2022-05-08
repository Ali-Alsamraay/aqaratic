import 'package:json_annotation/json_annotation.dart';
part 'get_register_info_model.g.dart';

@JsonSerializable()
class GetRegisterInfo {
  User? user;
  bool? statusOTP;

  GetRegisterInfo({this.user, this.statusOTP});

  GetRegisterInfo.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    statusOTP = json['statusOTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['statusOTP'] = this.statusOTP;
    return data;
  }
}

@JsonSerializable()
class User {
  String? name;
  String? email;
  String? role;
  bool? isMobileVerified;
  String? mobile;
  String? usertype;
  String? regNumber;
  String? id;

  User(
      {this.name,
        this.email,
        this.role,
        this.isMobileVerified,
        this.mobile,
        this.usertype,
        this.regNumber,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    isMobileVerified = json['isMobileVerified'];
    mobile = json['mobile'];
    usertype = json['usertype'];
    regNumber = json['reg_number'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['isMobileVerified'] = this.isMobileVerified;
    data['mobile'] = this.mobile;
    data['usertype'] = this.usertype;
    data['reg_number'] = this.regNumber;
    data['id'] = this.id;
    return data;
  }
}