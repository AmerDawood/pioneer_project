
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';

import '../../../theming/colors.dart';
import '../../home/app.dart';
import '../../profile/ui/profile_screen.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key});

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (c){
                            return AppScreen();
                          }));
                        },
                        child: Icon(Icons.arrow_back)),
                    Text('عنوان الخبر',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.abc_outlined,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),



              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Image.asset('assets/news/IMG_8661.jpg',fit: BoxFit.cover,),
                ),
              ),


              ListTile(
                leading: Text('العوان / ',
                style: TextStyle(
                   color: Colors.black,
                   fontSize: 20
                ),
                ),
                title: Text('عنوان الخبر هنا'),
              ),
                ListTile(
                leading: Text('المؤسسة / ',
                style: TextStyle(
                   color: Colors.black,
                   fontSize: 20
                ),
                ),
                title: Text('اسم الؤسسة هنا'),
              ),

                ListTile(
                leading: Text('تاريخ الانتهاء / ',
                style: TextStyle(
                   color: Colors.black,
                   fontSize: 20
                ),
                ),
                title: Text('٢٢/٤/٢٠٢٥'),
              ),

              ListTile(
                leading: Text('عدد المتطوعين  / ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
                title: Text('١٠٠'),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('الوصف',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(' الوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصف الوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصفالوصف الوصف الوصف',

                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w200,
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
