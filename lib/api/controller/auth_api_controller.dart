
import 'dart:convert';

// import 'package:advertisement/prefs/user_preference_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helpers/helpers.dart';
import '../../models/user.dart';
import '../api_settings.dart';

class AuthApiController  with Helpers{

  Future<bool> login({required String email, required String password}) async {
    var url = Uri.https(ApiSettings.LOGIN);
    var response =
    await http.post(url, body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse['token']);
      User user = User.fromJson(jsonResponse['object']);
      // UserPreferenceController().saveUser(user: user);
      return true;
    } else if (response.statusCode == 400) {
      //
    }
    return false;
  }


  Future<bool> register({
    required BuildContext context,
    required String name,
    required String email,
    required String phone,
    required String password,
    // required String password_confirmation,
    // required String type,
  }) async {
    try {
      var url = Uri.parse(ApiSettings.REGISTER);
      var response = await http.post(
          url, body: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        // 'password_confirmation': password_confirmation,
        // 'type': type,
      });

      if (response.statusCode == 201) {
        showSnackBar(
            context: context,
            message: 'User Created Successfully',
            error: false);
        return true;
      } else if (response.statusCode == 400) {
        showSnackBar(
            context: context,
            message: 'Something Error',
            error: true);
      } else {
        showSnackBar(
            context: context,
            message: 'Something went wrong, try again',
            error: true);
      }
    } catch (e) {
      showSnackBar(
          context: context,
          message: 'An error occurred: $e',
          error: true);
    }

    return false;
  }
}


