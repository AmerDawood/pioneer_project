
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/screens/auth/forget-password/reset_password_screen.dart';
import 'package:pioneer_project/theming/colors.dart';
import 'package:pioneer_project/widgets/app_text_button.dart';
import 'package:pioneer_project/widgets/app_text_form_field.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: ColorsManager.primary,
                child: Center(
                  child:SvgPicture.asset(Images.logo,color: Colors.white,),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 300.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        AppTextFormField(
                          hintText: 'Email',
                          // suffixIcon: Icon(Icons.email),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextButton(
                        buttonText: 'Send Code',
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                            return ResetPasswordScreen();
                          }));
                        }),
                  ),

            

                  


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
