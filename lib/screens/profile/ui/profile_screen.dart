import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pioneer_project/api/controller/auth_api_controller.dart';
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
        body: FutureBuilder<Map<String, dynamic>?>(
          future: AuthApiController().fetchUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('لا توجد بيانات'));
            }

            final data = snapshot.data!;
            name = data['name'] ?? '';
            email = data['email'] ?? '';
            volunteerHours = data['volunteer_hours'].toString();
            initiativesCount = data['initiatives_count'].toString();

            return SingleChildScrollView(
              child: Column(
                children: [
                  // باقي الكود يلي كتبته بدون تغيير
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: ColorsManager.primary,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Center(
                          child: Icon(Icons.person, color: Colors.white),
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
                    email.isEmpty ? 'youremail@gmail.com' : email,
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
                                    initiativesCount.isEmpty ? '0' : initiativesCount,
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
                                    volunteerHours.isEmpty ? '0' : volunteerHours,
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
            );
          },
        ),

        // body: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(18.0),
        //         child: Center(
        //           child: Container(
        //             height: 90,
        //             width: 90,
        //             decoration: BoxDecoration(
        //                 color: ColorsManager.primary,
        //                 borderRadius: BorderRadius.circular(60)),
        //
        //             child: Center(
        //               child: Icon(Icons.person,color: Colors.white,),
        //             ),
        //           ),
        //
        //         ),
        //       ),
        //       Text(
        //         name.isEmpty ? 'You Name' : name,
        //         style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 22,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //       Text(
        //         email.isEmpty ? 'youremail@gmail.con' : email,
        //         style: TextStyle(
        //           color: Colors.grey,
        //           fontSize: 18,
        //           fontWeight: FontWeight.w400,
        //         ),
        //       ),
        //
        //       SizedBox(height: 10),
        //       InkWell(
        //         onTap: () {
        //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) {
        //             return UpdateProfileScreen();
        //           }));
        //         },
        //         child: Container(
        //           height: 30,
        //           width: 140,
        //           decoration: BoxDecoration(
        //               color: ColorsManager.primary,
        //               borderRadius: BorderRadius.circular(20)),
        //           child: Center(
        //             child: Text(
        //               'تحديث الملف الشخصي',
        //               style: TextStyle(
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(height: 10),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Row(
        //           children: [
        //             Expanded(
        //               flex: 1,
        //               child: Container(
        //                 height: 100,
        //                 decoration: BoxDecoration(
        //                   border: Border.all(color: Colors.black12),
        //                   borderRadius: BorderRadius.circular(15),
        //                 ),
        //                 child: Center(
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Text(
        //                         initiativesCount.isEmpty
        //                             ? '10'
        //                             : initiativesCount,
        //                         style: TextStyle(
        //                           color: Colors.black,
        //                           fontWeight: FontWeight.w600,
        //                         ),
        //                       ),
        //                       SizedBox(height: 10),
        //                       Text(
        //                         'مبادرات',
        //                         style: TextStyle(
        //                           color: Colors.black,
        //                           fontWeight: FontWeight.w600,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             SizedBox(width: 10),
        //             Expanded(
        //               flex: 1,
        //               child: Container(
        //                 height: 100,
        //                 decoration: BoxDecoration(
        //                   border: Border.all(color: Colors.black12),
        //                   borderRadius: BorderRadius.circular(15),
        //                 ),
        //                 child: Center(
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Text(
        //                         volunteerHours.isEmpty
        //                             ? '2'
        //                             : volunteerHours,
        //                         style: TextStyle(
        //                           color: Colors.black,
        //                           fontWeight: FontWeight.w600,
        //                         ),
        //                       ),
        //                       SizedBox(height: 10),
        //                       Text(
        //                         'ساعة',
        //                         style: TextStyle(
        //                           color: Colors.black,
        //                           fontWeight: FontWeight.w600,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(
        //           height: 80,
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //             border: Border.all(color: Colors.black12),
        //             borderRadius: BorderRadius.circular(15),
        //           ),
        //           child: Center(
        //             child: Directionality(
        //               textDirection: TextDirection.rtl,
        //               child: ListTile(
        //                 leading: Icon(Icons.favorite_outline),
        //                 title: Text('المبادرات'),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(
        //           height: 80,
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //             border: Border.all(color: Colors.black12),
        //             borderRadius: BorderRadius.circular(15),
        //           ),
        //           child: Center(
        //             child: Directionality(
        //               textDirection: TextDirection.rtl,
        //               child: ListTile(
        //                 leading: Icon(Icons.hub),
        //                 title: Text('الساعات'),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
