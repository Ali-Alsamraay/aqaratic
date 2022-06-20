import 'package:aqaratak/models/Blog.dart';
import 'package:aqaratak/models/Comment.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../helper/constants.dart';

class BlogsProvider with ChangeNotifier {
  List<Blog> _blogs = [];

  List<Blog> get blogs => _blogs;

  // get blog by id
  Blog? getBlogById(int? id) {
    return _blogs.firstWhere(
      (element) => element.id == id,
    );
  }

  Future<void> get_all_blogs() async {
    try {
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/blogs',
      );

      // Await the http get response.
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
        },
      );

      final Map<String, dynamic> jsonResponse =
          convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> loadedBlogs = jsonResponse['data'];

        // loadedBlogs.forEach((element) {
        //   _blogsList.add(
        //     Blog.fromJson(element),
        //   );
        //   _commentsList.add(
        //     Comment.fromJson(element['comments']),
        //   );
        // });

        _blogs = loadedBlogs
            .map(
              (element) => Blog.fromJson(element),
            )
            .toList();
        notifyListeners();
      }
    } catch (e) {}
  }

  Future<void> createComment(
    Map<String, dynamic> commentData,
    int blogId,
  ) async {
    try {
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/blogs/comment/$blogId',
      );

      final String? requestData = convert.jsonEncode(commentData);
      // Await the http post response.
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Connection": "keep-alive",
        },
        body: requestData,
      );
    } catch (e) {
      rethrow;
    }
  }
}
