import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pioneer_project/api/controller/news_api_controller.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/helpers/helpers.dart';
import 'package:pioneer_project/perfs/user_preference_controller.dart';
import 'package:pioneer_project/screens/auth/initiative-login/login_screen.dart';
import 'package:pioneer_project/screens/news/ui/add_news_screen.dart';
import 'package:pioneer_project/screens/notifications/ui/notifications_screen.dart';
import 'package:pioneer_project/screens/owner/participants.dart';
import 'package:pioneer_project/screens/owner/participants/participants_screen.dart';
import 'package:pioneer_project/screens/owner/requests/all_requests_screen.dart';
import '../../../theming/colors.dart';
import '../../api/api_settings.dart';
import '../../api/controller/home_api_controller.dart';
import '../../api/controller/initiatives_api_controller.dart';
import '../../dummy_data/initiatives.dart';
import '../../dummy_data/news.dart';
import '../../models/Initiative.dart';
import '../../models/news.dart';
import '../../models/user.dart';
import '../initiative/add_intiative_screen.dart';
import '../initiative/update_screen.dart';
import '../initiative/users_joined.dart';
import '../news/ui/news_details_screen.dart';
import '../news/ui/update_news.dart';
import 'add_notification_screen/add_notification.dart';


class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> with Helpers {
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
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
                onTap: (){
                  showSnackBar(context: context, message:'تم تسجيل الخروج بنجاح للمالك');
                  UserPreferenceController().clear();
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (c){
                    return InitiativeOwnerLoginScreen();
                  }));
                },
                child: Icon(Icons.logout,color: Colors.red,))
        ),
        backgroundColor: ColorsManager.primary,
        title: Text(
          'لوحة تحكم المالك',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.person,color: Colors.white,),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // FutureBuilder<String?>(
              //   future: UserPreferenceController().getToken(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return CircularProgressIndicator(); // أو أي لودينج
              //     } else if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     } else if (snapshot.hasData) {
              //       return Text('Token: ${snapshot.data}');
              //     } else {
              //       return Text('No token found');
              //     }
              //   },
              // ),

              FutureBuilder<User?>(
                future: UserPreferenceController().getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('${snapshot.data!.name}'),
                        subtitle: Text('${snapshot.data!.email}'),
                        trailing: Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.greenAccent,
                          ),
                          child: Center(child: Text('${snapshot.data!.role}',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          )),
                        ),
                      ),
                    );
                  } else {
                    return const Text('مرحبًا بالزائر');
                  }
                },
              ),

              SizedBox(height: 10,),


              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDashboardCard('إضافة خبر', Icons.post_add, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewsScreen()));
                  }),
                  _buildDashboardCard('إضافة مبادرة', Icons.lightbulb, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddInitiativeScreen()));
                  }),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (c){
                    return ContactMessagesScreen();
                  }));
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorsManager.primary,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mark_email_unread, color: Colors.white, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'الطلبات',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (c){
                    return AddNotificationScreen();
                  }));
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorsManager.primary,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notification_add, color: Colors.white, size: 40),
                        SizedBox(height: 8),
                        Text(
                          ' إضافة الإشعارات',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
               SizedBox(height: 10,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Center(
                     child: Text(
                       'الإحصائيات',
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                     ),
                   ),
                 ],
               ),
              SizedBox(height: 10,),
              _buildStatisticsCard(),
              SizedBox(height: 20),
              Text(
                'آخر الأخبار',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildLatestItems(context),
              SizedBox(height: 20),
              Text(
                'آخر المبادرات',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildLatestInteative(context),

              // buildInitiativesSlider(context, completedInitiatives),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: ColorsManager.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    return Container(
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('الأخبار', '12'),
          _buildStatItem('المبادرات', '8'),
          _buildStatItem('المستخدمين', '25'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildLatestItems(BuildContext context) {
    return  SizedBox(
      height: 270.h,
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
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => NewsDetailsScreen(
                      //       newsId: newsItem.id,
                      //       title: newsItem.title,
                      //       date: newsItem.newsDate,
                      //       details: newsItem.details,
                      //     ), // Pass the news ID dynamically
                      //   ),
                      // );
                    },
                    child: Container(
                      height: 240.h,
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
                            child:(newsItem.image != null && newsItem.image!.isNotEmpty)
                                ? Image.network(
                              'https://pioneer-project-2025.shop/storage/app/public/${newsItem.image}', // Build the full URL for the image
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.broken_image),
                            )
                                : Image.asset(
                              'assets/news/IMG_8661.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              InkWell(
                                onTap: () async {
                                  bool success = await deleteNews(newsItem.id.toString());


                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        success ? 'تم حذف الخبر بنجاح' : 'فشل في حذف الخبر',
                                      ),
                                      backgroundColor: success ? Colors.green : Colors.red,
                                    ),
                                  );
                                },
                                child: Icon(Icons.delete, color: Colors.red),
                              ),


                              SizedBox(width: 20,),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                                      return UpdateNewsScreen(newsId: newsItem.id,initialDetails: newsItem.details,initialTitle: newsItem.title,);
                                    }));
                                  },
                                  child: Icon(Icons.edit,color: Colors.blue,)),
                            ],
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
    );
  }


  Widget _buildLatestInteative(BuildContext context) {
    return SizedBox(
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
                  child: InkWell(
                    onTap: () async {
                      try {
                        final participants = await InitiativesApiController().getInitiativeParticipant(ongoingItem.id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ParticipantsScreen(participants: []),
                          ),
                        );

                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('فشل في تحميل المشاركين: $e')),
                        );
                      }
                    },
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
                              child: Image.asset('assets/organizations/IMG_8672.PNG',height: 60,)
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
                            SizedBox(height: 5.h,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                InkWell(
                                  onTap: () async {
                                    bool success = await InitiativesApiController().deleteInitiative(ongoingItem.id.toString());
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          success ? 'تم حذف  بنجاح' : 'فشل في حذف ',
                                        ),
                                        backgroundColor: success ? Colors.green : Colors.red,
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.delete, color: Colors.red),
                                ),


                                SizedBox(width: 20,),
                                InkWell(
                                    onTap: (){
                                      final dateFormat = DateFormat('yyyy-MM-dd');

                                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                                        return UpdateInitiativeScreen(
                                          initiativeId: ongoingItem.id,        // رقم المبادرة
                                          name: ongoingItem.name,              // اسم المبادرة
                                          location: ongoingItem.location,      // الموقع
                                          startDate: dateFormat.format(ongoingItem.startDate), // ✅ تحويل DateTime إلى String
                                          endDate: dateFormat.format(ongoingItem.endDate),      // تاريخ الانتهاء (بصيغة yyyy-MM-dd)
                                          maxParticipants: ongoingItem.maxParticipants, // الحد الأقصى
                                          details: ongoingItem.details,        // التفاصيل
                                          hours: ongoingItem.hours,            // عدد الساعات
                                        );
                                      }));

                                    },
                                    child: Icon(Icons.edit,color: Colors.blue,)),
                                SizedBox(width: 20,),

                                InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                                        return InitiativeParticipantsScreen(initiativeId: ongoingItem.id.toString(),);
                                      }));
                                    },
                                    child: Icon(Icons.remove_red_eye,color: Colors.green,)),
                              ],
                            ),
                          ],
                        ),
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
    );
  }
}
