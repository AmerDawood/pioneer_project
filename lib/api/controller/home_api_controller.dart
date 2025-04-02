import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pioneer_project/api/api_settings.dart';
import 'package:pioneer_project/models/home.dart';

class HomeApiController{
  

    Future<List<HomeModel>> getHomeData() async {
    var url = Uri.parse(ApiSettings.HOME);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      print(jsonArray);
      // return jsonArray
      //     .map((jsonObject) => UserNotify.fromJson(jsonObject))
      //     .toList();
    } else if (response.statusCode == 400) {
      //
    }
    return [];
  }
}