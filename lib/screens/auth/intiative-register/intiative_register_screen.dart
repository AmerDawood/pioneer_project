import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pioneer_project/helpers/spacing.dart';
import 'package:pioneer_project/theming/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../initiative-login/login_screen.dart';

class RegisterInitiativeOwnerScreen extends StatefulWidget {
  const RegisterInitiativeOwnerScreen({super.key});

  @override
  State<RegisterInitiativeOwnerScreen> createState() => _RegisterInitiativeOwnerScreenState();
}

class _RegisterInitiativeOwnerScreenState extends State<RegisterInitiativeOwnerScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers
  final TextEditingController orgNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController sectorController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController foundedAtController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController languageController = TextEditingController();

  File? logoFile;

  Future<void> _pickLogoImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        logoFile = File(picked.path);
      });
    }
  }

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     // استدعاء API التسجيل هنا
  //     debugPrint("Registering...");
  //     debugPrint("Organization: ${orgNameController.text}");
  //     debugPrint("First Name: ${firstNameController.text}");
  //     // ... وباقي البيانات
  //
  //     // تقدر تستخدم Multipart request هنا وترسل صورة الشعار (logoFile)
  //   }
  // }


  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // 👉 طباعة بيانات الإدخال للتأكد
      debugPrint("Registering...");
      debugPrint("Organization: ${orgNameController.text}");
      debugPrint("First Name: ${firstNameController.text}");

      // 👉 إعداد الطلب
      var uri = Uri.parse('https://yourapi.com/api/register-initiative-owner');
      var request = http.MultipartRequest('POST', uri);

      // ✅ إضافة الحقول العادية
      request.fields['org_name'] = orgNameController.text;
      request.fields['country'] = countryController.text;
      request.fields['city'] = cityController.text;
      request.fields['type'] = typeController.text;
      request.fields['sector'] = sectorController.text;
      request.fields['size'] = sizeController.text;
      request.fields['founded_at'] = foundedAtController.text;
      request.fields['website'] = websiteController.text;

      request.fields['first_name'] = firstNameController.text;
      request.fields['last_name'] = lastNameController.text;
      request.fields['job_title'] = jobTitleController.text;
      request.fields['email'] = emailController.text;
      request.fields['password'] = passwordController.text;
      request.fields['password_confirmation'] = confirmPasswordController.text;
      request.fields['preferred_language'] = languageController.text;

      // ✅ إضافة صورة الشعار إن وُجدت
      if (logoFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'org_logo',
          logoFile!.path,
        ));
      }

      try {
        // إرسال الطلب
        var response = await request.send();

        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseData = await response.stream.bytesToString();
          debugPrint('✅ Registration successful: $responseData');

          final jsonResponse = jsonDecode(responseData);
          final token = jsonResponse['token'];
          debugPrint("🎉 Token: $token");

          // هنا ممكن تخزن التوكن أو تنتقل لصفحة ثانية
        } else {
          debugPrint('❌ Failed to register. Status Code: ${response.statusCode}');
          var errorData = await response.stream.bytesToString();
          debugPrint('🚨 Error: $errorData');
        }
      } catch (e) {
        debugPrint('🚫 Exception occurred: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
            return InitiativeOwnerLoginScreen();
          }));
        }, icon:Icon(Icons.arrow_back)),
        centerTitle: true,
        backgroundColor: ColorsManager.primary,
          title: const Text("تسجيل صاحب مبادرة",
            style: TextStyle(
              color: Colors.white,
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("بيانات المؤسسة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              verticalSpace(10),
              TextFormField(
                controller: orgNameController,
                decoration: const InputDecoration(labelText: "اسم المؤسسة"),
                validator: (value) => value!.isEmpty ? "مطلوب" : null,
              ),
              TextFormField(
                controller: countryController,
                decoration: const InputDecoration(labelText: "الدولة"),
              ),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(labelText: "المدينة"),
              ),
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(labelText: "نوع المؤسسة"),
              ),
              TextFormField(
                controller: sectorController,
                decoration: const InputDecoration(labelText: "القطاع"),
              ),
              TextFormField(
                controller: sizeController,
                decoration: const InputDecoration(labelText: "الحجم"),
              ),
              TextFormField(
                controller: websiteController,
                decoration: const InputDecoration(labelText: "الموقع الإلكتروني"),
              ),
              TextFormField(
                controller: foundedAtController,
                decoration: const InputDecoration(labelText: "تاريخ التأسيس"),
              ),
              verticalSpace(10),
              ElevatedButton.icon(
                onPressed: _pickLogoImage,
                icon: const Icon(Icons.image),
                label: const Text("اختيار شعار المؤسسة"),
              ),
              if (logoFile != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(logoFile!, height: 100),
                ),
              const Divider(height: 40),
              const Text("بيانات صاحب المبادرة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              verticalSpace(10),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: "الاسم الأول"),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: "اسم العائلة"),
              ),
              TextFormField(
                controller: jobTitleController,
                decoration: const InputDecoration(labelText: "المسمى الوظيفي"),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "البريد الإلكتروني"),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "كلمة المرور"),
                obscureText: true,
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(labelText: "تأكيد كلمة المرور"),
                obscureText: true,
              ),
              TextFormField(
                controller: languageController,
                decoration: const InputDecoration(labelText: "اللغة المفضلة"),
              ),
              verticalSpace(20),
              ElevatedButton(
                onPressed: (){
                  // _submitForm();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
                    return InitiativeOwnerLoginScreen();
                  }));
                },
                child: const Text("تسجيل"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
