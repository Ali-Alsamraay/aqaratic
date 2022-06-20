import 'package:flutter/foundation.dart';

class Comment with ChangeNotifier {
  int? id;
  String? name;
  String? email;
  String? comment;
  int? blog_id;
  String? phone;
  String? created_at;

  Comment({
    this.id,
    this.name,
    this.email,
    this.comment,
    this.blog_id,
    this.phone,
    this.created_at,
  });

  Comment.fromJson(
    dynamic json,
  ) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.comment = json['comment'];
    this.blog_id = json['blog_id'];
    this.phone = json['phone'];
    this.created_at = json['created_at'];
  }
}
