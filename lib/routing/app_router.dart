
import 'package:flutter/material.dart';
import 'package:pioneer_project/routing/routes.dart';
import 'package:pioneer_project/screens/auth/forget-password/forget_password_screen.dart';
import 'package:pioneer_project/screens/auth/forget-password/reset_password_screen.dart';
import 'package:pioneer_project/screens/auth/forget-password/success_reset_password.dart';
import 'package:pioneer_project/screens/auth/forget-password/verificastion_code_screen.dart';
import 'package:pioneer_project/screens/auth/login/ui/login_screen.dart';
import 'package:pioneer_project/screens/auth/register/register_screen.dart';
import 'package:pioneer_project/screens/categories/category_details.dart';
import 'package:pioneer_project/screens/categories/category_screen.dart';
import 'package:pioneer_project/screens/home/app.dart';
import 'package:pioneer_project/screens/home/home_screen.dart';
import 'package:pioneer_project/screens/news/ui/news_details_screen.dart';
import 'package:pioneer_project/screens/news/ui/news_screen.dart';
import 'package:pioneer_project/screens/onboarding/onboarding_screen.dart';
import 'package:pioneer_project/screens/organizations/all_organizations_screen.dart';
import 'package:pioneer_project/screens/profile/ui/profile_screen.dart';
import 'package:pioneer_project/screens/settings/ui/about_app_screen.dart';
import 'package:pioneer_project/screens/settings/ui/about_us_screen.dart';
import 'package:pioneer_project/screens/settings/ui/contact_us_screen.dart';
import 'package:pioneer_project/screens/settings/ui/most_questions_screen.dart';
import 'package:pioneer_project/screens/settings/ui/privacy_screen.dart';
import 'package:pioneer_project/screens/settings/ui/settings_screen.dart';
import 'package:pioneer_project/screens/settings/ui/terms_screen.dart';
import 'package:pioneer_project/screens/splash/splash_screen.dart';

import '../screens/owner/owner_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
        case Routes.appScreen:
        return MaterialPageRoute(
          builder: (_) => const AppScreen(),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

           case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgetPassword(),
        );

      case Routes.verifyCode:
        return MaterialPageRoute(
          builder: (_) => const VerificastionPassword(),
        );

      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );

      case Routes.successResetPassword:
        return MaterialPageRoute(
          builder: (_) => const SuccessResetPsswordScreen(),
        );

      case Routes.categoriesScreen:
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
        );

      case Routes.categoryDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const CategoryDetailsScreen(),
        );

      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      case Routes.newsDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const NewsDetailsScreen(),
        );
      case Routes.newsScreen:
        return MaterialPageRoute(
          builder: (_) => const NewsScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
        case Routes.aboutAppScreen:
        return MaterialPageRoute(
          builder: (_) => const AboutAppScreen(),
        );

      case Routes.aboutUsScreen:
        return MaterialPageRoute(
          builder: (_) => const AboutUsScreen(),
        );

      case Routes.mostQuestionsScreen:
        return MaterialPageRoute(
          builder: (_) => const MostQuestionsScreen(),
        );
        case Routes.contactUsScreen:
        return MaterialPageRoute(
          builder: (_) => const ContactusScreen(),
        );
        case Routes.privacyScreen:
        return MaterialPageRoute(
          builder: (_) => const PrivacyScreen(),
        );
        case Routes.termsScreen:
        return MaterialPageRoute(
          builder: (_) => const TermsScreen(),
        );
        case Routes.settingsScreen:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
        case Routes.chatScreen:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
        case Routes.allOrganizationsScreen:
            return MaterialPageRoute(
              builder: (_) => const AllOrganizationsScreen(),
            );

      case Routes.ownerScreen:
        return MaterialPageRoute(
          builder: (_) => const OwnerDashboardScreen(),
        );



      // case Routes.loginScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<LoginCubit>(),
      //       child: const LoginScreen(),
      //     ),
      //   );

      default:
        return null;
    }
  }
}
