
import 'dart:convert';

// import 'package:advertisement/prefs/user_preference_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helpers/helpers.dart';
import '../../models/initiativeOwnerRegisterRequest.dart';
import '../../models/user.dart';
import '../../perfs/user_preference_controller.dart';
import '../api_settings.dart';

import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'dart:io';

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
  Future<bool> updateProfile({
    required String name,
    required String phone,
    String? profileImagePath,
  }) async {
    final uri = Uri.parse(ApiSettings.UPDATE_PROFILE);
    final token = await UserPreferenceController().getToken(); // استخدام await هنا لاسترجاع التوكن بشكل غير متزامن

    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token'; // التوكن يجب أن يكون مع 'Bearer' في الهيدر
    request.headers['Accept'] = 'application/json';

    request.fields['name'] = name;
    request.fields['phone'] = phone;

    if (profileImagePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'profile_picture',
        profileImagePath,
      ));
    }

    try {
      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody.body);
        print('تم التحديث بنجاح: ${data['message']}');
        return true;  // إرجاع true عند نجاح التحديث
      } else {
        final errorData = jsonDecode(responseBody.body);
        print('فشل التحديث: ${errorData['errors']}');
        return false;  // إرجاع false في حالة الفشل
      }
    } catch (e) {
      print('حدث خطأ أثناء الاتصال بالسيرفر: $e');
      return false;  // إرجاع false في حال حدوث خطأ في الاتصال
    }
  }
  Future<bool> loginOwner({required String email, required String password}) async {
    var url = Uri.parse(ApiSettings.LOGINOWNER);
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



  Future<bool> registerInitiativeOwner(InitiativeOwnerRegisterRequest data) async {
    var uri = Uri.parse(ApiSettings.RegisterInitiativeOwnerScreen);

    var request = http.MultipartRequest('POST', uri);

    request.fields['org_name'] = data.orgName;
    request.fields['country'] = data.country;
    request.fields['city'] = data.city;
    request.fields['type'] = data.type;
    request.fields['sector'] = data.sector;
    request.fields['size'] = data.size;
    request.fields['first_name'] = data.firstName;
    request.fields['last_name'] = data.lastName;
    request.fields['job_title'] = data.jobTitle;
    request.fields['email'] = data.email;
    request.fields['password'] = data.password;
    request.fields['password_confirmation'] = data.confirmPassword;
    request.fields['preferred_language'] = data.preferredLanguage;
    request.fields['founded_at'] = data.foundedAt;
    request.fields['website'] = data.website;

    if (data.orgLogoPath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'org_logo',
        data.orgLogoPath!,
        contentType: MediaType('image', 'jpeg'), // تأكد من النوع
      ));
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      var body = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(body);
      print("تم التسجيل بنجاح: ${jsonResponse['token']}");
      return true;
    } else {
      print('فشل التسجيل: ${response.statusCode}');
      var body = await response.stream.bytesToString();
      print(body);
      return false;
    }
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

