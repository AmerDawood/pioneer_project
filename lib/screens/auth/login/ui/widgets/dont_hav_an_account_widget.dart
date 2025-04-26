import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pioneer_project/screens/auth/register/register_screen.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'ليس لديك حساب؟ ',
        style: TextStyle(color: Colors.black, fontSize: 16), // Default text style
        children: [
          WidgetSpan(
            child: InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (c){
                  return RegisterScreen();
                }));
                // قم بتنفيذ الإجراء عند النقر هنا (مثل الانتقال إلى صفحة التسجيل)
                print('انتقل إلى صفحة التسجيل');
              },
              child: Text(
                'قم بإنشاء حساب الآن',
                style: TextStyle(
                  color: Colors.blue, // Change color for emphasis
                  fontWeight: FontWeight.bold, // Make it bold
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
