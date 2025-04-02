
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/helpers/bn_screen.dart';
import '../../theming/colors.dart';
import '../chat/select_chat_screen.dart';
import '../initiative/initiatives_screen.dart';
import '../notifications/ui/notifications_screen.dart';
import '../settings/ui/settings_screen.dart';
import 'home_screen.dart';


class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AppScreen> with TickerProviderStateMixin {
  late int _currentIndex = 0;
  final List<BnScreen> _bnScreen = <BnScreen>[
    BnScreen(widget: HomeScreen(), title: 'الرئيسية'),
    BnScreen(widget: InitiativesScreen(), title: 'المبادرات'),
    BnScreen(widget: SelectChatScreen(), title: 'المحادثات'),
    BnScreen(widget: NotificationScreen(), title: 'الاشعارات'),
    BnScreen(widget: SettingsScreen(), title: 'الإعدادات'),
  ];

  @override
  Widget build(BuildContext context) {
    return
      Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorsManager.primary,
            selectedIconTheme: const IconThemeData(color: ColorsManager.secondary),
            unselectedItemColor:  ColorsManager.grey,
            unselectedIconTheme:  IconThemeData(color: ColorsManager.grey),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            elevation: 15,
            selectedLabelStyle: GoogleFonts.nunito(fontSize: 16.sp),
            unselectedLabelStyle: GoogleFonts.nunito(fontSize: 15.sp),
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: (int value) {
              setState(() {
                _currentIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                label: 'الرئيسية',
               icon: Icon(Icons.home_outlined),
                activeIcon:  Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'المبادرات',
                icon: Icon(Icons.favorite_outline),
                activeIcon:  Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                label: 'المحادثات',
                icon: Icon(Icons.chat),
                activeIcon:  Icon(Icons.chat_rounded),
              ),
              BottomNavigationBarItem(
                label: 'الاشعارات',
                icon: Icon(Icons.notification_add_outlined),
                activeIcon:  Icon(Icons.notification_add),
              ),
              BottomNavigationBarItem(
                label: 'الإعدادات',
                icon: Icon(Icons.settings_outlined),
                activeIcon:  Icon(Icons.settings),
              ),
            ],
          ),

          body: _bnScreen[_currentIndex].widget,
        ),
      );
  }
}