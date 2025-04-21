import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/theming/colors.dart';

class Participant {
  final String name;
  final int age;

  Participant({required this.name, required this.age});
}
final List<Participant> dummyParticipants = [
  Participant(name: 'أحمد محمد', age: 22),
  Participant(name: 'سارة علي', age: 19),
  Participant(name: 'خالد يوسف', age: 25),
];

class ParticipantsScreen extends StatelessWidget {
  final List<Participant> participants;


  const ParticipantsScreen({super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          title: Text('قائمة المشاركين',
              style: GoogleFonts.cairo(color: Colors.white)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView.separated(
          itemCount: participants.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final participant = participants[index];
            return ListTile(
              leading: const Icon(Icons.person, size: 30),
              title: Text(
                participant.name,
                style: GoogleFonts.cairo(fontSize: 16),
              ),
              subtitle: Text(
                'العمر: ${participant.age}',
                style: GoogleFonts.cairo(fontSize: 14, color: Colors.grey[600]),
              ),
            );
          },
        ),
      ),
    );
  }
}
