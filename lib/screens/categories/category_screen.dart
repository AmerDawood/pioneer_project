
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pioneer_project/helpers/constants.dart';


import '../../helpers/spacing.dart';
import '../../theming/colors.dart';
import '../../widgets/app_text_form_field.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
         textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:AppBar(
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
          actions:[
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
                    Text('Test Test'),
                    Icon(Icons.abc_outlined,color: Colors.transparent,),
                  ],
                ),
              ),
             Padding(
               padding: const EdgeInsets.all(15.0),
               child: AppTextFormField(hintText: 'Search',suffixIcon: Icon(Icons.search),),
             ),
              Container(
                height: 170,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  children: [
                    verticalSpace(15),
                   SizedBox(
                    height: 80,
                    width: 60,
                    child: SvgPicture.asset(Images.logo)),
                   Padding(
                     padding: const EdgeInsets.all(18.0),
                     child: Text('test test',
                     style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                     ),
                     ),
                   )],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
