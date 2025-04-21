import 'dart:io';

import 'package:pioneer_project/api/api_settings.dart';
import 'package:pioneer_project/perfs/user_preference_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/news.dart';


Future<bool> addNews({
  required String title,
  required String details,
  File? image,
}) async {
  var url = Uri.parse(ApiSettings.ADDNEWS);

  String? token = await UserPreferenceController().getToken();

  var request = http.MultipartRequest('POST', url);
  request.headers['Authorization'] = 'Bearer $token';

  request.fields['title'] = title;
  request.fields['details'] = details;

  if (image != null) {
    request.files.add(
      await http.MultipartFile.fromPath('image', image.path),
    );
  }

  var response = await request.send();

  print(response.statusCode);

  if (response.statusCode == 201 || response.statusCode == 200) {
    print('تمت إضافة الخبر بنجاح');
    return true;
  } else {
    print('فشل في إضافة الخبر: ${response.statusCode}');
    return false;
  }
}

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


Future<News> getNewsById(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');  // Make sure you store token during login/registration

  var url = Uri.parse(ApiSettings.NEWS.replaceFirst('{id}', id));
  var response = await http.get(
    url,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',  // Add the token in the header
    },
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var newsData = jsonResponse['data']; // Extract the news data from the 'data' key

    var news = News.fromJson(newsData); // Parse to News object
    return news;
  } else {
    throw Exception('Failed to retrieve news data');
  }
}


