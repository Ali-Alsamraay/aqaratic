// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_register_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRegisterInfo _$GetRegisterInfoFromJson(Map<String, dynamic> json) =>
    GetRegisterInfo(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      statusOTP: json['statusOTP'] as bool?,
    );

Map<String, dynamic> _$GetRegisterInfoToJson(GetRegisterInfo instance) =>
    <String, dynamic>{
      'user': instance.user,
      'statusOTP': instance.statusOTP,
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
