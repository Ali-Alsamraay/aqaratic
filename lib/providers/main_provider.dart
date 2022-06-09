import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../helper/constants.dart';


class MainProvider with ChangeNotifier{ 
  Map<String, dynamic> _main_properties = {};


  Map<String, dynamic> get main_properties => _main_properties;


  Future<void> get_main_properties() async {
    try {
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/home',
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
        _main_properties = jsonResponse;
        notifyListeners();
      }
    } catch (e) {}
  }

}