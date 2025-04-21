import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pioneer_project/screens/status/success_screen.dart';
import '../../../theming/colors.dart';
import '../../../helpers/spacing.dart';
import '../../api/controller/initiatives_api_controller.dart';
import '../../models/Initiative.dart';
import '../home/app.dart';

class JoinInitiativeScreen extends StatelessWidget {
  final Initiative initiative; // Accept the real data

  const JoinInitiativeScreen({super.key, required this.initiative});

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
          backgroundColor: ColorsManager.primary,
          title: Text("التقديم للمبادرة"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المبادرة
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: initiative.image != null
                        ? NetworkImage(initiative.image!) as ImageProvider
                        : AssetImage("assets/initiative/IMG_8667.PNG"), // Default image if null
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              verticalSpace(20),

              // تفاصيل المبادرة
              Text(
                initiative.name,
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              verticalSpace(10),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("الموقع: ${initiative.location}", style: TextStyle(fontSize: 16.sp)),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("تاريخ البداية: ${initiative.startDate}", style: TextStyle(fontSize: 16.sp)),
              ),
              Divider(),
              Text("تاريخ الانتهاء: ${initiative.endDate}", style: TextStyle(fontSize: 16.sp)),

              Divider(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("عدد الساعات المطلوبة: ${initiative.hours} ساعة", style: TextStyle(fontSize: 16.sp)),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("الحد الأقصى للمشاركين: ${initiative.maxParticipants}", style: TextStyle(fontSize: 16.sp)),
              ),
              Divider(),
              Spacer(),

              // زر التقديم
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primary,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: () async{
                      bool joined = await InitiativesApiController().joinInitiative(initiative.id);

                      if (joined) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("تم التقديم للمبادرة بنجاح!")),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (c) => SuccessScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("فشل في التقديم للمبادرة. حاول مرة أخرى.")),
                        );
                      }

                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
                    //   return SuccessScreen();
                    // }));
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text("تم التقديم للمبادرة بنجاح!"))
                    // );
                  },
                  child: Text("تقديم الطلب", style: TextStyle(fontSize: 18.sp, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
