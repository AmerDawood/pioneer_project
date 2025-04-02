import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';
import '../../../theming/colors.dart';

class InitiativeUsersScreen extends StatefulWidget {
  const InitiativeUsersScreen({super.key});

  @override
  State<InitiativeUsersScreen> createState() => _InitiativeUsersScreenState();
}

class _InitiativeUsersScreenState extends State<InitiativeUsersScreen> {
  // Fake data for demonstration
  final List<Map<String, String>> users = [
    {'name': 'محمد علي', 'email': 'mohamed@example.com'},
    {'name': 'سارة خالد', 'email': 'sara@example.com'},
    {'name': 'أحمد حسن', 'email': 'ahmed@example.com'},
    {'name': 'ليلى حسن', 'email': 'layla@example.com'},
    {'name': 'محمود عبد الله', 'email': 'mahmoud@example.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(Images.logo, height: 20),
              ),
            ),
          ),
          title: SvgPicture.asset(
            Images.logo,
            color: Colors.white,
            height: 35,
            width: 40,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Title
              Text(
                'المستخدمين في هذه المبادرة',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // List of users
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          backgroundColor: ColorsManager.primary,
                          child: Text(
                            user['name']![0],  // First letter of the user's name
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(user['name']!),
                        subtitle: Text(user['email']!),
                        trailing: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
