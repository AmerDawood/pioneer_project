//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pioneer_project/helpers/constants.dart';
//
// import '../../../helpers/spacing.dart';
// import '../../../theming/colors.dart';
// import 'update_profile_screen.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: ColorsManager.primary,
//
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
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Center(
//                   child: Container(
//                     height: 90,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         color: ColorsManager.primary,
//                         borderRadius: BorderRadius.circular(60)),
//                   ),
//                 ),
//               ),
//               Text(
//                 'عامر داود',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 'amermadawood@gmail.com',
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               verticalSpace(10),
//
//               InkWell(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (c){
//                     return UpdateProfileScreen();
//                   }));
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 140,
//                   decoration: BoxDecoration(
//                       color: ColorsManager.primary,
//                       borderRadius: BorderRadius.circular(20)
//                   ),
//                   child: Center(child: Text('تحديث الملف الشخصي',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                   )),
//                 ),
//               ),
//               verticalSpace(10),
//
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: 100.h,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.black12,
//                           ),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('10',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               ),
//                               verticalSpace(10),
//                               Text('مبادرات',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     horizontalSpace(10),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: 100.h,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.black12,
//                           ),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('10',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               verticalSpace(10),
//                               Text('ساعة',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 80.h,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black12,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child:Center(
//                     child: Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: ListTile(
//                         leading: Icon(Icons.favorite_outline),
//                         title: Text('المبادرات'),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//                Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 80.h,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black12,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child:Center(
//                     child: Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: ListTile(
//                         leading: Icon(Icons.hub),
//                         title: Text('الساعات'),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pioneer_project/perfs/user_preference_controller.dart';
import 'package:pioneer_project/screens/home/app.dart';
import 'package:pioneer_project/screens/profile/ui/update_profile_screen.dart';
import 'package:pioneer_project/theming/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Define a class to hold profile data
  String name = '';
  String email = '';
  String volunteerHours = '';
  String initiativesCount = '';

  @override
  void initState() {
    super.initState();
    // Fetch the profile data when the screen is loaded
    fetchProfileData();
    loadUserData();

  }

  // Function to fetch profile data from the API
  Future<void> fetchProfileData() async {
    final String apiUrl = 'YOUR_API_URL_HERE'; // Replace with your actual API URL
    final String token = 'YOUR_AUTH_TOKEN_HERE'; // Replace with your actual token

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          name = data['name'];
          email = data['email'];
          volunteerHours = data['volunteer_hours'].toString();
          initiativesCount = data['initiatives_count'].toString();
        });
      } else {
        print('Error: ${response.statusCode}');
        // Handle error if the request fails
      }
    } catch (e) {
      print('Error: $e');
      // Handle any exceptions
    }
  }
  void loadUserData() async {
    final user = await UserPreferenceController().getUser();
    if (user != null) {
      setState(() {
        name = user.name;
        email = user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
              return AppScreen();
            }));
          }, icon: Icon(Icons.arrow_back)),
          centerTitle: true,
          backgroundColor: ColorsManager.primary, // Replace with your color
          title: Text('الملف الشخصي',
          style: TextStyle(
            color: Colors.white,
          ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: ColorsManager.primary,
                        borderRadius: BorderRadius.circular(60)),

                    child: Center(
                      child: Icon(Icons.person,color: Colors.white,),
                    ),
                  ),

                ),
              ),
              Text(
                name.isEmpty ? 'You Name' : name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                email.isEmpty ? 'youremail@gmail.con' : email,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) {
                    return UpdateProfileScreen();
                  }));
                },
                child: Container(
                  height: 30,
                  width: 140,
                  decoration: BoxDecoration(
                      color: ColorsManager.primary,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'تحديث الملف الشخصي',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                initiativesCount.isEmpty
                                    ? '10'
                                    : initiativesCount,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'مبادرات',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                volunteerHours.isEmpty
                                    ? '2'
                                    : volunteerHours,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'ساعة',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        leading: Icon(Icons.favorite_outline),
                        title: Text('المبادرات'),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        leading: Icon(Icons.hub),
                        title: Text('الساعات'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
