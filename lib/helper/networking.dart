import 'package:aqaratak/helper/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'helper.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class NetworkHelper {
  NetworkHelper({required this.endpoint, this.params, required this.context});
  final String endpoint;
  final Map<String, dynamic>? params;
  final BuildContext context;
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future postRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    headers.addAll({'Authorization': 'Bearer $token'});
    http.Response response = await http.post(
      Uri.parse(baseURL + endpoint),
      headers: headers,
      body: jsonEncode(params),
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 399) {
      var data = response.body;
      print('response.body ${response.body}');
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      showAlert('حدث خطأ ما', context);
    }
  }

  Future getRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    headers.addAll({'Authorization': 'Bearer $token'});
    http.Response response = await http.get(
      Uri.parse(baseURL + endpoint).replace(queryParameters: params),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 399) {
      var data = response.body;
      print('response.body ${response.body}');
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      showAlert('حدث خطأ ما', context);
    }
  }

  Future patchRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    headers.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
    http.Response response = await http.patch(Uri.parse(baseURL + endpoint),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        body: params);
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 399) {
      var data = response.body;
      print('response.body ${response.body}');
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      showAlert('حدث خطأ ما', context);
    }
  }

  Future uploadImages(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    headers.addAll({
      'Authorization': 'Bearer $token',
      "Content-Type": "multipart/form-data"
    });

    Response response;

    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "aqarUnitId": '6218e3226139260f19125339',
      "fileToUpload":
          await MultipartFile.fromFile(file.path, filename: fileName),
    });
    response = await Dio().post(baseURL + uploadFileEndpoint,
        data: formData,
        options: Options(
          headers: headers,
        ));
    print(response.statusCode);
    return response.data['id'];
  }
}
