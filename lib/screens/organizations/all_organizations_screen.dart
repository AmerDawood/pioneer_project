
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pioneer_project/dummy_data/organizations.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/helpers/spacing.dart';
import 'package:pioneer_project/screens/categories/category_details.dart';


import '../../api/controller/home_api_controller.dart';
import '../../models/news.dart';
import '../../theming/colors.dart';
import '../home/app.dart';
import '../profile/ui/profile_screen.dart';
class AllOrganizationsScreen extends StatefulWidget {
  const AllOrganizationsScreen({Key? key}) : super(key: key);

  @override
  State<AllOrganizationsScreen> createState() => _AllOrganizationsScreenState();
}



class _AllOrganizationsScreenState extends State<AllOrganizationsScreen> {

  late Future<List<Organization>> organizations;


  @override
  void initState() {
    super.initState();
    // Initialize the Future variables here.
    organizations = HomeApiController().getOrganizations();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          // leading: Icon(
          //   Icons.person_2_outlined,
          //   color: Colors.white,
          //   size: 30,
          // ),
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
                  return ProfileScreen();
                }));
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                // minRadius: 10,
                child: SvgPicture.asset(Images.logo,height: 20,),
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
            Padding(
              padding: EdgeInsets.all(10),
              child:
              Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
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
                        onTap:(){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
                            return AppScreen();
                          }));
                        },
                        child: Icon(Icons.arrow_back)),
                    Text('المنظمات',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.abc_outlined,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 700.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Organization>>(
                    future: organizations, // ← حط هنا ال future اللي بترجع البيانات
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('فشل في تحميل المنظمات: ${snapshot.error}'));
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return Center(child: Text('لا توجد منظمات حاليا'));
                      } else if (snapshot.hasData) {
                        final organizationsList = snapshot.data!;
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.7,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: organizationsList.length,
                          itemBuilder: (context, index) {
                            final item = organizationsList[index];
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (c) => CategoryDetailsScreen(id: item.id.toString(),logo: item.logo!,)),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (item.logo != null && item.logo!.isNotEmpty)
                                        Image.network(
                                          'https://pioneer-project-2025.shop/storage/app/public/${item.logo!}',
                                          height: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                              Icon(Icons.broken_image),
                                        )
                                      else
                                        Image.asset(
                                          'assets/organizations/IMG_8672.PNG',
                                          height: 40,
                                        ),
                                      verticalSpace(15),
                                      Text(
                                        '${item.name}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('لا توجد بيانات'));
                      }
                    },
                  ),
                ),
              )


              // SizedBox(
              //   height: 700.h,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: GridView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         childAspectRatio: 1.7,
              //         crossAxisSpacing: 5,
              //         mainAxisSpacing: 5,
              //       ),
              //       itemCount: organizations.length,
              //       // itemCount: 8,
              //       itemBuilder: (context, index) {
              //               final item = organizations[index];
              //         return Padding(
              //           padding: const EdgeInsets.all(2.0),
              //           child: InkWell(
              //             onTap: (){
              //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
              //                 return CategoryDetailsScreen();
              //               }));
              //             },
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 border: Border.all(width: 0.5),
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   // SvgPicture.asset(Images.logo,height: 40,),
              //                    Image.asset('${item.logoPath}',height: 40,),
              //                   verticalSpace(15),
              //                   Text(
              //                     '${item.title}',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 15,
              //                       fontFamily: 'Inter',
              //                       fontWeight: FontWeight.w700,
              //                       letterSpacing: -0.50,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),




            ],
          ),
        ),
      ),
    );
  }
}
