// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserInfoModel _$GetUserInfoModelFromJson(Map<String, dynamic> json) =>
    GetUserInfoModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      isMobileVerified: json['isMobileVerified'] as bool?,
      mobile: json['mobile'] as String?,
      usertype: json['usertype'] as String?,
      regNumber: json['regNumber'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$GetUserInfoModelToJson(GetUserInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'isMobileVerified': instance.isMobileVerified,
      'mobile': instance.mobile,
      'usertype': instance.usertype,
      'regNumber': instance.regNumber,
      'id': instance.id,
    };
