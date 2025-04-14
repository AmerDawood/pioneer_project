
import 'dart:convert';

// import 'package:advertisement/prefs/user_preference_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helpers/helpers.dart';
import '../../models/user.dart';
import '../../perfs/user_preference_controller.dart';
import '../api_settings.dart';

class AuthApiController  with Helpers{

  Future<bool> login({required String email, required String password}) async {
    var url = Uri.parse(ApiSettings.LOGIN);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print('RESPONSE JSON: $jsonResponse');

      // نسحب بيانات المستخدم
      var userData = jsonResponse['user'];
      var token = jsonResponse['token'];

      // نضيف التوكن لليوزر قبل ما نبنيه
      userData['token'] = token;
      // print(user.token);
      var data = jsonDecode(response.body);
      AuthResponse auth = AuthResponse.fromJson(data);
      // بناء الكائن
      User user = User.fromJson(userData);
      await UserPreferenceController().saveUser(user: auth.user, token: auth.token);



      // بإمكانك تخزينه إذا أردت
      // await UserPreferenceController().saveUser(user: user);

      return true;
    } else if (response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      print('Login failed: ${jsonResponse['message']}');
    } else {
      print('Unexpected error: ${response.statusCode}');
    }

    return false;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    var url = Uri.parse(ApiSettings.REGISTER);
    var response = await http.post(url, body: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      User user = User.fromJson({
        ...jsonResponse['user'],
        'token': jsonResponse['token'],
      });
      return true;
    } else if (response.statusCode == 400) {
      // You can parse and show server error if needed
    }
    return false;
  }
}


class AuthResponse {
  final User user;
  final String token;

  AuthResponse({required this.user, required this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

