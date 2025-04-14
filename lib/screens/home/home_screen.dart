import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pioneer_project/dummy_data/initiatives.dart';
import 'package:pioneer_project/dummy_data/news.dart';
import 'package:pioneer_project/dummy_data/organizations.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/perfs/user_preference_controller.dart';

import '../../helpers/spacing.dart';
import '../../theming/colors.dart';
import '../../widgets/app_text_form_field.dart';
import '../initiative/initiatives_screen.dart';
import '../news/ui/news_details_screen.dart';
import '../news/ui/news_screen.dart';
import '../organizations/all_organizations_screen.dart';
import '../profile/ui/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                padding: const EdgeInsets.all(15.0),
                child: AppTextFormField(
                  hintText: 'البحث',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              // Text(UserPreferenceController().token),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'آخر الأخبار',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (c){
                          return NewsScreen();
                        }));
                      },
                      child: Text(
                        'عرض المزيد',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                               final newsItem = news[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (c){
                            return NewsDetailsScreen();
                          }));
                        },
                        child: Container(
                        height: 200.h,
                        width: 170.w,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 90.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                              child: Image.asset('${newsItem.image}',fit: BoxFit.cover,),
                              // child: Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: SvgPicture.asset(Images.logo),
                              // ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 90.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${newsItem.title}',
                                          maxLines: 1,
                                          style: TextStyle(

                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'لإظهار جزء من النص فقط',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                    verticalSpace(4),
                                    Row(
                                      children: [
                                        Text(
                                          '${newsItem.newsDate}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                                            ),
                      ),
                    );
                  },
                 ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المنظمات المتاحة',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c){
                          return AllOrganizationsScreen();
                        }));
                      },
                      child: Text(
                        'عرض المزيد',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(16),

              SizedBox(
                height: 120.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: organizations.length,
                          itemBuilder: (context, index) {
                            final orgItem = organizations[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black26),

                          // color: Colors.grey.shade100,
                        ),
                        child: Column(
                          children: [
                            verticalSpace(16),
                            // SvgPicture.asset(
                            //   Images.logo,
                            //   height: 30.h,
                            //   width: 30.w,
                            // ),

                            Image.asset('${orgItem.logoPath}',height: 30.h,width: 30.w,),
                            verticalSpace(10),
                            Text(
                              '${orgItem.title}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                          },
                ),
              ),

              verticalSpace(16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 180.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    // color: Colors.grey.shade100,
                  ),
                  child: Stack(
                    children: [
                      Image.asset('assets/offers/IMG_8666.JPG',fit: BoxFit.cover,width: double.infinity,),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: [
                                Text('عطاء مستمر'),
                                Spacer(),
                                SvgPicture.asset(
                                  Images.logo,
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'الوصف الوصف الوصف الوصف الوصف الوصف الوصف ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsManager.primary,
                              ),
                              onPressed: () {

                              },
                              child: Text(
                                'اضغط هنا',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),


                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(

                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'اخر المبادرات',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder:(C){
                          return InitiativesScreen();
                        }));
                      },
                      child: Text(
                        'عرض المزيد',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(16),

              SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ongoingInitiatives.length,
                          itemBuilder: (context, index) {
                             final ongoingItem = completedInitiatives[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Column(
                          children: [
                            verticalSpace(20),
                            Image.asset('${ongoingItem.imageUrl}',height: 40.h,width: 40.h,),
                            // SvgPicture.asset(Images.logo,height: 40,width: 40,),
                            verticalSpace(5),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Icon(Icons.sim_card_sharp),
                                  horizontalSpace(10),
                                  Text('${ongoingItem.title}')
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Icon(Icons.date_range),
                                  horizontalSpace(10),
                                  Text('${ongoingItem.date}')
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Icon(Icons.place),
                                  horizontalSpace(10),
                                  Text('غزة')
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),
                    );
                          },
                ),
              ),
              verticalSpace(15),
            ],
          ),
        ),
      ),
    );
  }
}
