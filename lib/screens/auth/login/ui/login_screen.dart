
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/helpers/helpers.dart';
import 'package:pioneer_project/screens/auth/login/ui/widgets/email_and_password.dart';

import '../../../../helpers/spacing.dart';
import '../../../../theming/colors.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  // final LoginValidation _loginValidation = LoginValidation();

  @override
  void dispose() {
    // _loginValidation.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorsManager.primary, // ColorsManager.primary
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300.h,
                color: ColorsManager.primary, // ColorsManager.primary
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      SvgPicture.asset(
                        Images.logo,
                        color: Colors.white,
                        height: 80.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'PIONEERS',
                          style: GoogleFonts.josefinSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 32.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 700.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: const EmailAndPassword(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Directionality(
    //   textDirection: TextDirection.rtl,
    //   child: Scaffold(
    //     backgroundColor: ColorsManager.primary,
    //     body: Column(
    //       children: [
    //         Expanded(
    //           child: Container(
    //             color: ColorsManager.primary,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 verticalSpace(80),
    //                 Center(
    //               child:Column(
    //                 children: [
    //                   SvgPicture.asset(Images.logo,color: Colors.white,),
    //                    Padding(
    //                      padding: const EdgeInsets.all(10.0),
    //                      child: Text('PIONEERS',
    //                                    style: GoogleFonts.josefinSans(
    //                                      color: ColorsManager.white,
    //                                      fontWeight: FontWeight.w700,
    //                                      fontSize: 32,
    //                                    ),
    //                                  ),
    //                    )
    //                 ],
    //               ),
    //             ),
    //               ],
    //             ),
    //           ),
    //         ),
    //
    //         Container(
    //           height: 500.h,width: double.infinity,
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(20),
    //             topRight: Radius.circular(20),
    //           ),
    //         ),
    //         child:  Padding(
    //           padding: EdgeInsets.only(
    //             top: 60.h,
    //           ),
    //           child: EmailAndPassword(),
    //         ),
    //         ),
    //
    //
    //       ],
    //     ),
    //   ),
    // );
  }
}
