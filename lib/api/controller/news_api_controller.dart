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
  try {
    var url = Uri.parse('https://pioneer-project-2025.shop/api/news');
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

    // قراءة محتوى الرد كنص
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('تمت إضافة الخبر بنجاح');
      return true;
    } else {
      print('فشل في إضافة الخبر: ${response.statusCode}');
      print('رسالة الخطأ من السيرفر: $responseBody');
      return false;
    }
  } catch (e) {
    print('حدث خطأ أثناء إضافة الخبر: $e');
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

  var url = Uri.parse(ApiSettings.NEWS_BY_ID.replaceFirst('{id}', id));
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



Future<bool> deleteNews(String id) async {
  var url = Uri.parse('${ApiSettings.DEKETEEWS.replaceFirst('{id}', id)}');
  String? token = await UserPreferenceController().getToken();

  var response = await http.delete(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 204) {
    print('تم حذف الخبر بنجاح');
    return true;
  } else {
    print('فشل في حذف الخبر: ${response.statusCode}');
    return false;
  }
}

Future<bool> updateNews({
  required int id,
  required String title,
  required String details,
  File? image,
}) async {
  try {
    var url = Uri.parse('https://pioneer-project-2025.shop/api/news/$id');
    String? token = await UserPreferenceController().getToken();

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';

    // Laravel يتطلب هذا لتحويل POST إلى PUT
    request.fields['_method'] = 'PUT';

    request.fields['title'] = title;
    request.fields['details'] = details;

    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', image.path),
      );
    }

    var response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print('✅ تم تحديث الخبر بنجاح');
      return true;
    } else {
      print('❌ فشل في تحديث الخبر: ${response.statusCode}');
      print('رسالة الخطأ من السيرفر: $responseBody');
      return false;
    }
  } catch (e) {
    print('🔥 حدث خطأ أثناء تحديث الخبر: $e');
    return false;
  }
}
