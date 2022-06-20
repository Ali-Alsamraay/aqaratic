import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../helper/constants.dart';
import 'Auth_Provider.dart';

class FavoritesProvider extends ChangeNotifier {
  Map<String, dynamic> _favorite_settings = {};

  Map<String, dynamic> get favorite_settings => {..._favorite_settings};

  Map<String, dynamic> _favorites_prams = {
    "propertyTypeData": "",
    "country": "",
    "cityId": "",
    "countryStats": "",
    "min_size": "",
    "max_size": "",
    "min_price": "",
    "max_price": "",
    "propertyFor": "",
  };

  Map<String, dynamic> get favorites_prams => {..._favorites_prams};

  void set_favorites_prams(String updated_filtration_pram, String key) {
    _favorites_prams[key] = updated_filtration_pram;
    notifyListeners();
  }

  void clear_favorites_prams() {
    _favorites_prams = {
      "propertyTypeData": "",
      "country": "",
      "cityId": "",
      "countryStats": "",
      "min_size": "",
      "max_size": "",
      "min_price": "",
      "max_price": "",
      "propertyFor": "",
    };
    notifyListeners();
  }

  Future<String?> add_selected_favorites() async {
    try {
      final String? token = await AuthProvider().getUserToken();
      if (token != null && token != "") {
        final url = Uri.parse(
          baseUrl + '/api/v1/mobile/user/favorite-settings/store',
        );
        log(favorites_prams.toString());
        final response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            "Authorization": "bearer " + token,
            "Accept-Encoding": "gzip, deflate, br",
          },
          body: convert.jsonEncode(favorites_prams),
        );
        final Map<String, dynamic> jsonResponse =
            convert.jsonDecode(response.body);
        if (response.statusCode == 200) {
          return jsonResponse["message"];
        }
      }
    } catch (e) {}
  }

  Future<void> get_favorites() async {
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

      final jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        _favorite_settings = jsonResponse;
        notifyListeners();
      }
    } catch (e) {}
  }
}
