
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/api/controller/news_api_controller.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/models/news.dart';

import '../../../theming/colors.dart';
import '../../home/app.dart';
import '../../profile/ui/profile_screen.dart';

class NewsDetailsScreen extends StatefulWidget {
  final int newsId;
  final String title;
  final String details;
  // final String logo;
  final String date;
  NewsDetailsScreen({super.key, required this.newsId,required this.details, required this.title,required this.date,});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (c) {
                    return ProfileScreen();
                  }),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(Images.logo, height: 20),
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
              child: Icon(
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
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (c) {
                            return AppScreen();
                          }),
                        );
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    Text(
                      '${widget.title}',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Icon(
                      Icons.abc_outlined,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),


              Icon(Icons.broken_image,size: 100,),


              // widget.logo.isNotEmpty
              //     ?
              // Icon(
              //   Icons.image_not_supported,
              //   size: 100,
              //   color: Colors.grey,
              // )
              // // Image.network(
              // //   'https://pioneer-project-2025.shop/storage/app/public/${widget.logo}',
              // //   height: 200,
              // //   width: double.infinity,
              // //   fit: BoxFit.cover,
              // //   errorBuilder: (context, error, stackTrace) => Icon(
              // //     Icons.broken_image,
              // //     size: 100,
              // //   ),
              // // )
              //     : Icon(
              //   Icons.image_not_supported,
              //   size: 100,
              //   color: Colors.grey,
              // ),

              ListTile(
                leading: Text(
                  'العنوان / ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                title: Text('${widget.title}'),
              ),
              ListTile(
                leading: Text(
                  'المؤسسة / ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                title: Text('Organization'),
              ),
              ListTile(
                leading: Text(
                  'تاريخ الانتهاء / ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                title: Text('${widget.date}'),
              ),
              ListTile(
                leading: Text(
                  'عدد المتطوعين / ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                title: Text('١٠٠'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'الوصف',
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
                child: Text(
                  '${widget.details}',
                  maxLines: 10,
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
