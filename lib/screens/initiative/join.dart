import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pioneer_project/screens/status/success_screen.dart';
import '../../../theming/colors.dart';
import '../../../helpers/spacing.dart';

class JoinInitiativeScreen extends StatelessWidget {
  const JoinInitiativeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية للمبادرة
    final String name = "مبادرة تنظيف الشواطئ";
    final String location = "غزة - البحر";
    final String startDate = "2025-04-10";
    final String endDate = "2025-04-15";
    final int maxParticipants = 50;
    final int hours = 10;
    final String? image = "assets/initiative/IMG_8667.PNG";

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
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
                    image: AssetImage(image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              verticalSpace(20),

              // تفاصيل المبادرة
              Text(
                name,
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              verticalSpace(10),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("الموقع: $location", style: TextStyle(fontSize: 16.sp)),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("تاريخ البداية: $startDate", style: TextStyle(fontSize: 16.sp)),
              ),
              Divider(),
              Text("تاريخ الانتهاء: $endDate", style: TextStyle(fontSize: 16.sp)),

              Divider(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("عدد الساعات المطلوبة: $hours ساعة", style: TextStyle(fontSize: 16.sp)),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("الحد الأقصى للمشاركين: $maxParticipants", style: TextStyle(fontSize: 16.sp)),
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c){
                      return SuccessScreen();
                    }));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("تم التقديم للمبادرة بنجاح!"))
                    );
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