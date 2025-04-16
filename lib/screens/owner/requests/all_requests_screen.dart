import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/dummy_data/ContactMessage.dart';
import 'package:pioneer_project/screens/owner/requests/request_details_screen.dart';
import 'package:pioneer_project/theming/colors.dart';
import 'package:pioneer_project/helpers/constants.dart';


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
        body: ListView.separated(
          itemCount: dummyMessages.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final message = dummyMessages[index];
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ContactMessageDetailScreen(message: message),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
