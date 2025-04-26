//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pioneer_project/dummy_data/news.dart';
// import 'package:pioneer_project/helpers/constants.dart';
//
// import '../../../helpers/spacing.dart';
// import '../../../theming/colors.dart';
// import '../../profile/ui/profile_screen.dart';
// import 'news_details_screen.dart';
//
// class NewsScreen extends StatelessWidget {
//   const NewsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: ColorsManager.primary,
//           // leading: Icon(
//           //   Icons.person_2_outlined,
//           //   color: Colors.white,
//           //   size: 30,
//           // ),
//           leading: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: InkWell(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (c){
//                   return ProfileScreen();
//                 }));
//               },
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 // minRadius: 10,
//                 child: SvgPicture.asset(Images.logo,height: 20,),
//               ),
//             ),
//           ),
//           title: SvgPicture.asset(
//             Images.logo,
//             color: Colors.white,
//             height: 35,
//             width: 40,
//           ),
//           centerTitle: true,
//           actions: [
//             Padding(
//               padding: EdgeInsets.all(10),
//               child:
//               Icon(
//                 Icons.menu,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//           ],
//         ),
//
//
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Image.asset('assets/news/IMG_8661.jpg',
//               //   height: 200.h,
//               //   width: double.infinity,
//               //   fit: BoxFit.cover,
//               // ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(onPressed: (){
//                       Navigator.pop(context);
//                     }, icon: Icon(Icons.arrow_back)),
//                     Text('اخر الأخبار',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                       ),
//                     ),
//                     Icon(
//                       Icons.abc_outlined,
//                       color: Colors.transparent,
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(
//                 height: 700.h,
//                 child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemCount: news.length,
//                     itemBuilder: (c,index){
//                       final item = news[index];
//                       return InkWell(
//                         onTap: (){
//                           print('tt');
//                           Navigator.push(context,MaterialPageRoute(builder: (c){
//                             return NewsDetailsScreen();
//                           }));
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: 280,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 150,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade400,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Image.asset('${item.image}',fit: BoxFit.cover,width: double.infinity,),
//                                 ),
//                                 Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(18.0),
//                                       child: Row(
//                                         children: [
//                                           Text(item.title),
//                                           Spacer(),
//                                           Text(item.organization?.name ?? ''),
//                                         ],
//                                       ),
//                                     ),
//
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 20,left: 10),
//                                       child: Align(
//                                           alignment: AlignmentDirectional.topStart,
//                                           child: Text(item.details,maxLines: 1,overflow: TextOverflow.ellipsis,)),
//                                     ),
//
//                                     Padding(
//                                       padding: const EdgeInsets.all(12.0),
//                                       child: Row(
//                                         children: [
//                                           Spacer(),
//                                           Icon(Icons.date_range),
//                                           horizontalSpace(5),
//                                           Text(item.newsDate,
//                                           overflow: TextOverflow.ellipsis,),
//                                         ],
//                                       ),
//                                     ),
//
//
//
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               )
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/api/controller/news_api_controller.dart';  // Ensure correct import
import 'package:pioneer_project/screens/home/app.dart';
import 'package:pioneer_project/screens/home/home_screen.dart';

import '../../../helpers/spacing.dart';
import '../../../models/news.dart';
import '../../../theming/colors.dart';
import '../../profile/ui/profile_screen.dart';
import 'news_details_screen.dart';
import 'package:pioneer_project/dummy_data/news.dart';  // Make sure to import the updated News model

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<News>> newsFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the news fetching
    newsFuture = getAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          leading: IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
              return AppScreen();
            }));
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
          title: SvgPicture.asset(
            Images.logo,
            color: Colors.white,
            height: 35,
            width: 40,
          ),
          centerTitle: true,
          actions: [
            // Padding(
            //   padding: EdgeInsets.all(10),
            //   child: Icon(
            //     Icons.menu,
            //     color: Colors.white,
            //     size: 30,
            //   ),
            // ),
          ],
        ),
        body: FutureBuilder<List<News>>(
          future: newsFuture, // Fetch the news data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error,color: Colors.red,size: 30,),
                  SizedBox(height: 10,),
                  Center(child: Text('حدث خطأ ما',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  ))
                ],
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No news available.'));
            }

            var newsList = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: () {
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back)),
                        Text('اخر الأخبار',
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
                      itemCount: newsList.length,
                      itemBuilder: (c, index) {
                        final item = newsList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return NewsDetailsScreen(
                              newsId: item.id,
                              title: item.title,
                              date: item.newsDate,
                              details: item.details,
                                // logo: item.image!,
                              );  // Implement details screen for the news
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 280,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: (item.image != null && item.image!.isNotEmpty)
                                        ? Image.network(
                                      'https://pioneer-project-2025.shop/storage/app/public/${item.image}', // Build the full URL for the image
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
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Row(
                                          children: [
                                            Text(item.title),
                                            Spacer(),
                                            Text(item.organization.name),  // Display organization name
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20, left: 10),
                                        child: Align(
                                          alignment: AlignmentDirectional.topStart,
                                          child: Text(
                                            item.details,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Icon(Icons.date_range),
                                            horizontalSpace(5),
                                            Text(item.newsDate, overflow: TextOverflow.ellipsis),
                                          ],
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
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
