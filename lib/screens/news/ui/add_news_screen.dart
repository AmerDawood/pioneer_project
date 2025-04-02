import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/screens/profile/ui/profile_screen.dart';
import 'package:pioneer_project/theming/colors.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Directionality(
            textDirection: TextDirection.rtl,

      child: Scaffold(
      
        appBar: AppBar(
            backgroundColor: ColorsManager.primary,
            // leading: Icon(
            //   Icons.person_2_outlined,
            //   color: Colors.white,
            //   size: 30,
            // ),
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return ProfileScreen();
                  }));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  // minRadius: 10,
                  child: SvgPicture.asset(Images.logo,height: 20,),
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
                child:
                Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
      ),
    );
  }
}