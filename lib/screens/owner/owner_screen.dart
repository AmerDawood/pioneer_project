import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/perfs/user_preference_controller.dart';
import 'package:pioneer_project/screens/auth/initiative-login/login_screen.dart';
import 'package:pioneer_project/screens/news/ui/add_news_screen.dart';
import 'package:pioneer_project/screens/owner/participants.dart';
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
import '../initiative/users_joined.dart';
import '../news/ui/news_details_screen.dart';


class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
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
          leading: Icon(Icons.person),
          backgroundColor: ColorsManager.primary,
          title: Text(
            'لوحة تحكم المالك',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (c){
                      return InitiativeOwnerLoginScreen();
                    }));
                  },
                  child: Icon(Icons.logout,color: Colors.red,))
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<User?>(
                  future: UserPreferenceController().getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return Text('مرحبًا Your name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      );
                    } else {
                      return const Text('مرحبًا بالزائر');
                    }
                  },
                ),
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
                      return ParticipantsScreen(participants: dummyParticipants,);
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
                          Icon(Icons.man, color: Colors.white, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'المنتسبين للمبادرات',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  'الإحصائيات',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
                          builder: (context) => NewsDetailsScreen(id: newsItem.id.toString()), // Pass the news ID dynamically
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
                              '${ApiSettings.PROFILE}/${newsItem.image}', // Build the full URL for the image
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.broken_image),
                            )
                                : Image.asset(
                              'assets/news/default_news_image.png',
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
                              child: Image.asset(
                                ongoingItem.image.toString(), // تأكد من أن المسار صحيح
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
