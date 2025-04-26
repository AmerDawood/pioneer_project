
import 'package:flutter/material.dart';

import '../../../api/controller/initiatives_api_controller.dart';
import '../../../models/InitiativeParticipant.dart';
import '../../../theming/colors.dart';
class InitiativeParticipantsScreen extends StatefulWidget {
  final String initiativeId;

  const InitiativeParticipantsScreen({super.key, required this.initiativeId});

  @override
  State<InitiativeParticipantsScreen> createState() => _InitiativeParticipantsScreenState();
}

class _InitiativeParticipantsScreenState extends State<InitiativeParticipantsScreen> {
  late Future<List<InitiativeParticipant>> _participantsFuture;

  @override
  void initState() {
    super.initState();
    _participantsFuture = InitiativesApiController().getInitiativeParticipant(widget.initiativeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المشاركون في المبادرة'),
        backgroundColor: ColorsManager.primary,
      ),
      body: FutureBuilder<List<InitiativeParticipant>>(
        future: _participantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('لا يوجد مشاركين حتى الآن'));
          }

          final participants = snapshot.data!;
          return ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: participants.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, index) {
              final p = participants[index];
              return ListTile(
                leading: Icon(Icons.person, color: ColorsManager.primary),
                title: Text(p.user.name),
                subtitle: Text('البريد: ${p.user.email}'),
              );
            },
          );
        },
      ),
    );
  }
}
