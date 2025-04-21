import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/api/controller/contact_api_controller.dart'; // Import your API controller
import 'package:pioneer_project/screens/owner/requests/request_details_screen.dart'; // Adjust according to your screen
import 'package:pioneer_project/theming/colors.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/models/ContactMessage.dart'; // Import your model

class ContactMessagesScreen extends StatelessWidget {
  const ContactMessagesScreen({super.key});

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
        body: FutureBuilder<List<ContactMessage>>(
          future: ContactApiController().getAllMessages(),  // Fetching the messages
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('فشل في جلب الرسائل: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('لا توجد رسائل.'));
            }

            final messages = snapshot.data!;

            return ListView.separated(
              itemCount: messages.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(
                    message.fullName,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    message.subject,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ContactMessageDetailScreen(messageId:'1',),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
