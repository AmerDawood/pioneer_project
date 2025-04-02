import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/screens/settings/ui/about_us_screen.dart';
import 'package:pioneer_project/screens/settings/ui/most_questions_screen.dart';
import 'package:pioneer_project/screens/settings/ui/privacy_screen.dart';
import 'package:pioneer_project/screens/settings/ui/terms_screen.dart';
import 'package:pioneer_project/theming/colors.dart';


class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          leading: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
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
                Icons.person_2_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back),),
                    Text('عن التطبيق',
                    
                     style: GoogleFonts.josefinSans(
                    color: ColorsManager.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                  ),
                    Icon(
                      Icons.abc_outlined,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),



              SvgPicture.asset(Images.logo,height: 80,),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('PIONEERS',
                  style: GoogleFonts.josefinSans(
                    color: ColorsManager.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ),
              
              
              
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return AboutUsScreen();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: SvgPicture.asset(Images.logo,height: 30,width: 40,),
                    title: Text('عن التطبيق'),
                    trailing: Icon(Icons.arrow_forward_ios,size: 15,),
                  ),
                ),
              ),

              InkWell(
                 onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return MostQuestionsScreen();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.question_answer),
                    title: Text('الاسئلة'),
                    trailing: Icon(Icons.arrow_forward_ios,size: 15,),
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: 8,
              //     right: 8,
              //   ),
              //   child: ListTile(
              //     leading: Icon(Icons.list_alt),
              //     title: Text('test test '),
              //     trailing: Icon(Icons.arrow_forward_ios,size: 15,),
              //   ),
              // ),

               InkWell(
                 onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return TermsScreen();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: ListTile(
                 leading: Icon(Icons.list_alt),
                    title: Text('الاحكام والشروط'),
                    trailing: Icon(Icons.arrow_forward_ios,size: 15,),
                  ),
                ),
              ),


              InkWell(
                 onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return PrivacyScreen();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.privacy_tip),
                    title: Text('الخصوصية'),
                    trailing: Icon(Icons.arrow_forward_ios,size: 15,),
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
