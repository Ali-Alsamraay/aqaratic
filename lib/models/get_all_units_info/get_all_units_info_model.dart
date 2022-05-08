/// results : [{"images":["sdfsdfsdfdsfdsfsdfdsfds","sfsdfsdfdsfsdfdsfds"],"title":"AAA","address":"Aqar Address","location_lat":"24.7935889","location_lon":"46.6315389","description":"AAA description","area":600,"rooms":6,"price":10000,"unit_type":"62478380fb3a8270cce64dda","reg_number":"123456","id":"6247845c96f13593a0c48b73"}]
/// page : 1
/// limit : 10
/// totalPages : 1
/// totalResults : 1

import 'package:json_annotation/json_annotation.dart';
part 'get_all_units_info_model.g.dart';

@JsonSerializable()
class GetAllUnitsInfoModel {
  GetAllUnitsInfoModel({
    List<Results>? results,
    int? page,
    int? limit,
    int? totalPages,
    int? totalResults,
  }) {
    _results = results;
    _page = page;
    _limit = limit;
    _totalPages = totalPages;
    _totalResults = totalResults;
  }

  GetAllUnitsInfoModel.fromJson(dynamic json) {
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
    _page = json['page'];
    _limit = json['limit'];
    _totalPages = json['totalPages'];
    _totalResults = json['totalResults'];
  }
  
  List<Results>? _results;
  int? _page;
  int? _limit;
  int? _totalPages;
  int? _totalResults;
  GetAllUnitsInfoModel copyWith({
    List<Results>? results,
    int? page,
    int? limit,
    int? totalPages,
    int? totalResults,
  }) =>
      GetAllUnitsInfoModel(
        results: results ?? _results,
        page: page ?? _page,
        limit: limit ?? _limit,
        totalPages: totalPages ?? _totalPages,
        totalResults: totalResults ?? _totalResults,
      );
  List<Results>? get results => _results;
  int? get page => _page;
  int? get limit => _limit;
  int? get totalPages => _totalPages;
  int? get totalResults => _totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    map['page'] = _page;
    map['limit'] = _limit;
    map['totalPages'] = _totalPages;
    map['totalResults'] = _totalResults;
    return map;
  }
}

/// images : ["sdfsdfsdfdsfdsfsdfdsfds","sfsdfsdfdsfsdfdsfds"]
/// title : "AAA"
/// address : "Aqar Address"
/// location_lat : "24.7935889"
/// location_lon : "46.6315389"
/// description : "AAA description"
/// area : 600
/// rooms : 6
/// price : 10000
/// unit_type : "62478380fb3a8270cce64dda"
/// reg_number : "123456"
/// id : "6247845c96f13593a0c48b73"
@JsonSerializable()
class Results {
  Results({
    List<String>? images,
    String? title,
    String? address,
    String? locationLat,
    String? locationLon,
    String? description,
    int? area,
    int? rooms,
    int? price,
    String? unitType,
    String? regNumber,
    String? id,
  }) {
    _images = images;
    _title = title;
    _address = address;
    _locationLat = locationLat;
    _locationLon = locationLon;
    _description = description;
    _area = area;
    _rooms = rooms;
    _price = price;
    _unitType = unitType;
    _regNumber = regNumber;
    _id = id;
  }

  Results.fromJson(dynamic json) {
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _title = json['title'];
    _address = json['address'];
    _locationLat = json['location_lat'];
    _locationLon = json['location_lon'];
    _description = json['description'];
    _area = json['area'];
    _rooms = json['rooms'];
    _price = json['price'];
    _unitType = json['unit_type'];
    _regNumber = json['reg_number'];
    _id = json['id'];
  }
  List<String>? _images;
  String? _title;
  String? _address;
  String? _locationLat;
  String? _locationLon;
  String? _description;
  int? _area;
  int? _rooms;
  int? _price;
  String? _unitType;
  String? _regNumber;
  String? _id;
  Results copyWith({
    List<String>? images,
    String? title,
    String? address,
    String? locationLat,
    String? locationLon,
    String? description,
    int? area,
    int? rooms,
    int? price,
    String? unitType,
    String? regNumber,
    String? id,
  }) =>
      Results(
        images: images ?? _images,
        title: title ?? _title,
        address: address ?? _address,
        locationLat: locationLat ?? _locationLat,
        locationLon: locationLon ?? _locationLon,
        description: description ?? _description,
        area: area ?? _area,
        rooms: rooms ?? _rooms,
        price: price ?? _price,
        unitType: unitType ?? _unitType,
        regNumber: regNumber ?? _regNumber,
        id: id ?? _id,
      );
  List<String>? get images => _images;
  String? get title => _title;
  String? get address => _address;
  String? get locationLat => _locationLat;
  String? get locationLon => _locationLon;
  String? get description => _description;
  int? get area => _area;
  int? get rooms => _rooms;
  int? get price => _price;
  String? get unitType => _unitType;
  String? get regNumber => _regNumber;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['images'] = _images;
    map['title'] = _title;
    map['address'] = _address;
    map['location_lat'] = _locationLat;
    map['location_lon'] = _locationLon;
    map['description'] = _description;
    map['area'] = _area;
    map['rooms'] = _rooms;
    map['price'] = _price;
    map['unit_type'] = _unitType;
    map['reg_number'] = _regNumber;
    map['id'] = _id;
    return map;
  }
}
