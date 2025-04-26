
import 'package:flutter/material.dart';
import 'package:pioneer_project/api/controller/auth_api_controller.dart';
import 'package:pioneer_project/helpers/helpers.dart';
import 'package:pioneer_project/screens/home/app.dart';
import 'package:pioneer_project/screens/owner/owner_screen.dart';

import '../../../../../helpers/spacing.dart';
import '../../../../../perfs/user_preference_controller.dart';
import '../../../../../widgets/app_text_button.dart';
import '../../../../../widgets/app_text_form_field.dart';
import '../../../../home/home_screen.dart';
import 'dont_hav_an_account_widget.dart';
import 'forget_password_widgets.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> with Helpers {

  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
                children: [
                  verticalSpace(10),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        AppTextFormField(
                          controller: _emailEditingController,
                          // controller: _loginValidation.emailController,
                          hintText: 'الايميل',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          // validator: _loginValidation.validateEmail,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        AppTextFormField(
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
                          // validator: _loginValidation.validatePassword,
                        )
                      ],
                    ),
                  ),
                 ForgetPasswordWidget(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextButton(
                        buttonText: ' تسجيل الدخول',
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        onPressed: () async{
                          // String? role = await UserPreferenceController().getUserRole();
                          // print(role);
                          performLogin();
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                          //   return AppScreen();
                          // }));
                          // if (_loginValidation.validateInputs()) {
                        
                          // } else {
                          //   setState(() {
                          //     print(_loginValidation.emailController.text);
                          //     print(_loginValidation.passwordController.text);
                          //   });
                          // }
                          // debugPrint('login preesd now');
                              // Navigator.push(
                              //   context, MaterialPageRoute(builder: (_) => HomeScreen()));

                        }),
                  ),

                  verticalSpace(10),
                  DontHaveAnAccountWidget(),
                ],
              );
  }
  

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> login() async {
    bool status = await AuthApiController().login(
      email: _emailEditingController.text,
      password: _passwordEditingController.text,
    );

    if (status) {
      // سحب الدور لتحديد إلى أي شاشة ننتقل
      String? role = await UserPreferenceController().getUserRole();

      if (role == 'normal_user') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AppScreen()));
      } else if (role == 'initiative_owner') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OwnerDashboardScreen()));
      } else {
        // دور غير معروف
        showSnackBar(context: context, message: 'دور المستخدم غير معروف', error: true);
        return;
      }

      showSnackBar(context: context, message: 'تم تسجيل الدخول بنجاح', error: false);
    } else {
      showSnackBar(context: context, message: 'فشل تسجيل الدخول', error: true);
    }
  }




}