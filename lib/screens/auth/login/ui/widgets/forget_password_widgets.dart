import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pioneer_project/screens/auth/forget-password/forget_password_screen.dart';

import '../../../../../theming/styles.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
                return ForgetPassword();
              }));
            },
            child: Text(
              'هل نسيت كلمة المرور ؟',
              style: TextStyles.font12BlueRegular,
            ),
          )
        ],
      ),
    );
  }
}
