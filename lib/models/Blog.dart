import 'package:aqaratak/models/Comment.dart';
import 'package:flutter/foundation.dart';

class Blog with ChangeNotifier {
  int? id;
  String? title;
  String? description;
  int? view;
  String? image;
  String? short_description;
  List<Comment>? comments;

  Blog({
    this.id,
    this.title,
    this.description,
    this.view,
    this.image,
    this.short_description,
    this.comments,
  });

  Blog.fromJson(
    dynamic json,
  ) {
    this.id = json['id'];
    this.title = json['title'];
    this.description = json['description'];
    this.view = json['view'];
    this.image = json['image'];
    this.short_description = json['short_description'];
    this.comments = List<Comment>.from(
      json['comments'].map(
        (x) => Comment.fromJson(x),
      ),
    );
  }
}
