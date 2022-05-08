// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_login_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLoginInfoModel _$GetLoginInfoModelFromJson(Map<String, dynamic> json) =>
    GetLoginInfoModel(
      user: json['user'] == null ? null : User.fromJson(json['user']),
      tokens: json['tokens'] == null ? null : Tokens.fromJson(json['tokens']),
    );

Map<String, dynamic> _$GetLoginInfoModelToJson(GetLoginInfoModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'tokens': instance.tokens,
    };

Tokens _$TokensFromJson(Map<String, dynamic> json) => Tokens(
      access: json['access'] == null ? null : Access.fromJson(json['access']),
      refresh:
          json['refresh'] == null ? null : Refresh.fromJson(json['refresh']),
    );

Map<String, dynamic> _$TokensToJson(Tokens instance) => <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
    };

Refresh _$RefreshFromJson(Map<String, dynamic> json) => Refresh(
      token: json['token'] as String?,
      expires: json['expires'] as String?,
    );

Map<String, dynamic> _$RefreshToJson(Refresh instance) => <String, dynamic>{
      'token': instance.token,
      'expires': instance.expires,
    };

Access _$AccessFromJson(Map<String, dynamic> json) => Access(
      token: json['token'] as String?,
      expires: json['expires'] as String?,
    );

Map<String, dynamic> _$AccessToJson(Access instance) => <String, dynamic>{
      'token': instance.token,
      'expires': instance.expires,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      isMobileVerified: json['isMobileVerified'] as bool?,
      mobile: json['mobile'] as String?,
      usertype: json['usertype'] as String?,
      regNumber: json['regNumber'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'isMobileVerified': instance.isMobileVerified,
      'mobile': instance.mobile,
      'usertype': instance.usertype,
      'regNumber': instance.regNumber,
      'id': instance.id,
    };
