// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pioneer_project/helpers/constants.dart';
// import 'package:pioneer_project/helpers/spacing.dart';
// import 'package:pioneer_project/theming/colors.dart';
//
// class AddNewsScreen extends StatefulWidget {
//   const AddNewsScreen({super.key});
//
//   @override
//   State<AddNewsScreen> createState() => _AddNewsScreenState();
// }
//
// class _AddNewsScreenState extends State<AddNewsScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _detailsController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _detailsController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: ColorsManager.primary,
//           title: Text(
//             'إضافة خبر جديد',
//             style: TextStyle(color: Colors.white, fontSize: 20.sp),
//           ),
//           centerTitle: true,
//           iconTheme: IconThemeData(color: Colors.white),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 10,
//                   bottom: 10,
//                 ),
//                 child: Container(
//                   height: 160,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey.shade200
//                   ),
//                   child: Center(child: Icon(Icons.add_a_photo,color: Colors.white,size: 30,)),
//                 ),
//               ),
//               TextField(
//                 controller: _titleController,
//                 decoration: InputDecoration(
//                   labelText: 'عنوان الخبر',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                 ),
//               ),
//               verticalSpace(20),
//               TextField(
//                 controller: _detailsController,
//                 maxLines: 4,
//                 decoration: InputDecoration(
//                   labelText: 'تفاصيل الخبر',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                 ),
//               ),
//               verticalSpace(20),
//               TextField(
//                 controller: _dateController,
//                 decoration: InputDecoration(
//                   labelText: 'تاريخ الخبر',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                 ),
//               ),
//               verticalSpace(30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Add news logic here
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorsManager.primary,
//                     padding: EdgeInsets.symmetric(vertical: 12.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                   ),
//                   child: Text(
//                     'إضافة الخبر',
//                     style: TextStyle(fontSize: 18.sp, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pioneer_project/helpers/spacing.dart';
import 'package:pioneer_project/screens/owner/owner_screen.dart';
import 'package:pioneer_project/theming/colors.dart';

import '../../../api/controller/news_api_controller.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  File? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  Future<void> _submit() async {
    String title = _titleController.text.trim();
    String details = _detailsController.text.trim();

    if (title.isEmpty || details.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى إدخال العنوان والتفاصيل')),
      );
      return;
    }

    bool success = await addNews(
      title: title,
      details: details,
      image: _pickedImage,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تمت إضافة الخبر بنجاح')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في إضافة الخبر')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (c){
              return OwnerDashboardScreen();
            }));
          }, icon:Icon(Icons.arrow_back)),
          backgroundColor: ColorsManager.primary,
          title: Text(
            'إضافة خبر جديد',
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
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
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.grey.shade600,
                      size: 40,
                    ),
                  )
                      : null,
                ),
              ),
              verticalSpace(20),
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
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'تفاصيل الخبر',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
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
