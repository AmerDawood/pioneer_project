import 'package:pioneer_project/api/api_settings.dart';
import 'package:pioneer_project/perfs/user_preference_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pioneer_project/helpers/constants.dart';

import '../../models/news.dart';  // Make sure the URL is correct

Future<List<News>> getAllNews() async {
  // Retrieve the token from shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');  // Make sure you store token during login/registration

  if (token == null) {
    throw Exception('User is not authenticated');
  }

  var url = Uri.parse(ApiSettings.NEWS);  // Use your correct API endpoint here
  var response = await http.get(
    url,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',  // Add the token in the header
    },
  );

  if (response.statusCode == 200) {
    var jsonArray = jsonDecode(response.body) as List;
    return jsonArray.map((jsonObject) => News.fromJson(jsonObject)).toList();
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to load news');
  }
}
