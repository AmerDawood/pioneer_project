
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
  final String id;
  NewsDetailsScreen({super.key, required this.id});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  late Future<News> _future;

  @override
  void initState() {
    super.initState();
    _future = getNewsById(widget.id.toString());
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
          child: FutureBuilder<News>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              } else if (snapshot.hasData) {
                var news = snapshot.data!;
                return Column(
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
                            'عنوان الخبر',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Icon(
                            Icons.abc_outlined,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'العنوان / ',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      title: Text(news.title),
                    ),
                    ListTile(
                      leading: Text(
                        'المؤسسة / ',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      title: Text(news.organization.name),
                    ),
                    ListTile(
                      leading: Text(
                        'تاريخ الانتهاء / ',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      title: Text(news.newsDate),
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
                        news.details,
                        maxLines: 10,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 80,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No Data ${snapshot.error}',
                      style: TextStyle(fontSize: 30, color: Colors.grey),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
