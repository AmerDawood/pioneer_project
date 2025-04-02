

import 'dart:convert';

import 'package:pioneer_project/models/initiatives.dart';
import 'package:pioneer_project/models/news.dart';

import '../api_settings.dart';
import 'package:http/http.dart' as http;


class InitiativesApiController {

  Future<List<News>> getInitiatives(String id) async {
    var url = Uri.parse(ApiSettings.INITIATIVES);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      print(jsonArray);
      // return jsonArray
      //     .map((jsonObject) => Initiatives.fromJson(jsonObject))
      //     .toList();
    } else if (response.statusCode == 400) {
      //
    }
    return [];
  }
}