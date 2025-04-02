import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pioneer_project/models/news.dart';

import '../api_settings.dart';


class NewsApiController {
  // Get all news
  Future<List<News>> getNews() async {
    var url = Uri.parse(ApiSettings.NEWS);
    var response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
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

  // Get specific news item
  Future<News> getNewsById(int id) async {
    var url = Uri.parse('${ApiSettings.NEWS}/$id');
    var response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      return News.fromJson(jsonObject);
    } else if (response.statusCode == 404) {
      throw Exception('News not found');
    } else {
      throw Exception('Failed to load news');
    }
  }

  // Create new news item
  Future<News> createNews({
    required String title,
    required String details,
    File? image,
  }) async {
    var url = Uri.parse(ApiSettings.NEWS);
    
    // Get user organization ID from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) throw Exception('User not logged in');
    final user = User.fromJson(jsonDecode(userJson));
    
    // Create multipart request
    var request = http.MultipartRequest('POST', url);
    
    // Add headers
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${user.token}';
    
    // Add fields
    request.fields['title'] = title;
    request.fields['details'] = details;
    
    // Add image if exists
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
      ));
    }
    
    // Send request
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(responseData);
      return News.fromJson(jsonResponse['news']);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else if (response.statusCode == 422) {
      var errors = jsonDecode(responseData)['errors'];
      throw Exception(errors.values.first[0]);
    } else {
      throw Exception('Failed to create news');
    }
  }

  // Update news item
  Future<News> updateNews({
    required int id,
    String? title,
    String? details,
    File? image,
    bool? deleteImage,
  }) async {
    var url = Uri.parse('${ApiSettings.NEWS}/$id');
    
    // Get user organization ID from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) throw Exception('User not logged in');
    final user = User.fromJson(jsonDecode(userJson));
    
    // Create multipart request
    var request = http.MultipartRequest('POST', url);
    request.method = 'PUT'; // Override method for PUT
    
    // Add headers
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${user.token}';
    
    // Add fields
    if (title != null) request.fields['title'] = title;
    if (details != null) request.fields['details'] = details;
    if (deleteImage == true) request.fields['image'] = 'null';
    
    // Add image if exists
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
      ));
    }
    
    // Send request
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(responseData);
      return News.fromJson(jsonResponse['news']);
    } else if (response.statusCode == 403) {
      throw Exception('Not authorized to update this news');
    } else if (response.statusCode == 404) {
      throw Exception('News not found');
    } else if (response.statusCode == 422) {
      var errors = jsonDecode(responseData)['errors'];
      throw Exception(errors.values.first[0]);
    } else {
      throw Exception('Failed to update news');
    }
  }

  // Delete news item
  Future<bool> deleteNews(int id) async {
    var url = Uri.parse('${ApiSettings.NEWS}/$id');
    
    // Get user from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) throw Exception('User not logged in');
    final user = User.fromJson(jsonDecode(userJson));
    
    var response = await http.delete(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.token}',
      },
    );
    
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw Exception('Not authorized to delete this news');
    } else if (response.statusCode == 404) {
      throw Exception('News not found');
    } else {
      throw Exception('Failed to delete news');
    }
  }
}