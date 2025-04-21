//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:pioneer_project/api/controller/auth_api_controller.dart';
// import 'package:pioneer_project/helpers/constants.dart';
// import 'package:pioneer_project/helpers/helpers.dart';
// import 'package:pioneer_project/screens/auth/login/ui/login_screen.dart';
//
// import '../../../helpers/spacing.dart';
// import '../../../theming/colors.dart';
// import '../../../widgets/app_text_button.dart';
// import '../../../widgets/app_text_form_field.dart';
// import '../login/ui/widgets/google_signin_widget.dart';
//
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen>with Helpers {
//
//   late TextEditingController _nameEditingController;
//   late TextEditingController _phoneEditingController;
//   late TextEditingController _emailEditingController;
//   late TextEditingController _passwordEditingController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _phoneEditingController = TextEditingController();
//     _nameEditingController = TextEditingController();
//     _emailEditingController = TextEditingController();
//     _passwordEditingController = TextEditingController();
//
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _phoneEditingController.dispose();
//     _passwordEditingController.dispose();
//     _nameEditingController.dispose();
//     _emailEditingController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 color: ColorsManager.primary,
//                 child: Center(
//                   child: SvgPicture.asset(
//                     Images.logo,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               height: 600.h,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(10),
//                   topLeft: Radius.circular(10),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           AppTextFormField(
//                             controller: _nameEditingController,
//                             hintText: 'الاسم كامل',
//                             // suffixIcon: Icon(Icons.email),
//                             prefixIcon: Icon(
//                               Icons.email,
//                               color: Colors.grey,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           AppTextFormField(
//                             controller: _emailEditingController,
//                             hintText: 'الايميل',
//                             // suffixIcon: Icon(Icons.email),
//                             prefixIcon: Icon(
//                               Icons.email,
//                               color: Colors.grey,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                      Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           AppTextFormField(
//                             controller: _phoneEditingController,
//                             hintText: 'رقم الهاتف',
//                             // suffixIcon: Icon(Icons.email),
//                             prefixIcon: Icon(
//                               Icons.email,
//                               color: Colors.grey,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           AppTextFormField(
//                             controller: _passwordEditingController,
//                             hintText: 'كلمة المرور',
//                             suffixIcon: Icon(
//                               Icons.remove_red_eye,
//                               color: Colors.grey,
//                             ),
//                             prefixIcon: Icon(
//                               Icons.lock,
//                               color: Colors.grey,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     // Padding(
//                     //   padding: const EdgeInsets.only(left: 10, bottom: 7),
//                     //   child: Row(
//                     //     mainAxisAlignment: MainAxisAlignment.end,
//                     //     children: [Text('pla pla pla pla ')],
//                     //   ),
//                     // ),
//                     // Padding(
//                     //   padding: const EdgeInsets.all(8.0),
//                     //   child: Row(
//                     //     children: [
//                     //       Expanded(
//                     //         child: Divider(color: Colors.grey, thickness: 2),
//                     //       ),
//                     //       Padding(
//                     //         padding: EdgeInsets.symmetric(
//                     //             horizontal: 8), // Adds spacing around the text
//                     //         child: Text('الدخول بواسطة'),
//                     //       ),
//                     //       Expanded(
//                     //         child: Divider(color: Colors.grey, thickness: 2),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     // GoogleSignInWidget(),
//                     verticalSpace(10),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: AppTextButton(
//                           buttonText: 'تسجيل',
//                           textStyle: TextStyle(
//                             color: Colors.white,
//                           ),
//                           onPressed: () => performRegister()
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> performRegister() async {
//     if (checkData()) {
//       await register();
//     }
//   }
//
//   bool checkData() {
//     if (_emailEditingController.text.isNotEmpty &&
//         _passwordEditingController.text.isNotEmpty&&_phoneEditingController.text.isNotEmpty&&_nameEditingController.text.isNotEmpty) {
//       return true;
//     }
//     return false;
//   }
//
//   Future<void> register() async {
//     bool status = await AuthApiController().register(
//       name: _nameEditingController.text,
//         email: _emailEditingController.text,
//         phone: _phoneEditingController.text,
//         password: _passwordEditingController.text,
//         context: context,
//         );
//     if (status) {
//       Navigator.push(context, MaterialPageRoute(builder: (_){
//         return LoginScreen();
//       }));
//       showSnackBar(context: context, message: 'Logged In Successfully', error: false);
//
//     } else {
//       showSnackBar(context: context, message: 'Something went error , try', error: true);
//     }
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pioneer_project/api/controller/auth_api_controller.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/helpers/helpers.dart';
import 'package:pioneer_project/screens/auth/login/ui/login_screen.dart';

import '../../../helpers/spacing.dart';
import '../../../theming/colors.dart';
import '../../../widgets/app_text_button.dart';
import '../../../widgets/app_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late TextEditingController _nameEditingController;
  late TextEditingController _phoneEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    super.initState();
    _phoneEditingController = TextEditingController();
    _nameEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneEditingController.dispose();
    _passwordEditingController.dispose();
    _nameEditingController.dispose();
    _emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Logo and Title Section
                Container(
                  color: ColorsManager.primary,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 50), // Add some space on top
                        SvgPicture.asset(
                          Images.logo,
                          color: Colors.white,
                          height: 100, // Set logo size
                        ),
                        SizedBox(height: 10),
                        Text(
                          'مرحبا بك في تطبيقنا',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),

                // Form Section
                Container(
                  width: double.infinity,
                  height: 600.h, // Adjust the height to suit your design
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Name Field
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AppTextFormField(
                            controller: _nameEditingController,
                            hintText: 'الاسم كامل',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // Email Field
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AppTextFormField(
                            controller: _emailEditingController,
                            hintText: 'الايميل',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // Phone Field
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AppTextFormField(
                            controller: _phoneEditingController,
                            hintText: 'رقم الهاتف',
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // Password Field
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AppTextFormField(
                            controller: _passwordEditingController,
                            hintText: 'كلمة المرور',
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // Register Button
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: AppTextButton(
                            buttonText: 'تسجيل',
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                            // onPressed: () => performRegister(),
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                                return LoginScreen();
                              }));
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                                    return LoginScreen();
                                  }));
                                },
                                child: Text('SignIn',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )),
                            Text(' ?Already have an account'),

                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty &&
        _phoneEditingController.text.isNotEmpty &&
        _nameEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> register() async {
    bool status = await AuthApiController().register(
      name: _nameEditingController.text,
      email: _emailEditingController.text,
      phone: _phoneEditingController.text,
      password: _passwordEditingController.text,
      context: context,
    );
    if (status) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return LoginScreen();
      }));
      showSnackBar(context: context, message: 'تم تسجيل الحساب بنجاح', error: false);
    } else {
      showSnackBar(context: context, message: 'حدث خطأ، حاول مرة أخرى', error: true);
    }
  }
}
