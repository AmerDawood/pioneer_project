
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/theming/colors.dart';
import 'package:pioneer_project/widgets/app_text_button.dart';
import 'package:pioneer_project/widgets/app_text_form_field.dart';


class ContactusScreen extends StatelessWidget {
  const ContactusScreen({Key? key}) : super(key: key);

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
                    Icon(Icons.arrow_back),
                    Text('About App'),
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

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppTextFormField(hintText: 'Full Name'),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppTextFormField(hintText: 'Mobile'),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppTextFormField(hintText: 'Subject'),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextButton(
                    buttonText: 'Submit',
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    onPressed: () {

                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
