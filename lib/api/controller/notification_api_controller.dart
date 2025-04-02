//
//
// import 'dart:convert';
//
// import 'package:advertisement/api/api_settings.dart';
// import 'package:advertisement/models/notifiaction.dart';
// import 'package:flutter/material.dart';
// import '../api_settings.dart';
// import 'package:http/http.dart' as http;
// class NotificationApiController {
//
//   Future<List<Notification>> getNotifiaction(String id) async {
//     var url = Uri.parse(ApiSettings.NOTIFICATIONS);
//
//     var response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       var jsonResponse = jsonDecode(response.body);
//       var jsonArray = jsonResponse['data'] as List;
//       print(jsonArray);
//       // return jsonArray
//       //     .map((jsonObject) => UserNotify.fromJson(jsonObject))
//       //     .toList();
//     } else if (response.statusCode == 400) {
//       //
//     }
//     return [];
//   }
// }