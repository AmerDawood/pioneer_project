import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../api/controller/news_api_controller.dart';
import '../../../helpers/spacing.dart';
import '../../../theming/colors.dart';
import '../../owner/owner_screen.dart';

class UpdateNewsScreen extends StatefulWidget {
  final int newsId;
  final String initialTitle;
  final String initialDetails;

  const UpdateNewsScreen({
    super.key,
    required this.newsId,
    required this.initialTitle,
    required this.initialDetails,
  });

  @override
  State<UpdateNewsScreen> createState() => _UpdateNewsScreenState();
}

class _UpdateNewsScreenState extends State<UpdateNewsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle;
    _detailsController.text = widget.initialDetails;
  }

  Future<void> _pickImage() async {
    // Use your image picker logic here
    // Example:
    // final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (picked != null) {
    //   setState(() {
    //     _pickedImage = File(picked.path);
    //   });
    // }
  }

  Future<void> _submit() async {
    final success = await updateNews(
      id: widget.newsId,
      title: _titleController.text,
      details: _detailsController.text,
      image: _pickedImage,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'تم تحديث الخبر بنجاح' : 'فشل في تحديث الخبر'),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );

    if (success) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => OwnerDashboardScreen()));
        }, icon: Icon(Icons.arrow_back)),
        backgroundColor: ColorsManager.primary,
        title: Text('تحديث الخبر', style: TextStyle(color: Colors.white, fontSize: 20.sp)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
                  image: _pickedImage != null
                      ? DecorationImage(
                    image: FileImage(_pickedImage!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: _pickedImage == null
                    ? Center(
                  child: Icon(Icons.add_a_photo, color: Colors.grey.shade600, size: 40),
                )
                    : null,
              ),
            ),
            verticalSpace(20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'عنوان الخبر',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
            ),
            verticalSpace(20),
            TextField(
              controller: _detailsController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'تفاصيل الخبر',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
            ),
            verticalSpace(30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'تحديث الخبر',
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
