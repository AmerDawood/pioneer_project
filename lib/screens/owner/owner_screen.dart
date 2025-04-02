import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/screens/news/ui/add_news_screen.dart';
import '../../../theming/colors.dart';
import '../../dummy_data/initiatives.dart';
import '../initiative/add_intiative_screen.dart';
import '../initiative/users_joined.dart';


class OwnerDashboardScreen extends StatelessWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          title: Text(
            'لوحة تحكم المالك',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                Images.logo,
                height: 35,
                width: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDashboardCard('إضافة خبر', Icons.post_add, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewsScreen()));
                  }),
                  _buildDashboardCard('إضافة مبادرة', Icons.lightbulb, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddInitiativeScreen()));
                  }),
                ],
              ),
              SizedBox(height: 20),
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
              _buildLatestItems(),
              SizedBox(height: 20),
              Text(
                'آخر المبادرات',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildLatestItems(),
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

  Widget _buildLatestItems() {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: completedInitiatives.length,
        itemBuilder: (context, index) {
          final item = completedInitiatives[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (c){
                  return InitiativeUsersScreen();
                }));
              },
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(
color: Colors.black,
                  ),
                  // color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 60,
                        child: Image.asset('assets/initiative/IMG_8667.PNG')),
                    Text('${item.title}')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
