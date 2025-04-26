
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/dummy_data/initiatives.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/screens/initiative/join.dart';

import '../../api/controller/initiatives_api_controller.dart';
import '../../helpers/spacing.dart';
import '../../models/Initiative.dart';
import '../../theming/colors.dart';
import '../home/app.dart';
import '../profile/ui/profile_screen.dart';

class InitiativesScreen extends StatefulWidget  {
  const InitiativesScreen({super.key});

  @override
  State<InitiativesScreen> createState() => _InitiativesScreenState();
}

class _InitiativesScreenState extends State<InitiativesScreen> with TickerProviderStateMixin {

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
          child:Column(
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
                        child: Icon(Icons.arrow_back,color: ColorsManager.primary,)),
                    Text('المبادرات',
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
                              "المبادرات ",
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
                              "المبادرات المنضم لها",
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

                      // Second



                      FutureBuilder<List<Initiative>>(
                        future: InitiativesApiController().getAllInitiatives(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('لا يوجد مبادرات مكتملة.'));
                          } else {
                            // مبادرات مكتملة حسب شرطك، مثلاً اللي انتهى تاريخها
                            List<Initiative> completedInitiatives = snapshot.data!.toList();
                                // .where((i) => DateTime.tryParse(i.endDate ?? '')?.isBefore(DateTime.now()) ?? false)
                                // .toList();

                            return SizedBox(
                              height: 500.h,
                              child: ListView.builder(
                                itemCount: completedInitiatives.length,
                                itemBuilder: (context, index) {
                                  final compleateItem = completedInitiatives[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (c) => JoinInitiativeScreen(
                                              initiative: compleateItem, // Pass the selected initiative data
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 300.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 150.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                color: Colors.grey.shade400,
                                              ),
                                              child: compleateItem.image != null
                                                  ? Image.network(
                                                compleateItem.image!,
                                                fit: BoxFit.cover,
                                              )
                                                  :  Image.asset('assets/initiative/IMG_8667.PNG',width: double.infinity,  fit: BoxFit.cover,),
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text('${compleateItem.name}'),
                                                      const Spacer(),
                                                      Text('${compleateItem.organizationId}'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${compleateItem.details}'),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.group),
                                                          Text('${compleateItem.maxParticipants}')
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.date_range),
                                                          const SizedBox(width: 6),
                                                          Text('${compleateItem.endDate}'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),

                      Column(
                        children: [
                        ],
                      ),
                    ],
                  ),



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
