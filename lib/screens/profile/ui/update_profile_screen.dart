
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/screens/profile/ui/profile_screen.dart';

import '../../../theming/colors.dart';
import '../../../widgets/app_text_button.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../home/app.dart';

class UpdateProfileScreen extends StatefulWidget  {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> with TickerProviderStateMixin {

  int _indexTab = 0;
  late TabController _tabController;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);


  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
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
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (c){
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
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap:(){
                          print('test');
                          Navigator.push(context, MaterialPageRoute(builder: (c){
                            return AppScreen();
                          }));
                        },
                        child: Icon(Icons.arrow_back)),
                    Text('الملف الشخصي',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height:50,
                  color: ColorsManager.white,
                  child: TabBar(
                    onTap: (value) {
                      setState(() {
                        _indexTab = value;
                      });
                    },

                    controller: _tabController,
                    // unselectedLabelColor: Colors.green,
                    // indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      // borderRadius: BorderRadius.circular(5),
                      // color: Colors.grey,
                    ),

                    // indicator: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: Color.fromRGBO(169, 184, 189, 1),
                    //     ),

                    tabs: [
                      Tab(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: _indexTab == 0 ? ColorsManager.secondary : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                            // border: Border.all(color: Colors.redAccent, width: 1)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "المعلومات الرئيسية",
                              style: TextStyle(
                                color: _indexTab == 0 ? ColorsManager.white : ColorsManager.primary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: _indexTab == 1 ? ColorsManager.secondary : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                            // border: Border.all(color: Colors.redAccent, width: 1)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "المعلومات الثانوية",
                              style: TextStyle(
                                color: _indexTab == 1 ? ColorsManager.white : ColorsManager.primary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              IndexedStack(
                index: _indexTab,
                children: [
                  //First
                  Column(
                    children: [


                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: ColorsManager.primary,
                                    borderRadius: BorderRadius.circular(60)),
                              ),
                            ),
                            // Center(
                            //     child:Icon(Icons.add,color: Colors.white,)
                            // ),


                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15
                              ),
                              child: Text('الاسم كامل'),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AppTextFormField(hintText: 'الاسم كامل'),
                            ),

                          ],
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15
                              ),
                              child: Text('رقم الهاتف'),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AppTextFormField(hintText: 'رقم الهاتف'),
                            ),

                          ],
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15
                              ),
                              child: Text('الايميل'),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AppTextFormField(hintText: 'الايميل'),
                            ),

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppTextButton(
                            buttonText: 'تحديث المعلومات ',
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {

                            }),
                      ),
                    ],
                  )

                ],
              ),

              ////////



            ],
          ),
        ),
      ),
    );
  }
}
