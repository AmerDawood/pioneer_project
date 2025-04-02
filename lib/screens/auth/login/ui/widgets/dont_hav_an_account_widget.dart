import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'ليس لديك حساب؟ ',
        style:
            TextStyle(color: Colors.black, fontSize: 16), // Default text style
        children: [
          TextSpan(
            text: 'قم بإنشاء حساب الآن',
            style: TextStyle(
              color: Colors.blue, // Change color for emphasis
              fontWeight: FontWeight.bold, // Make it bold
            ),
          ),
        ],
      ),
    );
  }
}
