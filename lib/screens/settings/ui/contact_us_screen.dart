import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/api/controller/contact_api_controller.dart';
import 'package:pioneer_project/screens/home/app.dart';
import 'package:pioneer_project/theming/colors.dart';

import '../../../helpers/constants.dart';
import '../../../models/ContactMessage.dart';
import '../../../widgets/app_text_button.dart';
import '../../../widgets/app_text_form_field.dart';
class ContactusScreen extends StatefulWidget {
  const ContactusScreen({Key? key}) : super(key: key);

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final contact = ContactMessage(
        fullName: fullNameController.text,
        phone: phoneController.text,
        subject: subjectController.text,
        message: messageController.text,
      );

      try {
        // Sending the contact message
        await ContactApiController().sendContactMessage(contact);

        // Show success message on successful submission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم إرسال الرسالة بنجاح')),
        );

        // Go back to the previous screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
          return AppScreen();
        }));
      } catch (e) {
        // Handle failure and show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في إرسال الرسالة')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          leading: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (c){
                  return AppScreen();
                }));
              },
              child: Icon(Icons.arrow_back, color: Colors.white, size: 30)),
          title: SvgPicture.asset(Images.logo, color: Colors.white, height: 35, width: 40),
          centerTitle: true,
          actions: [Padding(padding: EdgeInsets.all(10), child: Icon(Icons.person_2_outlined, color: Colors.white, size: 30))],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // InkWell(child: Icon(Icons.arrow_back)),
                      // Center(child: Text('تواصل معنا')),
                      // Icon(Icons.abc_outlined, color: Colors.transparent),
                    ],
                  ),
                ),
                SvgPicture.asset(Images.logo, height: 80),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('PIONEERS', style: GoogleFonts.josefinSans(color: ColorsManager.primary, fontWeight: FontWeight.w700, fontSize: 17)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppTextFormField(
                    controller: fullNameController,
                    hintText: 'Full Name',
                    validator: (val) => val!.isEmpty ? 'الاسم مطلوب' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppTextFormField(
                    controller: phoneController,
                    hintText: 'Mobile',
                    validator: (val) => val!.isEmpty ? 'رقم الهاتف مطلوب' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppTextFormField(
                    controller: subjectController,
                    hintText: 'Subject',
                    validator: (val) => val!.isEmpty ? 'الموضوع مطلوب' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppTextFormField(
                    controller: messageController,
                    hintText: 'Message',
                    // maxLines: 5,
                    validator: (val) => val!.isEmpty ? 'الرسالة مطلوبة' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextButton(
                    buttonText: 'Submit',
                    textStyle: TextStyle(color: Colors.white),
                    onPressed: _submitForm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
