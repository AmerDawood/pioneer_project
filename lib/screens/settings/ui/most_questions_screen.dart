import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/helpers/spacing.dart';
import 'package:pioneer_project/theming/colors.dart';


class MostQuestionsScreen extends StatelessWidget {
  const MostQuestionsScreen({Key? key}) : super(key: key);


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
                    Text('الاسئلة الشائعة',
                    
                    style: GoogleFonts.josefinSans(
                    color: ColorsManager.primary,
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


              ListTile(
                leading: Text('ما هي فكرة عمل التطبيق',
                  style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
                trailing: GestureDetector(
                    onTap: (){
                      print('clicked');
                    },
                    child: Icon(Icons.keyboard_arrow_down_rounded)),
              ),


              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      width: 1.5,
                      color: ColorsManager.primary,
                    ),
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('ما هي فكرة عمل التطبيق',
                            style: GoogleFonts.cairo(
                              color: ColorsManager.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                print('clicked');
                              },
                              child: Icon(Icons.keyboard_arrow_up)),

                        ],
                      ),
                      verticalSpace(8),
                      Text('أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف. خمسة قرون من الزمن لم تقضي على هذا النص،',

                        style: GoogleFonts.cairo(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
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
