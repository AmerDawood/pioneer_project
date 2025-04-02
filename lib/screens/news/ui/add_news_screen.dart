import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pioneer_project/helpers/constants.dart';
import 'package:pioneer_project/helpers/spacing.dart';
import 'package:pioneer_project/theming/colors.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          title: Text(
            'إضافة خبر جديد',
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200
                  ),
                  child: Center(child: Icon(Icons.add_a_photo,color: Colors.white,size: 30,)),
                ),
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'عنوان الخبر',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              verticalSpace(20),
              TextField(
                controller: _detailsController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'تفاصيل الخبر',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              verticalSpace(20),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'تاريخ الخبر',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              verticalSpace(30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add news logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primary,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'إضافة الخبر',
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
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
