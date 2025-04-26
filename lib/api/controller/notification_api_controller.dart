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



  Future<bool> addNotification({
    required String userId,
    required String title,
    required String message,
  }) async {
    final url = Uri.parse('https://pioneer-project-2025.shop/api/notifications'); // غيّر الرابط حسب API عندك
    final token = await UserPreferenceController().getToken();

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'title': title,
          'message': message,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("✅ Notification created: ${data['notification']}");
        return true;
      } else {
        print("❌ Failed to create notification: ${response.body}");
        return false;
      }
    } catch (e) {
      print("🔥 Error: $e");
      return false;
    }
  }





}