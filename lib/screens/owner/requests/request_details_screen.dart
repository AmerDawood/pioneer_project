import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/api/controller/contact_api_controller.dart'; // Import your API controller
import 'package:pioneer_project/models/ContactMessage.dart'; // Import your model
import '../../../theming/colors.dart';
import '../../../helpers/constants.dart';

class ContactMessageDetailScreen extends StatelessWidget {
  final String messageId; // Accept message ID as a string parameter

  const ContactMessageDetailScreen({super.key, required this.messageId});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          title: SvgPicture.asset(
            Images.logo,
            color: Colors.white,
            height: 35,
            width: 40,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: FutureBuilder<ContactMessage>(
          future: ContactApiController().getMessageById(messageId), // Fetch message by ID
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('فشل في جلب الرسالة: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('لا توجد بيانات'));
            }

            final message = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاسم: ${message.fullName}',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'رقم الجوال: ${message.phone}',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'الموضوع: ${message.subject}',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'نص الرسالة:',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message.message,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
