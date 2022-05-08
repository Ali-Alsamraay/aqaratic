/// active : true
/// lookuptype : "user_type"
/// lookupname : "مطور عقاري"
/// id : "621a4ee97338cf2bb0bc2684"
import 'package:json_annotation/json_annotation.dart';
part 'get_lookups_info_model.g.dart';

@JsonSerializable()
class GetLookupsInfoModel {
  GetLookupsInfoModel({
    bool? active,
    String? lookuptype,
    String? lookupname,
    String? id,
  }) {
    _active = active;
    _lookuptype = lookuptype;
    _lookupname = lookupname;
    _id = id;
  }

  GetLookupsInfoModel.fromJson(dynamic json) {
    _active = json['active'];
    _lookuptype = json['lookuptype'];
    _lookupname = json['lookupname'];
    _id = json['id'];
  }
  bool? _active;
  String? _lookuptype;
  String? _lookupname;
  String? _id;
  GetLookupsInfoModel copyWith({
    bool? active,
    String? lookuptype,
    String? lookupname,
    String? id,
  }) =>
      GetLookupsInfoModel(
        active: active ?? _active,
        lookuptype: lookuptype ?? _lookuptype,
        lookupname: lookupname ?? _lookupname,
        id: id ?? _id,
      );
  bool? get active => _active;
  String? get lookuptype => _lookuptype;
  String? get lookupname => _lookupname;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['active'] = _active;
    map['lookuptype'] = _lookuptype;
    map['lookupname'] = _lookupname;
    map['id'] = _id;
    return map;
  }
}
