import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pioneer_project/api/api_settings.dart';
import 'package:pioneer_project/models/home.dart';

import '../../models/Initiative.dart';
import '../../models/news.dart';
import '../../perfs/user_preference_controller.dart';

class HomeApiController{

  Future<List<News>> getNews() async {
    final token = await UserPreferenceController().getToken();
    final url = Uri.parse(ApiSettings.HOME_NEWS);

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List data = jsonResponse['news']['data'];
      print('news data ${data}');
      return data.map((json) => News.fromJson(json)).toList();
    } else {
      print("Failed to load news: ${response.statusCode}");
      return [];
    }
  }


  Future<List<Organization>> getOrganizations() async {
    final token = await UserPreferenceController().getToken();
    final url = Uri.parse(ApiSettings.HOME_ORG);

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List data = jsonResponse['organizations']['data'];
      print('newwww org data ${data}');
      return data.map((json) => Organization.fromJson(json)).toList();
    } else {
      print("Failed to load organizations: ${response.statusCode}");
      return [];
    }
  }


  Future<List<Initiative>> getInitiatives() async {
    final token = await UserPreferenceController().getToken();
    final url = Uri.parse(ApiSettings.HOME_Initiatives);

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List data = jsonResponse['initiatives']['data'];
      return data.map((json) => Initiative.fromJson(json)).toList();
    } else {
      print("Failed to load initiatives: ${response.statusCode}");
      return [];
    }
  }






}