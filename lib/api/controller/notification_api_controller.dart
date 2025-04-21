import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/Notifications.dart';
import '../../perfs/user_preference_controller.dart';
import '../api_settings.dart';
import 'package:http/http.dart' as http;
class NotificationApiController {


  Future<List<NotificationModel>> fetchNotifications() async {
    final token = await UserPreferenceController().getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiSettings.NOTIFICATIONS),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load notifications. Status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error while fetching notifications: $e');
      rethrow;
    }
  }

  Future<void> markNotificationAsRead(int id) async {
    final token = await UserPreferenceController().getToken();
    final url = Uri.parse('${ApiSettings.NOTIFICATIONS}/$id/read');

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      debugPrint("Notification marked as read.");
    } else {
      debugPrint("Failed to mark as read.");
    }
  }


  Future<void> deleteNotification(int id) async {
    final token = await UserPreferenceController().getToken();
    final url = Uri.parse('${ApiSettings.NOTIFICATIONS}/$id');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      debugPrint("Notification deleted.");
    } else {
      debugPrint("Failed to delete notification.");
    }
  }



  // admin add notification



  Future<bool> addNotificatio({
    required String user_id,
    required String title,
    required String message,
  }) async {
    var url = Uri.parse(ApiSettings.NOTIFICATIONS_STORE);

    String? token = await UserPreferenceController().getToken();

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['user_id'] = user_id;
    request.fields['title'] = title;
    request.fields['message'] = message;


    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('تمت إضافة بنجاح');
      return true;
    } else {
      print('فشل في إضافة : ${response.statusCode}');
      return false;
    }
  }




}