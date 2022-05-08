// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_lookups_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLookupsInfoModel _$GetLookupsInfoModelFromJson(Map<String, dynamic> json) =>
    GetLookupsInfoModel(
      active: json['active'] as bool?,
      lookuptype: json['lookuptype'] as String?,
      lookupname: json['lookupname'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$GetLookupsInfoModelToJson(
        GetLookupsInfoModel instance) =>
    <String, dynamic>{
      'active': instance.active,
      'lookuptype': instance.lookuptype,
      'lookupname': instance.lookupname,
      'id': instance.id,
    };
