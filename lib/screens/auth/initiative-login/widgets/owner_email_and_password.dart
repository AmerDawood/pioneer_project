import 'package:flutter/material.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/helpers/helpers.dart';
import 'package:pioneer_project/helpers/spacing.dart';
import 'package:pioneer_project/screens/auth/intiative-register/intiative_register_screen.dart';
import 'package:pioneer_project/screens/auth/login/ui/login_screen.dart';
import 'package:pioneer_project/screens/owner/owner_screen.dart';
import 'package:pioneer_project/api/controller/auth_api_controller.dart';
import 'package:pioneer_project/theming/colors.dart';

import '../../../../perfs/user_preference_controller.dart';
import '../../../home/app.dart'; // تأكد من استيراد ملف الألوان

class OwnerEmailAndPassword extends StatefulWidget {
  const OwnerEmailAndPassword({super.key});

  @override
  State<OwnerEmailAndPassword> createState() => _OwnerEmailAndPasswordState();
}

class _OwnerEmailAndPasswordState extends State<OwnerEmailAndPassword> with Helpers{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  // دالة لتسجيل الدخول
  Future<void> login() async {
    setState(() {
      isLoading = true; // عرض التحميل أثناء الاتصال
    });

    bool status = await AuthApiController().login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      isLoading = false; // إيقاف التحميل بعد الانتهاء
    });

    if (status) {
      // سحب الدور لتحديد إلى أي شاشة ننتقل
      String? role = await UserPreferenceController().getUserRole();

      if (role == 'normal_user') {
        showSnackBar(context: context, message: 'تسجيل الدخول من هنا للمستخدمين', error: true);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      } else if (role == 'initiative_owner') {
        showSnackBar(context: context, message: 'تم تسجيل الدخول بنجاح للمالك', error: false);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OwnerDashboardScreen()));
      } else {
        // دور غير معروف
        showSnackBar(context: context, message: 'دور المستخدم غير معروف', error: true);
        return;
      }

   } else
      showSnackBar(context: context, message: 'فشل تسجيل الدخول', error: true);
    }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'البريد الإلكتروني',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),
          verticalSpace(16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'كلمة المرور',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
          ),
          verticalSpace(24),
          ElevatedButton(
            onPressed: () {
              login(); // استدعاء دالة تسجيل الدخول عند الضغط على الزر
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primary,
              minimumSize: Size(double.infinity, 48),
            ),
            child: isLoading
                ? CircularProgressIndicator() // عرض دائرة التحميل أثناء الانتظار
                : Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              text: 'ليس لديك حساب؟ ',
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: [
                WidgetSpan(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterInitiativeOwnerScreen()),
                      );
                    },
                    child: Text(
                      'قم بإنشاء حساب الآن',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              text:'تسجيل الدخول كمستخدم عادي',
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: [
                WidgetSpan(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'اذهب الآن',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
