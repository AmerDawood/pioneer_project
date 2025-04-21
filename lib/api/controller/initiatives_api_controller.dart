

import 'dart:convert';

import 'package:pioneer_project/models/initiatives.dart';
import 'package:pioneer_project/models/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Initiative.dart';
import '../../models/InitiativeParticipant.dart';
import '../../perfs/user_preference_controller.dart';
import '../api_settings.dart';
import 'package:http/http.dart' as http;


class InitiativesApiController {
  Future<List<Initiative>> getAllInitiatives() async {
    // Retrieve the token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');  // Make sure you store token during login/registration

    if (token == null) {
      throw Exception('User is not authenticated');
    }

    var url = Uri.parse(ApiSettings.INITIATIVES);  // Use your correct API endpoint here
    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',  // Add the token in the header
      },
    );

    if (response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body) as List;
      return jsonArray.map((jsonObject) => Initiative.fromJson(jsonObject)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load news');
    }


  }



  Future<Initiative> getInitiativesById(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');  // Make sure you store token during login/registration

    var url = Uri.parse(ApiSettings.INITIATIVES_BY_ID.replaceFirst('{id}', id));
    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',  // Add the token in the header
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var newsData = jsonResponse['data']['product']; // Extract product data

      var product = Initiative.fromJson(newsData);
      return product;
    } else {
      throw Exception('Failed to retrieve product data');
    }
  }




  // add Initiative
  Future<bool> submitInitiative({
    required String name,
    required String location,
    required String startDate,
    required String endDate,
    required int maxParticipants,
    required String details,
    required int hours,
  }) async {
    final Map<String, dynamic> requestBody = {
      'name': name,
      'location': location,
      'start_date': startDate,
      'end_date': endDate,
      'max_participants': maxParticipants,
      'details': details,
      'hours': hours,
    };

    final url = Uri.parse(ApiSettings.ADDINTEATVE);
    final token = await UserPreferenceController().getToken();

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Failed to submit initiative: ${response.body}');
      return false;
    }
  }



  //make join function


  Future<bool> joinInitiative(int id) async {

    final url = Uri.parse(ApiSettings.INITIATIVES_JOIN.replaceFirst('{id}', id as String));
    final token = await UserPreferenceController().getToken();

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      // body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Failed to Join initiative: ${response.body}');
      return false;
    }
  }


  // show all participants

  Future<List<InitiativeParticipant>> getInitiativeParticipant(String id) async {
    // Retrieve the token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');  // Make sure you store token during login/registration

    if (token == null) {
      throw Exception('User is not authenticated');
    }

    var url = Uri.parse(ApiSettings.INITIATIVES_participants.replaceFirst('{id}', id));  // Use your correct API endpoint here
    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',  // Add the token in the header
      },
    );

    if (response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body) as List;
      return jsonArray.map((jsonObject) => InitiativeParticipant.fromJson(jsonObject)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load news');
    }
  }


  // leave


  Future<bool> leaveInitiative(String id) async {

    final url = Uri.parse(ApiSettings.INITIATIVES_LEAVE.replaceFirst('{id}', id));
    final token = await UserPreferenceController().getToken();

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      // body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Failed to Join initiative: ${response.body}');
      return false;
    }
  }








}