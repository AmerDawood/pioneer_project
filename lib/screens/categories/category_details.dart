
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/models/news.dart';
import 'package:pioneer_project/screens/categories/category_screen.dart';
import 'package:pioneer_project/screens/home/app.dart';
import 'package:pioneer_project/screens/organizations/all_organizations_screen.dart';

import '../../api/controller/organization_api_controller.dart';
import '../../helpers/spacing.dart';
import '../../theming/colors.dart';
import 'initiatives_for_organizations.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String id;
  final String logo;
  const CategoryDetailsScreen({super.key, required this.id , required this.logo});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  late Future<Organization> _organizations;
  @override
  void initState() {
    super.initState();
    _organizations = OrganizationsApiController().getOrganizationById(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          leading:  Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap:(){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (_){
                  return AllOrganizationsScreen();
                }));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          title: SvgPicture.asset(
            Images.logo,
            color: Colors.white,
            height: 35,
            width: 40,
          ),
          centerTitle: true,
          actions: [

          ],
        ),
        body:FutureBuilder<Organization>(
          future: _organizations,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('حدث خطأ: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final organization = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // العنوان مع العودة
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) {
                                return AllOrganizationsScreen();
                              }));
                            },
                            child: Icon(Icons.arrow_back, color: Colors.blue),
                          ),
                          Text(organization.name),
                          Icon(
                            Icons.abc_outlined,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),

                    // صورة المنظمة
                    // Text(widget.logo),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: organization.logo != null && organization.logo!.isNotEmpty
                          ? Image.network(
                        'https://pioneer-project-2025.shop/storage/app/public/${widget.logo}',
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        'assets/organizations/IMG_8673.PNG',
                        height: 100,
                        width: 60,
                      ),
                    ),

                    // اسم المنظمة
                    Text(
                      organization.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // معلومات إضافية
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Website'),
                              verticalSpace(10),
                              Text(organization.website ?? 'لا يوجد'),
                            ],
                          ),
                          horizontalSpace(30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Section'),
                              verticalSpace(10),
                              Text(organization.sector ?? 'غير محدد'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Place'),
                              verticalSpace(10),
                              Text('${organization.country ?? ''} / ${organization.city ?? ''}'),
                            ],
                          ),
                          horizontalSpace(30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Size'),
                              verticalSpace(10),
                              Text(organization.size ?? 'غير محدد'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Type'),
                              verticalSpace(10),
                              Text(organization.type ?? 'غير محدد'),
                            ],
                          ),
                          horizontalSpace(30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Year'),
                              verticalSpace(10),
                              Text(organization.foundedAt ?? 'غير متوفر'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // عنوان آخر المبادرات
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text(
                    //         'اخر الاعلانات',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 22,
                    //         ),
                    //       ),
                    //     ),
                    //     Spacer(),
                    //     Padding(
                    //       padding: const EdgeInsets.all(18.0),
                    //       child: InkWell(
                    //         onTap: () {
                    //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                    //             return IntiativesForOrganizations();
                    //           }));
                    //         },
                    //         child: Text(
                    //           'الكل',
                    //           style: TextStyle(
                    //             color: Colors.blue,
                    //             fontSize: 15,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    // قائمة بالمبادرات
                    // ...organization.initiatives.map((initiative) {
                    //   return Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(20),
                    //         border: Border.all(color: Colors.black),
                    //       ),
                    //       child: ListTile(
                    //         title: Text(
                    //           initiative.name,
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //           ),
                    //         ),
                    //         subtitle: Text(initiative.location),
                    //         trailing: Text(
                    //           initiative.date,
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // }).toList(),

                  ],
                ),
              );
            } else {
              return Center(child: Text('لا توجد بيانات'));
            }
          },
        ),
      ),
    );
  }
}
