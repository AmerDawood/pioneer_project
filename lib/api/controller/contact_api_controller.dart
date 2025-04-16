
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pioneer_project/api/api_settings.dart';

import '../../models/ContactMessage.dart';

class ContactApiController {






  Future<void> sendContactMessage(ContactMessage contact) async {
    final url = Uri.parse(ApiSettings.CONTACT); // عدّل الرابط حسب الحاجة

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        // إذا كان المستخدم مسجل الدخول:
        // 'Authorization': 'Bearer YOUR_TOKEN',
      },
      body: jsonEncode(contact.toJson()),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print('تم إرسال الرسالة: ${responseData['message']}');
    } else {
      print('فشل في إرسال الرسالة: ${response.statusCode}');
      print('الرد: ${response.body}');
      throw Exception('فشل في إرسال الرسالة');
    }
  }

  // Future<List<ContactMessage>> getAllMessages() async {
  //   final response = await http.get(
  //     Uri.parse('${ApiSettings.CONTACT}/contact-messages'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Accept': 'application/json',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     List jsonList = json.decode(response.body);
  //     return jsonList.map((json) => ContactMessage.fromJson(json)).toList();
  //   } else {
  //     throw Exception('فشل في جلب الرسائل');
  //   }
  // }
  //
  // Future<ContactMessage> getMessageById(int id) async {
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/contact-messages/$id'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Accept': 'application/json',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return ContactMessage.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('فشل في جلب تفاصيل الرسالة');
  //   }
  // }


}