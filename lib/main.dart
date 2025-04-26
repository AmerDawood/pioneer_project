import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pioneer_project/perfs/user_preference_controller.dart';
import 'package:pioneer_project/routing/app_router.dart';
import 'package:pioneer_project/routing/routes.dart';
import 'package:pioneer_project/theming/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferenceController().getToken();
  await UserPreferenceController().getUser();

  WidgetsFlutterBinding.ensureInitialized();
  // final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(appRouter: AppRouter()));
}


 /**
  *
  *    participants  for user
  *     Images
  *     show organizations , details 
  *     Profile Update and show user data in profile
  *     register for organizations
  * ============
  *
  */

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  // Constructor for MyApp that requires an AppRouter instance
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Graduation App',
        theme: ThemeData(
          primaryColor: ColorsManager.primary,
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        // initialRoute: Routes.loginScreen,
        // initialRoute: Routes.appScreen,
        initialRoute: Routes.splashScreen,
        // initialRoute: Routes.categoriesScreen,
        // initialRoute: Routes.categoryDetailsScreen,
        // initialRoute: Routes.profileScreen,
        // initialRoute: Routes.termsScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
