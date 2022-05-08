import 'package:flutter/cupertino.dart';

class Service with ChangeNotifier {
  int? id;
  String? title;
  List<dynamic>? fields;
  String? first_name;
  String? last_name;
  String? email;
  String? regarding_info;
  String? phone;

  Map<String, dynamic>? serviceData;

  Service({
    this.fields,
    this.id,
    this.title,
    this.email,
    this.first_name,
    this.last_name,
    this.phone,
    this.regarding_info,
    this.serviceData,
  });

  Service.fromJson(dynamic json) {
    this.id = json['service_id'];
    this.title = json['service_title'];
    this.fields = json['fields'];
  }

  Map<String, dynamic> toJson() => {
        "service_id": this.id,
        "first_name": this.first_name,
        "last_name": this.last_name,
        "email": this.email,
        "regarding_info": this.regarding_info,
        "phone": this.phone,
      };
}
