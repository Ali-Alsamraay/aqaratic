import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../helper/constants.dart';

class FavoritePropertiesProvider extends ChangeNotifier {
  Map<String, dynamic> _favorite_properties = {};
  List<Map<String, dynamic>> _favorite_form_fields = [];

  Map<String, dynamic> get favorite_properties => _favorite_properties;
  List<Map<String,dynamic>> get favorite_form_fields => _favorite_form_fields;

  Future<void> get_favorite_properties() async {
    try {
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/user/favorite-settings/create',
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
        _favorite_properties = jsonResponse;
        notifyListeners();
      }
    } catch (e) {}
  }
}
