import 'dart:convert';
import 'package:pioneer_project/models/news.dart';
import '../api_settings.dart';
import 'package:http/http.dart' as http;
class OrganizationsApiController {

  Future<List<Organization>> getOrganizations() async {
    var url = Uri.parse(ApiSettings.HOME_ORG);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      print(jsonArray);
      return jsonArray
          .map((jsonObject) => Organization.fromJson(jsonObject))
          .toList();
    } else if (response.statusCode == 400) {
      //
    }
    return [];
  }

    Future<List<Organization>> getOrganizationsById(String id) async {
    var url = Uri.parse(ApiSettings.ORGANIZATIONS_BY_ID.replaceFirst('{id}', id));

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      print(jsonArray);
      return jsonArray
          .map((jsonObject) => Organization.fromJson(jsonObject))
          .toList();
    } else if (response.statusCode == 400) {
      //
    }
    return [];
  }



}