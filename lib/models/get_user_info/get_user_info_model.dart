/// name : "Wael"
/// email : ""
/// role : "user"
/// isMobileVerified : false
/// mobile : "966548797979"
/// usertype : "621a4f327338cf2bb0bc2687"
/// reg_number : "123456"
/// id : "621a31aa9d0abd239c365ca4"

import 'package:json_annotation/json_annotation.dart';
part 'get_user_info_model.g.dart';

@JsonSerializable()
class GetUserInfoModel {
  GetUserInfoModel({
    String? name,
    String? email,
    String? role,
    bool? isMobileVerified,
    String? mobile,
    String? usertype,
    String? regNumber,
    String? id,
  }) {
    _name = name;
    _email = email;
    _role = role;
    _isMobileVerified = isMobileVerified;
    _mobile = mobile;
    _usertype = usertype;
    _regNumber = regNumber;
    _id = id;
  }

  GetUserInfoModel.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _role = json['role'];
    _isMobileVerified = json['isMobileVerified'];
    _mobile = json['mobile'];
    _usertype = json['usertype'];
    _regNumber = json['reg_number'];
    _id = json['id'];
  }
  String? _name;
  String? _email;
  String? _role;
  bool? _isMobileVerified;
  String? _mobile;
  String? _usertype;
  String? _regNumber;
  String? _id;
  GetUserInfoModel copyWith({
    String? name,
    String? email,
    String? role,
    bool? isMobileVerified,
    String? mobile,
    String? usertype,
    String? regNumber,
    String? id,
  }) =>
      GetUserInfoModel(
        name: name ?? _name,
        email: email ?? _email,
        role: role ?? _role,
        isMobileVerified: isMobileVerified ?? _isMobileVerified,
        mobile: mobile ?? _mobile,
        usertype: usertype ?? _usertype,
        regNumber: regNumber ?? _regNumber,
        id: id ?? _id,
      );
  String? get name => _name;
  String? get email => _email;
  String? get role => _role;
  bool? get isMobileVerified => _isMobileVerified;
  String? get mobile => _mobile;
  String? get usertype => _usertype;
  String? get regNumber => _regNumber;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['role'] = _role;
    map['isMobileVerified'] = _isMobileVerified;
    map['mobile'] = _mobile;
    map['usertype'] = _usertype;
    map['reg_number'] = _regNumber;
    map['id'] = _id;
    return map;
  }
}
