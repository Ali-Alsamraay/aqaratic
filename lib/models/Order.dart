import 'package:flutter/foundation.dart';

class Order with ChangeNotifier {
  int? id;
  int? service_id;
  String? first_name;
  String? last_name;
  String? email;
  String? phone;
  String? regarding_info;
  String? status;
  String? created_at;
  String? updated_at;
  int? user_id;

  Order({
    this.id,
    this.service_id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.regarding_info,
    this.status,
    this.created_at,
    this.updated_at,
    this.user_id,
  });

  Order.fromJson(
    dynamic json,
  ) {
    this.id = json['id'];
    this.service_id = json['service_id'];
    this.first_name = json['first_name'];
    this.last_name = json['last_name'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.regarding_info = json['regarding_info'];
    this.status = json['status'];
    this.created_at = json['created_at'];
    this.updated_at = json['updated_at'];
    this.user_id = json['user_id'];
  }
}
