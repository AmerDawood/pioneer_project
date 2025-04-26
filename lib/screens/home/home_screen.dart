import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pioneer_project/api/controller/home_api_controller.dart';
import 'package:pioneer_project/dummy_data/initiatives.dart';
import 'package:pioneer_project/dummy_data/news.dart';
import 'package:pioneer_project/dummy_data/organizations.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/perfs/user_preference_controller.dart';

import '../../api/api_settings.dart';
import '../../helpers/spacing.dart';
import '../../models/Initiative.dart';
import '../../models/news.dart';
import '../../theming/colors.dart';
import '../../widgets/app_text_form_field.dart';
import '../initiative/initiatives_screen.dart';
import '../news/ui/news_details_screen.dart';
import '../news/ui/news_screen.dart';
import '../organizations/all_organizations_screen.dart';
import '../profile/ui/profile_screen.dart';

class HomeScreen extends StatefulWidget {





  HomeScreen({super.key ,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Future<List<News>> news;
  late Future<List<Organization>> organizations;
  late Future<List<Initiative>> initiatives;

  @override
  void initState() {
    super.initState();
    // Initialize the Future variables here.
    news = HomeApiController().getNews();
    organizations = HomeApiController().getOrganizations();
    initiatives = HomeApiController().getInitiatives();
  }



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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
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
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (c){
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
                child: FutureBuilder<List<News>>(
                  future: news, // Use the news variable from initState
                  builder: (context, snapshot) {
                    // Handle different states of the Future
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); // Show loading spinner while fetching data
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}')); // Show error if something went wrong
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No news available')); // Show message if no data is available
                    } else {
                      final news = snapshot.data!; // Get the list of news once it's loaded

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: news.length,
                        itemBuilder: (context, index) {
                          final newsItem = news[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailsScreen(
                                      newsId: newsItem.id,
                                      title: newsItem.title,
                                      date: newsItem.newsDate,
                                      details: newsItem.details,
                                      // logo: newsItem.image!,
                                    ), // Pass the news ID dynamically
                                  ),
                                );
                              },
                              child: Container(
                                height: 200.h,
                                width: 170.w,
                                decoration: BoxDecoration(
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
                                      child: (newsItem.image != null && newsItem.image!.isNotEmpty)
                                          ? Image.network(
                                        'https://pioneer-project-2025.shop/storage/app/public/${newsItem.image}', // Build the full URL for the image
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Icon(Icons.broken_image),
                                      )
                                          : Image.asset(
                                        'assets/news/IMG_8661.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 90.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              newsItem.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17.sp,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              'لإظهار جزء من النص فقط',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              newsItem.newsDate,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                              ),
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
                      );
                    }
                  },
                ),
              ),

              // SizedBox(
              //   height: 220.h,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: news.length,
              //     itemBuilder: (context, index) {
              //                  final newsItem = news[index];
              //       return Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: InkWell(
              //           onTap: (){
              //             Navigator.pushReplacement(context,MaterialPageRoute(builder: (c){
              //               return NewsDetailsScreen(id: 1,);
              //             }));
              //           },
              //           child: Container(
              //           height: 200.h,
              //           width: 170.w,
              //           decoration: BoxDecoration(
              //             // color: Colors.red,
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(color: Colors.grey.shade200),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.grey.shade100,
              //               ),
              //             ],
              //           ),
              //           child: Column(
              //             children: [
              //               Container(
              //                 height: 90.h,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                   color: Colors.grey.shade200,
              //                   borderRadius: BorderRadius.only(
              //                     topRight: Radius.circular(10),
              //                     topLeft: Radius.circular(10),
              //                   ),
              //                 ),
              //                 child: Image.asset('${newsItem.image}',fit: BoxFit.cover,),
              //                 // child: Padding(
              //                 //   padding: const EdgeInsets.all(8.0),
              //                 //   child: SvgPicture.asset(Images.logo),
              //                 // ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Container(
              //                   height: 90.h,
              //                   width: double.infinity,
              //                   decoration: BoxDecoration(
              //                     // color: Colors.amber,
              //                     borderRadius: BorderRadius.only(
              //                       bottomRight: Radius.circular(10),
              //                       bottomLeft: Radius.circular(10),
              //                     ),
              //                   ),
              //                   child: Column(
              //                     children: [
              //                       Row(
              //                         children: [
              //                           Text(
              //                             '${newsItem.title}',
              //                             maxLines: 1,
              //                             style: TextStyle(
              //
              //                               color: Colors.black,
              //                               fontWeight: FontWeight.w600,
              //                               fontSize: 17.sp,
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                       Row(
              //                         children: [
              //                           Text(
              //                             'لإظهار جزء من النص فقط',
              //                             style: TextStyle(
              //                               color: Colors.grey,
              //                               fontWeight: FontWeight.w400,
              //                               fontSize: 15.sp,
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                       verticalSpace(4),
              //                       Row(
              //                         children: [
              //                           Text(
              //                             '${newsItem.newsDate}',
              //                             style: TextStyle(
              //                               color: Colors.black,
              //                               fontWeight: FontWeight.w400,
              //                               fontSize: 14.sp,
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //                               ),
              //         ),
              //       );
              //     },
              //    ),
              // ),

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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
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
                child: FutureBuilder<List<Organization>>(
                  future: organizations,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('فشل في تحميل المنظمات: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Center(child: Text('لا توجد منظمات حاليا'));
                    } else if (snapshot.hasData) {
                      final organizationsList = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: organizationsList.length,
                        itemBuilder: (context, index) {
                          final orgItem = organizationsList[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black26),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Check if logo is null or empty
                                  if (orgItem.logo != null && orgItem.logo!.isNotEmpty)
                                    Image.network(
                                      orgItem.logo!,
                                      height: 30.h,
                                      width: 30.w,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Icon(Icons.broken_image),
                                    )
                                  else
                                    Image.asset(
                                      'assets/organizations/IMG_8672.PNG',
                                      height: 30.h,
                                      width: 30.w,
                                      fit: BoxFit.cover,
                                    ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    orgItem.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('لا توجد بيانات'));
                    }
                  },
                ),
              ),


              verticalSpace(16),
              // Offer Section
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
                        Navigator.pushReplacement(context,MaterialPageRoute(builder:(C){
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
                child: FutureBuilder<List<Initiative>>(
                  future: initiatives, // استخدم المتغير المحلي
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('فشل في تحميل المبادرات'));
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Center(child: Text('لا توجد مبادرات حاليا'));
                    } else if (snapshot.hasData) {
                      final initiativesList = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: initiativesList.length,
                        itemBuilder: (context, index) {
                          final ongoingItem = initiativesList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black26),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/initiative/IMG_8667.PNG', // تأكد من أن المسار صحيح
                                        height: 40.h,
                                        width: 40.h,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Icon(Icons.sim_card_sharp, size: 16.sp),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: Text(
                                            ongoingItem.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.sp,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.h),
                                    Row(
                                      children: [
                                        Icon(Icons.date_range, size: 16.sp),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: Text(
                                            ongoingItem.startDate.toString(),
                                            style: TextStyle(fontSize: 12.sp),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.h),
                                    Row(
                                      children: [
                                        Icon(Icons.place, size: 16.sp),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: Text(
                                            ongoingItem.location,
                                            style: TextStyle(fontSize: 12.sp),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('لا توجد بيانات'));
                    }
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
