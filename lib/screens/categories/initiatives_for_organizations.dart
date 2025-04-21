import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../dummy_data/initiatives.dart';
import '../../helpers/constants.dart';
import '../../helpers/spacing.dart';
import '../../theming/colors.dart';
import '../initiative/join.dart';


class IntiativesForOrganizations extends StatefulWidget {
  const IntiativesForOrganizations({super.key});

  @override
  State<IntiativesForOrganizations> createState() => _IntiativesForOrganizationsState();
}

class _IntiativesForOrganizationsState extends State<IntiativesForOrganizations> {
  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          // leading: InkWell(
          //   onTap: (){
          //     Navigator.pop(context);
          //   },
          //   child: Icon(
          //     Icons.arrow_back,
          //     color: Colors.white,
          //     size: 30,
          //   ),
          // ),
          title: SvgPicture.asset(
            Images.logo,
            color: Colors.white,
            height: 35,
            width: 40,
          ),
          centerTitle: true,
          actions: [
            // Padding(
            //   padding: EdgeInsets.all(10),
            //   child: Icon(
            //     Icons.person_2_outlined,
            //     color: Colors.white,
            //     size: 30,
            //   ),
            // ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 700.h,
              //   child: ListView.builder(
              //     itemCount: completedInitiatives.length,
              //     itemBuilder: (context , index){
              //       final compleateItem = completedInitiatives[index];
              //       return   Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: InkWell(
              //           onTap: (){
              //             Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
              //               return JoinInitiativeScreen();
              //             }));
              //           },
              //           child: Container(
              //             height: 300.h,
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(12),
              //               color: Colors.grey.shade100,
              //             ),
              //             child: Column(
              //               children: [
              //                 Container(
              //                   height: 150.h,
              //                   width: double.infinity,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(12),
              //                     color: Colors.grey.shade400,
              //                   ),
              //                   child: Image.asset('${compleateItem.imageUrl}',fit: BoxFit.cover,),
              //                 ),
              //
              //                 Column(
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Row(
              //                         children: [
              //                           Text('${compleateItem.title}'),
              //                           Spacer(),
              //                           Text('${compleateItem.organization}'),
              //
              //                         ],
              //                       ),
              //                     ),
              //
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Text('${compleateItem.description}'),
              //                     ),
              //
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Row(
              //                         children: [
              //                           Row(
              //                             children: [
              //                               Icon(Icons.add),
              //                               Text('${compleateItem.participants}')
              //                             ],
              //                           ),
              //                           Spacer(),
              //                           Row(
              //                             children: [
              //                               Icon(Icons.date_range),
              //                               horizontalSpace(6),
              //                               Text('${compleateItem.date}')
              //                             ],
              //                           ),
              //
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //
              //     },
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
