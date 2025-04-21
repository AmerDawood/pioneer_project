


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/screens/auth/login/ui/login_screen.dart';
import 'package:pioneer_project/screens/onboarding/onboarding_screen.dart';

import '../../theming/colors.dart';


class SplashScreen extends StatefulWidget {
  
  const SplashScreen({Key? key}) : super(key: key);

  

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  
}

class _SplashScreenState extends State<SplashScreen> {

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3),(){
      // String routeName =UserPreferenceController().loggedIn ?'/app':'/page_view_screen';
      // Navigator.pushReplacementNamed(context, routeName);


      Navigator.push(context,MaterialPageRoute(builder: (c){
        return OnboardingScreen();
      }));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Images.logo),
            SizedBox(height: 32,),
            Text('PIONEERS',
              style: GoogleFonts.josefinSans(
                color: ColorsManager.primary,
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
