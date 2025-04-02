import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/helpers/spacing.dart';
import 'package:pioneer_project/theming/colors.dart';
import 'widgets/owner_email_and_password.dart';

class InitiativeOwnerLoginScreen extends StatelessWidget {
  const InitiativeOwnerLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorsManager.primary,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/splash/splash.svg',
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'تسجيل الدخول لأصحاب المبادرات',
                      style: GoogleFonts.josefinSans(
                        color: ColorsManager.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'هذا النموذج مخصص فقط لأصحاب المبادرات، يُرجى إدخال بياناتك المسجلة للوصول إلى لوحة التحكم الخاصة بمبادرتك.',
                      style: TextStyle(
                        color: ColorsManager.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 455,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: const OwnerEmailAndPassword(),
            ),
          ],
        ),
      ),
    );
  }
}
