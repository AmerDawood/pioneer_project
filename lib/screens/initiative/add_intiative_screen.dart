import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../helpers/spacing.dart';
import '../../../theming/colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
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
                        // Handle form submission
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
      ),
    );
  }

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

  Widget _buildDateField(TextEditingController controller, String label) {
    return _buildTextField(controller, label, Icons.calendar_today);
  }

  Widget _buildImagePickerBox() {
    return GestureDetector(
      onTap: () {},
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
}
