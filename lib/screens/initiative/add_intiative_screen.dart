// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../helpers/spacing.dart';
// import '../../../theming/colors.dart';
//
// class AddInitiativeScreen extends StatefulWidget {
//   const AddInitiativeScreen({super.key});
//
//   @override
//   _InitiativeScreenState createState() => _InitiativeScreenState();
// }
//
// class _InitiativeScreenState extends State<AddInitiativeScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _startDateController = TextEditingController();
//   final TextEditingController _endDateController = TextEditingController();
//   final TextEditingController _maxParticipantsController = TextEditingController();
//   final TextEditingController _detailsController = TextEditingController();
//   final TextEditingController _hoursController = TextEditingController();
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: ColorsManager.primary,
//           title: Text('إضافة مبادرة', style: TextStyle(color: Colors.white)),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   _buildTextField(_nameController, 'اسم المبادرة', Icons.title),
//                   _buildTextField(_locationController, 'الموقع', Icons.location_on),
//                   _buildDateField(_startDateController, 'تاريخ البدء'),
//                   _buildDateField(_endDateController, 'تاريخ الانتهاء'),
//                   _buildTextField(_maxParticipantsController, 'الحد الأقصى للمشاركين', Icons.group, isNumber: true),
//                   _buildTextField(_detailsController, 'التفاصيل', Icons.description, maxLines: 3),
//                   _buildTextField(_hoursController, 'عدد الساعات', Icons.access_time, isNumber: true),
//                   _buildImagePickerBox(),
//                   SizedBox(height: 20.h),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         // Handle form submission
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ColorsManager.primary,
//                       padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 40.w),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     child: Text('إضافة', style: TextStyle(color: Colors.white, fontSize: 18)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumber = false, int maxLines = 1}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'هذا الحقل مطلوب';
//           }
//           return null;
//         },
//       ),
//     );
//   }
//
//   Widget _buildDateField(TextEditingController controller, String label) {
//     return _buildTextField(controller, label, Icons.calendar_today);
//   }
//
//   Widget _buildImagePickerBox() {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         height: 150.h,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Icon(
//           Icons.add_a_photo,
//           size: 50,
//           color: Colors.grey.shade600,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../helpers/spacing.dart';
import '../../../theming/colors.dart';
import '../../api/controller/initiatives_api_controller.dart';
import '../owner/owner_screen.dart';

class AddInitiativeScreen extends StatefulWidget {
  const AddInitiativeScreen({super.key});

  @override
  _InitiativeScreenState createState() => _InitiativeScreenState();
}

class _InitiativeScreenState extends State<AddInitiativeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _maxParticipantsController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  String? imageUrl;

  // DateFormat for comparing and formatting dates
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (c){
            return OwnerDashboardScreen();
          }));
        }, icon:Icon(Icons.arrow_back)),
        backgroundColor: ColorsManager.primary,
        title: Text('إضافة مبادرة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_nameController, 'اسم المبادرة', Icons.title),
                _buildTextField(_locationController, 'الموقع', Icons.location_on),
                _buildDateField(_startDateController, 'تاريخ البدء'),
                _buildDateField(_endDateController, 'تاريخ الانتهاء'),
                _buildTextField(_maxParticipantsController, 'الحد الأقصى للمشاركين', Icons.group, isNumber: true),
                _buildTextField(_detailsController, 'التفاصيل', Icons.description, maxLines: 3),
                _buildTextField(_hoursController, 'عدد الساعات', Icons.access_time, isNumber: true),
                _buildImagePickerBox(),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitInitiative();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primary,
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 40.w),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('إضافة', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build text input fields
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          return null;
        },
      ),
    );
  }

  // Helper function to build date input fields
  Widget _buildDateField(TextEditingController controller, String label) {
    return GestureDetector(
      onTap: () => _selectDate(controller),  // Show date picker on tap
      child: _buildTextField(controller, label, Icons.calendar_today),
    );
  }

  // Function to handle date selection
  Future<void> _selectDate(TextEditingController controller) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),  // Earliest selectable date
      lastDate: DateTime(2101),   // Latest selectable date
    );

    if (pickedDate != null) {
      controller.text = _dateFormat.format(pickedDate);  // Format the selected date and set it in the controller
    }
  }

  // Widget for the image picker box
  Widget _buildImagePickerBox() {
    return GestureDetector(
      onTap: () async {
        // Implement image picker logic here
        // imageUrl = await selectImage();
      },
      child: Container(
        height: 150.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.add_a_photo,
          size: 50,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  // Function to handle form submission and call the API
  Future<void> _submitInitiative() async {
    // Parse the dates to DateTime objects
    try {
      final startDate = _dateFormat.parse(_startDateController.text);
      final endDate = _dateFormat.parse(_endDateController.text);

      // Compare the start and end dates
      if (startDate.isAfter(endDate)) {
        // Show error if the start date is after the end date
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تاريخ البدء يجب أن يكون بعد أو يساوي تاريخ الانتهاء')));
        return;
      }

      // If the date is valid, submit the initiative
      final success = await InitiativesApiController().submitInitiative(
        name: _nameController.text,
        location: _locationController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        maxParticipants: int.tryParse(_maxParticipantsController.text) ?? 0,
        details: _detailsController.text,
        hours: int.tryParse(_hoursController.text) ?? 0,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تمت إضافة المبادرة بنجاح')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل في الإضافة')));
      }
    } catch (e) {
      // Catch any error while parsing date
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('التاريخ غير صالح')));
    }

  }

}

