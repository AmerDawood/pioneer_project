

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/theming/colors.dart';


class SuccessResetPsswordScreen extends StatelessWidget {
  const SuccessResetPsswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        backgroundColor: ColorsManager.primary,
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: ColorsManager.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          
                        ),
                      ],
                    ),
                    Center(
                  child:Column(
                    children: [
                      SvgPicture.asset(Images.logo,color: Colors.white,),
                      Text('Pioners')
                    ],
                  ),
                ),
                  ],
                ),
              ),
            ),

            Container(
              height: 300,width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            ),
            // Container(
            // width: double.infinity,
            // height: 300.h,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.only(
            //     topRight: Radius.circular(10),
            //     topLeft: Radius.circular(10),
            //   ),
            // ),
            // child: Column(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: AppTextButton(
            //           buttonText: 'Login',
            //           textStyle: TextStyle(
            //             color: Colors.white,
            //           ),
            //           onPressed: () {}),
            //     ),
                          
                    
                
                          
                          
            //   ],
            // ),
            //               ),
        
          ],
        ),
      ),
    );
  }
}
