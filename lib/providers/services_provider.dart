import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/Service.dart';

class ServicesProvider with ChangeNotifier {
  List<Service>? _services = [];
  List<Service>? get services => [..._services!];

  Future<void> get_services_types() async {
    try {
      final url = Uri.parse(
        'https://aqaratic.digitalfuture.sa/api/v1/mobile/form-service',
      );
      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> loadedServices = convert.jsonDecode(response.body);
        _services = loadedServices.map((service) {
          final Service serviceData = Service.fromJson(
            service,
          );
          return serviceData;
        }).toList();
        notifyListeners();
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> post_services(Map<String, dynamic> serviceData) async {
    try {
      final url = Uri.parse(
        'https://aqaratic.digitalfuture.sa/api/v1/mobile/form-service',
      );

      final service = convert.jsonEncode(serviceData);
      // Await the http post response.
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
        },
        body: service,
      );

      final responseJson = convert.jsonDecode(response.body);
      if (response.statusCode == 200 && responseJson['errors'] == null) {
        return "succeed_form";
      } else {
        return "test";
        // return responseJson['message'].toString();
      }
    } catch (e) {
      rethrow;
    }
  }
}
