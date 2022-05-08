/// user : {"name":"","email":"","role":"user","isMobileVerified":false,"mobile":"966548797979","usertype":"621a4f327338cf2bb0bc2687","reg_number":"123456","id":"621a31aa9d0abd239c365ca4"}
/// tokens : {"access":{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MjFhMzFhYTlkMGFiZDIzOWMzNjVjYTQiLCJpYXQiOjE2NDkxMDI4ODUsImV4cCI6MTY0OTEwNDY4NSwidHlwZSI6ImFjY2VzcyJ9.RGMDvAdFwRGJHv50tpYVXXk5N_trpxKqbT5I0qHaWIE","expires":"2022-04-04T20:38:05.240Z"},"refresh":{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MjFhMzFhYTlkMGFiZDIzOWMzNjVjYTQiLCJpYXQiOjE2NDkxMDI4ODUsImV4cCI6MTY1MTY5NDg4NSwidHlwZSI6InJlZnJlc2gifQ.1dbrxHfvxyDlJB00VpqFOuv8VGYvJI7JwbLmliVnXjE","expires":"2022-05-04T20:08:05.241Z"}}
import 'package:json_annotation/json_annotation.dart';
part 'get_login_info_model.g.dart';

@JsonSerializable()
class GetLoginInfoModel {
  GetLoginInfoModel({
    User? user,
    Tokens? tokens,
  }) {
    _user = user;
    _tokens = tokens;
  }

  GetLoginInfoModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }
  User? _user;
  Tokens? _tokens;
  GetLoginInfoModel copyWith({
    User? user,
    Tokens? tokens,
  }) =>
      GetLoginInfoModel(
        user: user ?? _user,
        tokens: tokens ?? _tokens,
      );
  User? get user => _user;
  Tokens? get tokens => _tokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_tokens != null) {
      map['tokens'] = _tokens?.toJson();
    }
    return map;
  }
}

/// access : {"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MjFhMzFhYTlkMGFiZDIzOWMzNjVjYTQiLCJpYXQiOjE2NDkxMDI4ODUsImV4cCI6MTY0OTEwNDY4NSwidHlwZSI6ImFjY2VzcyJ9.RGMDvAdFwRGJHv50tpYVXXk5N_trpxKqbT5I0qHaWIE","expires":"2022-04-04T20:38:05.240Z"}
/// refresh : {"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MjFhMzFhYTlkMGFiZDIzOWMzNjVjYTQiLCJpYXQiOjE2NDkxMDI4ODUsImV4cCI6MTY1MTY5NDg4NSwidHlwZSI6InJlZnJlc2gifQ.1dbrxHfvxyDlJB00VpqFOuv8VGYvJI7JwbLmliVnXjE","expires":"2022-05-04T20:08:05.241Z"}
@JsonSerializable()
class Tokens {
  Tokens({
    Access? access,
    Refresh? refresh,
  }) {
    _access = access;
    _refresh = refresh;
  }

  Tokens.fromJson(dynamic json) {
    _access = json['access'] != null ? Access.fromJson(json['access']) : null;
    _refresh =
        json['refresh'] != null ? Refresh.fromJson(json['refresh']) : null;
  }
  Access? _access;
  Refresh? _refresh;
  Tokens copyWith({
    Access? access,
    Refresh? refresh,
  }) =>
      Tokens(
        access: access ?? _access,
        refresh: refresh ?? _refresh,
      );
  Access? get access => _access;
  Refresh? get refresh => _refresh;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_access != null) {
      map['access'] = _access?.toJson();
    }
    if (_refresh != null) {
      map['refresh'] = _refresh?.toJson();
    }
    return map;
  }
}

/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MjFhMzFhYTlkMGFiZDIzOWMzNjVjYTQiLCJpYXQiOjE2NDkxMDI4ODUsImV4cCI6MTY1MTY5NDg4NSwidHlwZSI6InJlZnJlc2gifQ.1dbrxHfvxyDlJB00VpqFOuv8VGYvJI7JwbLmliVnXjE"
/// expires : "2022-05-04T20:08:05.241Z"
@JsonSerializable()
class Refresh {
  Refresh({
    String? token,
    String? expires,
  }) {
    _token = token;
    _expires = expires;
  }

  Refresh.fromJson(dynamic json) {
    _token = json['token'];
    _expires = json['expires'];
  }
  String? _token;
  String? _expires;
  Refresh copyWith({
    String? token,
    String? expires,
  }) =>
      Refresh(
        token: token ?? _token,
        expires: expires ?? _expires,
      );
  String? get token => _token;
  String? get expires => _expires;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['expires'] = _expires;
    return map;
  }
}

/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MjFhMzFhYTlkMGFiZDIzOWMzNjVjYTQiLCJpYXQiOjE2NDkxMDI4ODUsImV4cCI6MTY0OTEwNDY4NSwidHlwZSI6ImFjY2VzcyJ9.RGMDvAdFwRGJHv50tpYVXXk5N_trpxKqbT5I0qHaWIE"
/// expires : "2022-04-04T20:38:05.240Z"
@JsonSerializable()
class Access {
  Access({
    String? token,
    String? expires,
  }) {
    _token = token;
    _expires = expires;
  }

  Access.fromJson(dynamic json) {
    _token = json['token'];
    _expires = json['expires'];
  }
  String? _token;
  String? _expires;
  Access copyWith({
    String? token,
    String? expires,
  }) =>
      Access(
        token: token ?? _token,
        expires: expires ?? _expires,
      );
  String? get token => _token;
  String? get expires => _expires;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['expires'] = _expires;
    return map;
  }
}

/// name : ""
/// email : ""
/// role : "user"
/// isMobileVerified : false
/// mobile : "966548797979"
/// usertype : "621a4f327338cf2bb0bc2687"
/// reg_number : "123456"
/// id : "621a31aa9d0abd239c365ca4"
@JsonSerializable()
class User {
  User({
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

  User.fromJson(dynamic json) {
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
  User copyWith({
    String? name,
    String? email,
    String? role,
    bool? isMobileVerified,
    String? mobile,
    String? usertype,
    String? regNumber,
    String? id,
  }) =>
      User(
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
