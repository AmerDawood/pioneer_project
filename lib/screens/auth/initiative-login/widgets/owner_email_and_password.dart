//
// import 'package:flutter/material.dart';
// import 'package:pioneer_project/api/controller/auth_api_controller.dart';
// import 'package:pioneer_project/helpers/helpers.dart';
// import 'package:pioneer_project/screens/home/app.dart';
// import 'package:pioneer_project/screens/owner/owner_screen.dart';
//
// import '../../../../../helpers/spacing.dart';
// import '../../../../../widgets/app_text_button.dart';
// import '../../../../../widgets/app_text_form_field.dart';
// import 'dont_hav_an_account_widget.dart';
// import 'forget_password_widgets.dart';
// import 'google_signin_widget.dart';
//
// class OwnerEmailAndPassword extends StatefulWidget {
//   const OwnerEmailAndPassword({super.key});
//
//   @override
//   State<OwnerEmailAndPassword> createState() => _EmailAndPasswordState();
// }
//
// class _EmailAndPasswordState extends State<OwnerEmailAndPassword> with Helpers {
//
//   late TextEditingController _emailEditingController;
//   late TextEditingController _passwordEditingController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _emailEditingController = TextEditingController();
//     _passwordEditingController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _emailEditingController.dispose();
//     _passwordEditingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//                 children: [
//                   verticalSpace(10),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       children: [
//                         AppTextFormField(
//                           controller: _emailEditingController,
//
//                           // controller: _loginValidation.emailController,
//                           hintText: 'الايميل',
//                           prefixIcon: Icon(
//                             Icons.email,
//                             color: Colors.grey,
//                           ),
//                           // validator: _loginValidation.validateEmail,
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       children: [
//                         AppTextFormField(
//                           controller: _passwordEditingController,
//                           hintText: 'كلمة المرور',
//                           suffixIcon: Icon(
//                             Icons.remove_red_eye,
//                             color: Colors.grey,
//                           ),
//                           prefixIcon: Icon(
//                             Icons.lock,
//                             color: Colors.grey,
//                           ),
//                           // validator: _loginValidation.validatePassword,
//                         )
//                       ],
//                     ),
//                   ),
//                  ForgetPasswordWidget(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: AppTextButton(
//                         buttonText: 'تسجيل الدخول',
//                         textStyle: TextStyle(
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (_){
//                             return OwnerDashboardScreen();
//                           }));
//                           // performLogin();
//                           // if (_loginValidation.validateInputs()) {
//
//                           // } else {
//                           //   setState(() {
//                           //     print(_loginValidation.emailController.text);
//                           //     print(_loginValidation.passwordController.text);
//                           //   });
//                           // }
//                           // debugPrint('login preesd now');
//                               // Navigator.push(
//                               //   context, MaterialPageRoute(builder: (_) => HomeScreen()));
//
//                         }),
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Divider(color: Colors.grey, thickness: 2),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 8), // Adds spacing around the text
//                           child: Text('الدخول بواسطة'),
//                         ),
//                         Expanded(
//                           child: Divider(color: Colors.grey, thickness: 2),
//                         ),
//                       ],
//                     ),
//                   ),
//                   GoogleSignInWidget(),
//
//                   verticalSpace(10),
//                   DontHaveAnAccountWidget(),
//                 ],
//               );
//   }
//
//
//   Future<void> performLogin() async {
//     if (checkData()) {
//       await login();
//     }
//   }
//
//   bool checkData() {
//     if (_emailEditingController.text.isNotEmpty &&
//         _passwordEditingController.text.isNotEmpty) {
//       return true;
//     }
//     return false;
//   }
//
//   Future<void> login() async {
//     bool status = await AuthApiController().login(
//         email: _emailEditingController.text,
//         password: _passwordEditingController.text);
//     if (status) {
//       Navigator.push(context, MaterialPageRoute(builder: (_){
//         return OwnerDashboardScreen();
//       }));
//       showSnackBar(context: context, message: 'Logged In Successfully', error: false);
//
//     } else {
//       showSnackBar(context: context, message: 'Login failed', error: true);
//     }
//   }
//
//
// }
import 'package:flutter/material.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/helpers/spacing.dart';
import 'package:pioneer_project/screens/auth/intiative-register/intiative_register_screen.dart';
import 'package:pioneer_project/screens/owner/owner_screen.dart';

import '../../../../api/controller/auth_api_controller.dart';
import '../../../../theming/colors.dart'; // Your controller that contains loginOwner

class OwnerEmailAndPassword extends StatefulWidget {
  const OwnerEmailAndPassword({super.key});

  @override
  State<OwnerEmailAndPassword> createState() => _OwnerEmailAndPasswordState();
}

class _OwnerEmailAndPasswordState extends State<OwnerEmailAndPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  void _login() async {
    setState(() {
      isLoading = true;
    });

    bool success = await AuthApiController().loginOwner(
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      // Navigate to the owner's dashboard or home
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('  تم تسجيل الدخول .')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
        return OwnerDashboardScreen();

      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل تسجيل الدخول. تأكد من البيانات.')),
      );
    }
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
            onPressed:(){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                return OwnerDashboardScreen();
              }));
            },
            // isLoading ? null : _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primary,
              minimumSize: Size(double.infinity, 48),
            ),
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
              'تسجيل الدخول',
              style: TextStyle(color: Colors.white),
            ),
          ),

      SizedBox(
        height: 20,
      ),

      RichText(
        text: TextSpan(
          text: 'ليس لديك حساب؟ ',
          style: TextStyle(color: Colors.black, fontSize: 16), // Default text style
          children: [
            WidgetSpan(
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (c){
                    return RegisterInitiativeOwnerScreen();
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
      ),
        ],
      ),
    );
  }
}
