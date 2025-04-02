import 'dart:convert';

import 'package:http/http.dart' as http;

class ContactApiController {
  //POST
   static const String baseUrl = 'http://127.0.0.1:8000/api/contact';

   static Future<bool> addContactRequest({
    required String title,
    required String description,
    required int userId,
  }) async {
    final Map<String, dynamic> requestBody = {
      'title': title,
      'description': description,
      'user_id': userId,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl'),
        headers: {
          // 'Authorization': 'Bearer ${UserPreferenceController().token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        print('Contact request added successfully');
        return true;
      } else {
        print('Failed to add contact request. Error: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while adding contact request: $e');
    }

    return false;
  }
  
}