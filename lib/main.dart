import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pioneer_project/routing/app_router.dart';
import 'package:pioneer_project/routing/routes.dart';
import 'package:pioneer_project/theming/colors.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter()));
}

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
        initialRoute: Routes.appScreen,
        // initialRoute: Routes.categoriesScreen,
        // initialRoute: Routes.categoryDetailsScreen,
        // initialRoute: Routes.profileScreen,
        // initialRoute: Routes.termsScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
