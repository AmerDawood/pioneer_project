// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:pioneer_project/dummy_data/Notifications.dart';
// import 'package:pioneer_project/helpers/constants.dart';
//
//
// import '../../../theming/colors.dart';
// import '../../initiative/initiatives_screen.dart';
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorsManager.primary,
//         leading: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: InkWell(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(builder: (c){
//                 return InitiativesScreen();
//               }));
//             },
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               // minRadius: 10,
//               child: SvgPicture.asset(Images.logo,height: 20,),
//             ),
//           ),
//         ),
//         title: SvgPicture.asset(
//           Images.logo,
//           color: Colors.white,
//           height: 35,
//           width: 40,
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: EdgeInsets.all(10),
//             child:
//             Icon(
//               Icons.menu,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//         ],
//       ),
//
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(Icons.arrow_back),
//                   Text('الاشعارات',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                     ),
//                   ),
//                   Icon(
//                     Icons.abc_outlined,
//                     color: Colors.transparent,
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(
//               height: 700.h,
//               child: ListView.builder(
//                 itemCount: notifications.length,
//                 itemBuilder: (context , index){
//                   final item = notifications[index];
//                   return  Column(
//               children: [
//                 ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.transparent,
//                     maxRadius: 30,
//                     child: SvgPicture.asset(Images.logo),
//                   ),
//                   title: Text('${item.title}'),
//                   subtitle:Text('${item.subtitle}'),
//                   trailing: Text('${item.volunteerHours}'),
//                 ),
//                 Divider(
//                   indent: 10.w,
//                   endIndent: 10.w,
//                 ),
//               ],
//             );
//
//               }),
//             ),
//
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pioneer_project/api/controller/notification_api_controller.dart';
import 'package:pioneer_project/models/Notifications.dart';
import '../../../helpers/constants.dart';
import '../../../theming/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = NotificationApiController().fetchNotifications();
  }

  void _refreshNotifications() {
    setState(() {
      _notificationsFuture = NotificationApiController().fetchNotifications();
    });
  }

  void _showOptions(NotificationModel notification) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.mark_email_read),
              title: Text('وضع كمقروء'),
              onTap: () async {
                Navigator.pop(context);
                await NotificationApiController().markNotificationAsRead(notification.id);
                _refreshNotifications();
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('حذف الإشعار'),
              onTap: () async {
                Navigator.pop(context);
                await NotificationApiController().deleteNotification(notification.id);
                _refreshNotifications();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.primary,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset(Images.logo, height: 20),
          ),
        ),
        title: SvgPicture.asset(Images.logo, color: Colors.white, height: 35),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.menu, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          children: [
            // العنوان
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back),
                Text(
                  'الاشعارات',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Opacity(opacity: 0, child: Icon(Icons.abc)), // للحفاظ على التوازن
              ],
            ),
            SizedBox(height: 16),


            Container(
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.warning),
                title: Text('اضغط ضغطة طويلة لإظهار المزيد من الخيارات'),
              ),
            ),

            // الإشعارات
            Expanded(
              child: FutureBuilder<List<NotificationModel>>(
                future: _notificationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());

                  if (snapshot.hasError)
                    return Center(child: Text('حدث خطأ أثناء جلب البيانات'));

                  final notifications = snapshot.data ?? [];

                  if (notifications.isEmpty)
                    return Center(child: Text('لا يوجد إشعارات حالياً'));

                  return ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final item = notifications[index];
                      return InkWell(
                        onLongPress: () => _showOptions(item),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: SvgPicture.asset(Images.logo),
                              ),
                              title: Text(item.title),
                              subtitle: Text(item.message),
                              trailing: item.isRead ? Icon(Icons.check,color: Colors.green,) : Icon(Icons.cancel,color: Colors.red,),
                            ),
                            Divider(indent: 10.w, endIndent: 10.w),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
