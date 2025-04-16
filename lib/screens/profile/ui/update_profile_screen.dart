//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pioneer_project/helpers/constants.dart';
// import 'package:pioneer_project/screens/profile/ui/profile_screen.dart';
//
// import '../../../theming/colors.dart';
// import '../../../widgets/app_text_button.dart';
// import '../../../widgets/app_text_form_field.dart';
// import '../../home/app.dart';
//
// class UpdateProfileScreen extends StatefulWidget  {
//   const UpdateProfileScreen({super.key});
//
//   @override
//   State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
// }
//
// class _UpdateProfileScreenState extends State<UpdateProfileScreen> with TickerProviderStateMixin {
//
//   int _indexTab = 0;
//   late TabController _tabController;
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//
//
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _tabController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: ColorsManager.primary,
//           leading: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: InkWell(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (c){
//                   return ProfileScreen();
//                 }));
//               },
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 // minRadius: 10,
//                 child: SvgPicture.asset(Images.logo,height: 20,),
//               ),
//             ),
//           ),
//           title: SvgPicture.asset(
//             Images.logo,
//             color: Colors.white,
//             height: 35,
//             width: 40,
//           ),
//           centerTitle: true,
//           actions: [
//             Padding(
//               padding: EdgeInsets.all(10),
//               child:
//               Icon(
//                 Icons.menu,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child:Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                         onTap:(){
//                           print('test');
//                           Navigator.push(context, MaterialPageRoute(builder: (c){
//                             return AppScreen();
//                           }));
//                         },
//                         child: Icon(Icons.arrow_back)),
//                     Text('الملف الشخصي',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                       ),
//                     ),
//                     Icon(
//                       Icons.abc_outlined,
//                       color: Colors.transparent,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height:50,
//                   color: ColorsManager.white,
//                   child: TabBar(
//                     onTap: (value) {
//                       setState(() {
//                         _indexTab = value;
//                       });
//                     },
//
//                     controller: _tabController,
//                     // unselectedLabelColor: Colors.green,
//                     // indicatorSize: TabBarIndicatorSize.tab,
//                     indicator: BoxDecoration(
//                       // borderRadius: BorderRadius.circular(5),
//                       // color: Colors.grey,
//                     ),
//
//                     // indicator: BoxDecoration(
//                     //     borderRadius: BorderRadius.circular(10),
//                     //     color: Color.fromRGBO(169, 184, 189, 1),
//                     //     ),
//
//                     tabs: [
//                       Tab(
//                         child: Container(
//                           height: 50.h,
//                           decoration: BoxDecoration(
//                             color: _indexTab == 0 ? ColorsManager.secondary : Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(5),
//                             // border: Border.all(color: Colors.redAccent, width: 1)
//                           ),
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "المعلومات الرئيسية",
//                               style: TextStyle(
//                                 color: _indexTab == 0 ? ColorsManager.white : ColorsManager.primary,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'Poppins',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Tab(
//                         child: Container(
//                           height: 50.h,
//                           decoration: BoxDecoration(
//                             color: _indexTab == 1 ? ColorsManager.secondary : Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(5),
//                             // border: Border.all(color: Colors.redAccent, width: 1)
//                           ),
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "المعلومات الثانوية",
//                               style: TextStyle(
//                                 color: _indexTab == 1 ? ColorsManager.white : ColorsManager.primary,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'Poppins',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//               IndexedStack(
//                 index: _indexTab,
//                 children: [
//                   //First
//                   Column(
//                     children: [
//
//
//                       Padding(
//                         padding: const EdgeInsets.all(18.0),
//                         child: Stack(
//                           children: [
//                             Center(
//                               child: Container(
//                                 height: 90,
//                                 width: 90,
//                                 decoration: BoxDecoration(
//                                     color: ColorsManager.primary,
//                                     borderRadius: BorderRadius.circular(60)),
//                               ),
//                             ),
//                             // Center(
//                             //     child:Icon(Icons.add,color: Colors.white,)
//                             // ),
//
//
//                           ],
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   right: 15
//                               ),
//                               child: Text('الاسم كامل'),
//                             ),
//
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: AppTextFormField(hintText: 'الاسم كامل'),
//                             ),
//
//                           ],
//                         ),
//                       ),
//
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   right: 15
//                               ),
//                               child: Text('رقم الهاتف'),
//                             ),
//
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: AppTextFormField(hintText: 'رقم الهاتف'),
//                             ),
//
//                           ],
//                         ),
//                       ),
//
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   right: 15
//                               ),
//                               child: Text('الايميل'),
//                             ),
//
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: AppTextFormField(hintText: 'الايميل'),
//                             ),
//
//                           ],
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: AppTextButton(
//                             buttonText: 'تحديث المعلومات ',
//                             textStyle: TextStyle(
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//
//                             }),
//                       ),
//                     ],
//                   )
//
//                 ],
//               ),
//
//               ////////
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/screens/profile/ui/profile_screen.dart';
import '../../../api/controller/auth_api_controller.dart';
import '../../../theming/colors.dart';
import '../../../widgets/app_text_button.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../home/app.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> with TickerProviderStateMixin {
  int _indexTab = 0;
  late TabController _tabController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController(); // For display only
  File? profileImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // يمكن ملء الحقول بقيم المستخدم الحالي إذا توفرت
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> updateProfile() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الاسم ورقم الهاتف مطلوبان')),
      );
      return;
    }

    // bool success = await AuthApiController().updateProfile(
    //   name: name,
    //   phone: phone,
    //   profileImagePath:profileImage?.path,
    // );
    bool success = await AuthApiController().updateProfile(
      name: nameController.text,
      phone: phoneController.text,
      profileImagePath: profileImage?.path,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم التحديث بنجاح')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء التحديث')),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(Images.logo, height: 20),
              ),
            ),
          ),
          title: SvgPicture.asset(Images.logo, color: Colors.white, height: 35, width: 40),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.menu, color: Colors.white, size: 30),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AppScreen())),
                        child: Icon(Icons.arrow_back)),
                    Text('الملف الشخصي', style: TextStyle(fontSize: 20)),
                    Icon(Icons.abc_outlined, color: Colors.transparent),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  color: ColorsManager.white,
                  child: TabBar(
                    onTap: (value) => setState(() => _indexTab = value),
                    controller: _tabController,
                    indicator: BoxDecoration(),
                    tabs: [
                      Tab(child: _buildTabLabel("المعلومات الرئيسية", 0)),
                      Tab(child: _buildTabLabel("المعلومات الثانوية", 1)),
                    ],
                  ),
                ),
              ),
              IndexedStack(
                index: _indexTab,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: ColorsManager.primary,
                              backgroundImage:
                              profileImage != null ? FileImage(profileImage!) : null,
                              child: profileImage == null
                                  ? Icon(Icons.person, color: Colors.white, size: 40)
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: pickImage,
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.camera_alt, size: 16, color: ColorsManager.primary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildInputField('الاسم كامل', nameController),
                      _buildInputField('رقم الهاتف', phoneController),
                      _buildInputField('الايميل', emailController, enabled: false),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppTextButton(
                          buttonText: 'تحديث المعلومات',
                          textStyle: TextStyle(color: Colors.white),
                          onPressed: updateProfile,
                        ),
                      ),
                    ],
                  ),
                  Center(child: Text('المعلومات الثانوية')), // المحتوى الثانوي يمكن إضافته لاحقاً
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabLabel(String title, int index) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: _indexTab == index ? ColorsManager.secondary : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: _indexTab == index ? ColorsManager.white : ColorsManager.primary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          AppTextFormField(
            controller: controller,
            hintText: label,
            // enabled: enabled,
          ),
        ],
      ),
    );
  }
}
