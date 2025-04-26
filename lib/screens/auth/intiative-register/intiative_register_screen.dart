import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pioneer_project/helpers/spacing.dart';
import 'package:pioneer_project/theming/colors.dart';
import 'package:pioneer_project/api/api_settings.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

import '../../../models/initiativeOwnerRegisterRequest.dart';
import '../initiative-login/login_screen.dart';

class RegisterInitiativeOwnerScreen extends StatefulWidget {
  const RegisterInitiativeOwnerScreen({super.key});

  @override
  State<RegisterInitiativeOwnerScreen> createState() => _RegisterInitiativeOwnerScreenState();
}

class _RegisterInitiativeOwnerScreenState extends State<RegisterInitiativeOwnerScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  // Organization details controllers
  final TextEditingController orgNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController sectorController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController foundedAtController = TextEditingController();

  // User details controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController languageController = TextEditingController();

  // Default language selection
  final List<String> languages = ['العربية', 'English'];

  File? logoFile;

  @override
  void initState() {
    super.initState();
    // Set default language
    languageController.text = 'العربية';
  }

  @override
  void dispose() {
    // Dispose all controllers
    orgNameController.dispose();
    countryController.dispose();
    cityController.dispose();
    typeController.dispose();
    sectorController.dispose();
    sizeController.dispose();
    websiteController.dispose();
    foundedAtController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    jobTitleController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    languageController.dispose();
    super.dispose();
  }

  Future<void> _pickLogoImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        logoFile = File(picked.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        foundedAtController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  Future<void> _submitForm() async {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Reset error
    setState(() {
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        var uri = Uri.parse(
            'https://pioneer-project-2025.shop/api/register/initiative-owner');
        var request = http.MultipartRequest('POST', uri);

        // Add necessary headers
        request.headers['Accept'] = 'application/json';

        // Add all form fields with appropriate validation
        request.fields['org_name'] = orgNameController.text;
        request.fields['country'] = countryController.text;
        request.fields['city'] = cityController.text;
        request.fields['type'] = typeController.text;
        request.fields['sector'] = sectorController.text;

        // Fix for the size field - ensure it's within acceptable limits
        // Limit size to a short string that will fit in the database column
        String sizeValue = sizeController.text;
        if (sizeValue.length > 20) {  // Assuming max length of 20 characters
          sizeValue = sizeValue.substring(0, 20);
        }
        request.fields['size'] = sizeValue;

        request.fields['first_name'] = firstNameController.text;
        request.fields['last_name'] = lastNameController.text;
        request.fields['job_title'] = jobTitleController.text;
        request.fields['email'] = emailController.text;
        request.fields['password'] = passwordController.text;
        request.fields['password_confirmation'] = confirmPasswordController.text;
        request.fields['preferred_language'] = languageController.text;

        // Optional fields - only add if not empty
        if (websiteController.text.isNotEmpty) {
          request.fields['website'] = websiteController.text;
        }

        if (foundedAtController.text.isNotEmpty) {
          request.fields['founded_at'] = foundedAtController.text;
        }

        // Handle logo - make it null if there's an issue
        if (logoFile != null) {
          try {
            var fileExtension = logoFile!.path.split('.').last.toLowerCase();
            var mimeType = 'image/jpeg'; // Default

            if (fileExtension == 'png') {
              mimeType = 'image/png';
            } else if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
              mimeType = 'image/jpeg';
            }

            request.files.add(await http.MultipartFile.fromPath(
              'org_logo',
              logoFile!.path,
              contentType: MediaType.parse(mimeType),
            ));
          } catch (logoError) {
            debugPrint('❌ Logo error: $logoError - continuing without logo');
            // Don't add logo if there's an error - the API will handle null
          }
        } else {
          // Make sure to send null for org_logo by not including it in the request
          debugPrint('ℹ️ No logo selected, sending without logo');
        }

        // Log request details for debugging
        debugPrint('🔍 Request URL: ${uri.toString()}');
        debugPrint('🔍 Request fields: ${request.fields}');
        debugPrint('🔍 Request files: ${request.files.length}');

        // Send request
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        var responseData = response.body;

        // Log the raw response for debugging
        debugPrint('📊 Status code: ${response.statusCode}');
        debugPrint('📄 Response body: $responseData');

        // Try to parse JSON response
        Map<String, dynamic>? jsonResponse;
        try {
          jsonResponse = jsonDecode(responseData);
          debugPrint('✅ JSON parsed: $jsonResponse');
        } catch (jsonError) {
          debugPrint('❌ JSON parse error: $jsonError');
        }

        if (response.statusCode == 201 || response.statusCode == 200) {
          // Registration successful
          final token = jsonResponse?['token'];
          debugPrint('✅ Registration successful, token: $token');

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(jsonResponse?['message'] ?? 'تم التسجيل بنجاح'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to login screen
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => const InitiativeOwnerLoginScreen())
          );
        } else {
          // Check if the error response contains a SQL error related to size
          String errorMsg = 'حدث خطأ أثناء التسجيل';

          if (jsonResponse != null) {
            if (jsonResponse.containsKey('message') &&
                jsonResponse['message'].toString().contains('Data truncated for column \'size\'')) {
              errorMsg = 'قيمة الحجم كبيرة جدًا. يرجى إدخال قيمة أقصر.';
            } else if (jsonResponse.containsKey('message')) {
              errorMsg = jsonResponse['message'].toString();
            } else if (jsonResponse.containsKey('error')) {
              errorMsg = jsonResponse['error'].toString();
            } else if (jsonResponse.containsKey('errors')) {
              var errors = jsonResponse['errors'];
              if (errors is Map) {
                if (errors.isNotEmpty) {
                  var firstErrorKey = errors.keys.first;
                  var firstError = errors[firstErrorKey];
                  if (firstError is List && firstError.isNotEmpty) {
                    errorMsg = firstError.first.toString();
                  } else {
                    errorMsg = firstError.toString();
                  }
                }
              } else if (errors is String) {
                errorMsg = errors;
              }
            }
          }

          // Show error in an alert dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('خطأ'),
                content: Text(errorMsg),
                actions: [
                  TextButton(
                    child: const Text('حسناً'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        debugPrint('❌ Exception: $e');

        // Show error in an alert dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('خطأ'),
              content: Text('حدث خطأ: ${e.toString()}'),
              actions: [
                TextButton(
                  child: const Text('حسناً'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  final List<Map<String, String>> sizeOptions = [
    {'display': 'صغير', 'value': 'small'},
    {'display': 'متوسط', 'value': 'medium'},
    {'display': 'كبير', 'value': 'large'},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const InitiativeOwnerLoginScreen())
                  );
                },
                icon: const Icon(Icons.arrow_back)
            ),
            centerTitle: true,
            backgroundColor: ColorsManager.primary,
            title: const Text(
              "تسجيل صاحب مبادرة",
              style: TextStyle(
                color: Colors.white,
              ),
            )
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                // Organization Information Section
                const Text(
                    "بيانات المؤسسة",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ),
                verticalSpace(16),

                // Organization name
                TextFormField(
                  controller: orgNameController,
                  decoration: InputDecoration(
                    labelText: "اسم المؤسسة *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "يرجى إدخال اسم المؤسسة"
                      : null,
                ),
                verticalSpace(12),

                // Country
                TextFormField(
                  controller: countryController,
                  decoration: InputDecoration(
                    labelText: "الدولة *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "يرجى إدخال الدولة"
                      : null,
                ),
                verticalSpace(12),

                // City
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: "المدينة *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "يرجى إدخال المدينة"
                      : null,
                ),
                verticalSpace(12),

                // Organization type
                TextFormField(
                  controller: typeController,
                  decoration: InputDecoration(
                    labelText: "نوع المؤسسة *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "يرجى إدخال نوع المؤسسة"
                      : null,
                ),
                verticalSpace(12),

                // Sector
                TextFormField(
                  controller: sectorController,
                  decoration: InputDecoration(
                    labelText: "القطاع *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "يرجى إدخال القطاع"
                      : null,
                ),
                verticalSpace(12),


                // Then in your build method
                DropdownButtonFormField<String>(
                  value: sizeController.text.isEmpty ? null : sizeController.text,
                  decoration: InputDecoration(
                    labelText: "الحجم *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  items: sizeOptions.map((Map<String, String> option) {
                    return DropdownMenuItem<String>(
                      value: option['value'],
                      child: Text(option['display']!),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      sizeController.text = newValue!;
                    });
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? "يرجى اختيار حجم المؤسسة"
                      : null,
                ),
                verticalSpace(12),

                // Website (optional)
                TextFormField(
                  controller: websiteController,
                  decoration: InputDecoration(
                    labelText: "الموقع الإلكتروني",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  keyboardType: TextInputType.url,
                ),
                verticalSpace(12),

                // Founded date (optional)
                TextFormField(
                  controller: foundedAtController,
                  decoration: InputDecoration(
                    labelText: "تاريخ التأسيس",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  readOnly: true,
                ),
                verticalSpace(16),

                // Logo upload
                ElevatedButton.icon(
                  onPressed: _pickLogoImage,
                  icon: const Icon(Icons.image),
                  label: const Text("اختيار شعار المؤسسة"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),

                // Show selected logo if any
                if (logoFile != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الشعار المختار:",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            logoFile!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),

                const Divider(height: 40),

                // User Information Section
                const Text(
                    "بيانات صاحب المبادرة",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ),
                verticalSpace(16),

                // First name
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelText: "الاسم الأول *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "يرجى إدخال الاسم الأول"
                      : null,
                ),
                verticalSpace(12),

                // Last name
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: "اسم العائلة *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "يرجى إدخال اسم العائلة"
                      : null,
                ),
                verticalSpace(12),

                // Job title
                TextFormField(
                  controller: jobTitleController,
                  decoration: InputDecoration(
                    labelText: "المسمى الوظيفي *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "يرجى إدخال المسمى الوظيفي"
                      : null,
                ),
                verticalSpace(12),
                // Email
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "البريد الإلكتروني *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى إدخال البريد الإلكتروني";
                    }
                    // Simple email validation
                    if (!value.contains('@') || !value.contains('.')) {
                      return "يرجى إدخال بريد إلكتروني صحيح";
                    }
                    return null;
                  },
                ),
                verticalSpace(12),

                // Password
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "كلمة المرور *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى إدخال كلمة المرور";
                    }
                    if (value.length < 6) {
                      return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
                    }
                    return null;
                  },
                ),
                verticalSpace(12),

                // Confirm password
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: "تأكيد كلمة المرور *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى تأكيد كلمة المرور";
                    }
                    if (value != passwordController.text) {
                      return "كلمات المرور غير متطابقة";
                    }
                    return null;
                  },
                ),
                verticalSpace(12),

                // Preferred language
                DropdownButtonFormField<String>(
                  value: languageController.text,
                  decoration: InputDecoration(
                    labelText: "اللغة المفضلة *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  items: languages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      languageController.text = newValue!;
                    });
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? "يرجى اختيار اللغة المفضلة"
                      : null,
                ),
                verticalSpace(32),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "تسجيل",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                verticalSpace(20),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("لديك حساب بالفعل؟"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const InitiativeOwnerLoginScreen()),
                        );
                      },
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          color: ColorsManager.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}