import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/helpers/helpers.dart';
import 'package:pioneer_project/helpers/spacing.dart';
import 'package:pioneer_project/perfs/user_preference_controller.dart';
import 'package:pioneer_project/screens/auth/login/ui/login_screen.dart';
import 'package:pioneer_project/screens/auth/register/register_screen.dart';
import 'package:pioneer_project/screens/settings/ui/about_app_screen.dart';
import 'package:pioneer_project/screens/settings/ui/contact_us_screen.dart';
import 'package:pioneer_project/screens/settings/ui/widgets/setting_listtile_widget.dart';
import 'package:pioneer_project/theming/colors.dart';
import 'package:share_plus/share_plus.dart';

import '../../auth/initiative-login/login_screen.dart';
import '../../profile/ui/profile_screen.dart';
class SettingsScreen extends StatefulWidget with Helpers {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with Helpers {
  bool isAppEnabled = true;
  bool isNotificationEnabled = false;
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
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back,color: Colors.transparent,),
                    Text('الإعدادات',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.face),
                    title: Text('مرحباً بك مرة أخرى'),
                    subtitle: Text('تم تسجيل الدخول بنجاح'),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         flex: 1,
              //         child: InkWell(
              //           onTap: (){
              //             Navigator.push(context, MaterialPageRoute(builder: (c){
              //               return RegisterScreen();
              //             }));
              //           },
              //           child: Container(
              //             height: 55.h,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               border: Border.all(color: ColorsManager.primary)
              //             ),
              //             child: Center(child: Text('انشاء حساب')),
              //           ),
              //         ),
              //       ),
              //       horizontalSpace(10),
              //
              //       Expanded(
              //         flex: 1,
              //         child: InkWell(
              //             onTap: (){
              //             Navigator.push(context, MaterialPageRoute(builder: (c){
              //               return LoginScreen();
              //             }));
              //           },
              //           child: Container(
              //             height: 55.h,
              //             decoration: BoxDecoration(
              //               color: ColorsManager.secondary,
              //                 borderRadius: BorderRadius.circular(10),
              //                 border: Border.all(color: ColorsManager.primary)
              //             ),
              //             child: Center(child: Text('تسجيل دخول',
              //             style: TextStyle(
              //               color: Colors.white,
              //             ),
              //             )),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              SettingListTileWidget(
                title: Text('الملف الشخصي'),
                leadingIcon: Icon(Icons.person),
                function: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                            return ProfileScreen();
                          }));
                },
              ),



              // SettingListTileWidget(
              //   title: Text('المدونة'),
              //   leadingIcon: Icon(Icons.article_outlined),
              //   function: (){},
              // ),
              SettingListTileWidget(
                title: Text('عن التطبيق'),
                leadingIcon: Icon(Icons.account_balance_outlined),
                function: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                            return AboutAppScreen();
                          }));
                },
              ),

              SettingListTileWidget(
                title: Text('مشاركة'),
                leadingIcon: Icon(Icons.share),
                function: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => ShareBottomSheet(),
                  );
                },
              ),

              SettingListTileWidget(
                title: Text('تواصل معنا'),
                leadingIcon: Icon(Icons.phone),
                function: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                            return ContactusScreen();
                          }));
                },
              ),

              SettingListTileWidget(
                title: Text('تسجيل كصاحب مبادرات'),
                leadingIcon: Icon(Icons.lock),
                function: (){
                  UserPreferenceController().clear();
                  showSnackBar(context: context, message: 'الانتقال لتسجيل الدخول كصاحب مبادرة');
                  print('user deleted successfuly');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
                            return InitiativeOwnerLoginScreen();
                          }));
                },
              ),

              SettingListTileWidget(
                title: Text('تقييم التطبيق'),
                leadingIcon: Icon(Icons.star),
                function: (){},
              ),

              ListTile(
                title: Text('حاله التطبيق'),
                leading: Icon(Icons.format_color_fill_rounded),
                trailing: Switch(
                  value: isAppEnabled,
                  onChanged: (value) {
                    setState(() {
                      isAppEnabled = value;
                    });
                  },
                  activeColor: ColorsManager.primary,
                ),
              ),
              ListTile(
                leading: Icon(Icons.notification_add_outlined),
                title: Text('تفعيل الاشعارات'),
                trailing: Switch(
                  value: isNotificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      isNotificationEnabled = value;

                      showSnackBar(context: context, message: 'Success');
                    });
                  },
                  activeColor: ColorsManager.primary,
                ),
              ),


              SettingListTileWidget(
                title: Text('حذف الحساب'),
                leadingIcon: Icon(Icons.delete_forever),
                function: (){
                  UserPreferenceController().clear();
                  print('user deleted successfuly');
                  showSnackBar(context: context,error: false, message: 'Account deleted successfuly');
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                            return LoginScreen();
                          }));
                },
              ),

              SettingListTileWidget(
                title: Text('تسجيل الخروج'),
                leadingIcon: Icon(Icons.login_outlined),
                function: (){
                  UserPreferenceController().clear();
                  print('user deleted successfuly');
                     showSnackBar(error: false, context: context, message: 'تم تسجيل الخروج بنجاح للمستخدم');
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                            return LoginScreen();
                          }));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class ShareBottomSheet extends StatelessWidget {
  const ShareBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مشاركة التطبيق',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('مشاركة الرابط'),
            onTap: () {
              Share.share('حمّل تطبيق PIONEERS الآن: https://play.google.com/store/apps/details?id=your.app.id');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}