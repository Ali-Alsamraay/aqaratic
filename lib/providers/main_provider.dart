
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../helper/constants.dart';

class MainProvider with ChangeNotifier {
  Map<String, dynamic> _main_properties = {};
  List<dynamic> _contracts_file = [];

  Map<String, dynamic> get main_properties => _main_properties;
  List<dynamic> get contracts_file => _contracts_file;

  bool _is_main_properties_loaded = false;

  
  List<Map<String, dynamic>>? _property_types_items = [
    {
      "id": -1,
      "title": "الكل",
      "slug": "all",
    },
    {
      "id": 1,
      "title": "أراضي",
      "slug": "land",
      "icon_path": "assets/images/land_icon.svg",
    },
    {
      "id": 3,
      "title": "عماير",
      "slug": "buildings",
      "icon_path": "assets/images/building_icon.svg",
    },
    {
      "id": 4,
      "title": "فيلا",
      "slug": "villa",
      "icon_path": "assets/images/villa_icon.svg",
    },
    {
      "id": 19,
      "title": "شقق",
      "slug": "villa",
      "icon_path": "assets/images/building_icon.svg",
    },
  ];

  // List<Map<String, dynamic>> get property_types_items => _property_types_items;

  bool get is_main_properties_loaded => _is_main_properties_loaded;
  set is_main_properties_loaded(bool value) {
    _is_main_properties_loaded = value;
    notifyListeners();
  }

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

  Future<void> get_contracts_file() async {
    try {
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/contracts-file',
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

      final List<dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        _contracts_file = jsonResponse;
        notifyListeners();
      }
    } catch (e) {}
  }
}
