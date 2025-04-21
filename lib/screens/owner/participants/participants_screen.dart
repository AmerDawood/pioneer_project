import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/theming/colors.dart';
import '../../../models/InitiativeParticipant.dart';

class ParticipantsScreen extends StatelessWidget {
  final List<InitiativeParticipant> participants;

  const ParticipantsScreen({super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          title: Text(
            'قائمة المشاركين',
            style: GoogleFonts.cairo(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: participants.isEmpty
            ? const Center(child: Text('لا يوجد مشاركين حتى الآن.'))
            : ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: participants.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final participant = participants[index];
            return ListTile(
              leading: const Icon(Icons.person, size: 30),
              title: Text(
                participant.user.name,
                style: GoogleFonts.cairo(fontSize: 16),
              ),
              // subtitle: Text(
              //   participant.user. != null
              //       ? 'العمر: ${participant.age}'
              //       : 'العمر غير متوفر',
              //   style: GoogleFonts.cairo(fontSize: 14, color: Colors.grey[600]),
              // ),
            );
          },
        ),
      ),
    );
  }
}
