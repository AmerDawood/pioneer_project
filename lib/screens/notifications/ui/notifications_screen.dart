import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pioneer_project/dummy_data/Notifications.dart';
import 'package:pioneer_project/helpers/constants.dart';


import '../../../theming/colors.dart';
import '../../initiative/initiatives_screen.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.primary,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c){
                return InitiativesScreen();
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
                  Icon(Icons.arrow_back),
                  Text('الاشعارات',
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

            SizedBox(
              height: 700.h,
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context , index){
                  final item = notifications[index];
                  return  Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    maxRadius: 30,
                    child: SvgPicture.asset(Images.logo),
                  ),
                  title: Text('${item.title}'),
                  subtitle:Text('${item.subtitle}'),
                  trailing: Text('${item.volunteerHours}'),
                ),
                Divider(
                  indent: 10.w,
                  endIndent: 10.w,
                ),
              ],
            );

              }),
            ),


           
         
          ],
        ),
      ),
    );
  }
}
