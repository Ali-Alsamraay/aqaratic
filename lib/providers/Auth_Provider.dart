import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

import '../helper/constants.dart';
import '../models/User.dart';

class AuthProvider with ChangeNotifier {
  User? currentUser;
  List<dynamic>? registerResponseErrorMsgs = [];
  List<dynamic>? updateResponseErrorMsgs = [];

  Future<String?> getUserToken() async {
    try {
      final SharedPreferences? sharedPreferences =
          await SharedPreferences.getInstance();
      final String? storedToken = sharedPreferences!.getString("token")!;
      return storedToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?>? isCurrentUserLoggedIn() async {
    final SharedPreferences? sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences!.getString("token") != "" &&
        sharedPreferences.getString("token") != null;
  }

  Future<User?> getCachedUser() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? user = await sharedPreferences.getString("user");

      final Map<String, dynamic> userMap = jsonDecode(user!);
      currentUser = User.fromJson(userMap);

      notifyListeners();
      return currentUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> login(
    Map<String, dynamic> userData,
  ) async {
    try {
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/user/login',
      );

      userData["remember_me"] = 1;
      final encodedUserData = convert.jsonEncode(userData);

      // Await the http post response.
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
        },
        body: encodedUserData,
      );

      final responseJson = convert.jsonDecode(response.body);
      if (response.statusCode == 200 && responseJson['data'] != null) {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        final bool tokenStored = await sharedPreferences.setString(
          "token",
          responseJson['_token'],
        );

        await sharedPreferences.setString(
          "email",
          userData['email'],
        );
        await sharedPreferences.setString(
          "password",
          userData['password'],
        );
        if (tokenStored) {
          currentUser = User.fromJsonWithCustom(responseJson["data"]);
          await sharedPreferences.setString(
            'user',
            jsonEncode(
              currentUser,
            ),
          );
          notifyListeners();
          return "logged_in";
        } else {
          currentUser = null;
          notifyListeners();
          return "token not stored.";
        }
      } else {
        return responseJson['general'] == null
            ? responseJson['msg'].toString()
            : responseJson['general'].toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> register(
    Map<String, dynamic> userData,
  ) async {
    try {
      registerResponseErrorMsgs = [];
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/user/register',
      );

      final encodedUserData = convert.jsonEncode(userData);

      // Await the http post response.
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
        },
        body: encodedUserData,
      );

      final responseJson = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        registerResponseErrorMsgs = [];
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await login(
          {
            "email": userData['email'],
            "password": userData['password'],
          },
        );
        return "registered";
      } else {
        if (responseJson['errors'] != null) {
          Map<String, dynamic>? errors =
              responseJson['errors'] as Map<String, dynamic>;
          registerResponseErrorMsgs = [];
          errors.forEach((key, value) {
            registerResponseErrorMsgs!.add(value.first);
          });
        }
        return responseJson['message'].toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> updateUser(
    Map<String, dynamic> userData,
  ) async {
    try {
      updateResponseErrorMsgs = [];
      final String? token = await getUserToken();
      if(token == null || token == "") return "not_logged_in";
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/user/profile/update',
      );

      final encodedUserData = convert.jsonEncode(userData);

      // Await the http post response.
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
          "Authorization": "Bearer $token",
        },
        body: encodedUserData,
      );

      final responseJson = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        updateResponseErrorMsgs = [];
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        currentUser = User.fromJsonWithCustom(responseJson["data"]);
        await sharedPreferences.setString(
          'user',
          jsonEncode(
            currentUser,
          ),
        );

        return "updated";
      } else {
        if (responseJson['errors'] != null) {
          Map<String, dynamic>? errors =
              responseJson['errors'] as Map<String, dynamic>;
          updateResponseErrorMsgs = [];
          errors.forEach((key, value) {
            updateResponseErrorMsgs!.add(value.first);
          });
        }
        return responseJson['message'].toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> logout() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final bool tokenUpdated = await sharedPreferences.setString("token", "");
      currentUser = null;
      return tokenUpdated;
    } catch (e) {
      rethrow;
    }
  }
}
