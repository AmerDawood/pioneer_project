import 'dart:convert';
import 'package:pioneer_project/models/news.dart';
import '../../perfs/user_preference_controller.dart';
import '../api_settings.dart';
import 'package:http/http.dart' as http;
class OrganizationsApiController {

  Future<List<Organization>> getOrganizations() async {
    var url = Uri.parse(ApiSettings.HOME_ORG);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      print(response);
      return jsonArray
          .map((jsonObject) => Organization.fromJson(jsonObject))
          .toList();
    } else if (response.statusCode == 400) {
      //
    }
    return [];
  }
  Future<Organization> getOrganizationById(String id) async {
    final token = await UserPreferenceController().getToken();
    var url = Uri.parse('https://pioneer-project-2025.shop/api/organizations/$id');
    var response = await http.get(url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return Organization.fromJson(jsonResponse); // مش تحتاج تروح على 'data'
    } else {
      // هنا نطبع الرد قبل رمي الخطأ
      print('خطأ في تحميل بيانات المنظمة: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('فشل في تحميل بيانات المنظمة');
    }
  }


}