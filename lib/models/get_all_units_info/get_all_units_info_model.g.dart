// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_units_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllUnitsInfoModel _$GetAllUnitsInfoModelFromJson(
        Map<String, dynamic> json) =>
    GetAllUnitsInfoModel(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e))
          .toList(),
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      totalPages: json['totalPages'] as int?,
      totalResults: json['totalResults'] as int?,
    );

Map<String, dynamic> _$GetAllUnitsInfoModelToJson(
        GetAllUnitsInfoModel instance) =>
    <String, dynamic>{
      'results': instance.results,
      'page': instance.page,
      'limit': instance.limit,
      'totalPages': instance.totalPages,
      'totalResults': instance.totalResults,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      images: (json['images'] as List<String>?)?.map((e) => e).toList(),
      title: json['title'] as String?,
      address: json['address'] as String?,
      locationLat: json['locationLat'] as String?,
      locationLon: json['locationLon'] as String?,
      description: json['description'] as String?,
      area: json['area'] as int?,
      rooms: json['rooms'] as int?,
      price: json['price'] as int?,
      unitType: json['unitType'] as String?,
      regNumber: json['regNumber'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'images': instance.images,
      'title': instance.title,
      'address': instance.address,
      'locationLat': instance.locationLat,
      'locationLon': instance.locationLon,
      'description': instance.description,
      'area': instance.area,
      'rooms': instance.rooms,
      'price': instance.price,
      'unitType': instance.unitType,
      'regNumber': instance.regNumber,
      'id': instance.id,
    };
