import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pioneer_project/screens/owner/owner_screen.dart';

import '../../api/controller/initiatives_api_controller.dart';
import '../../theming/colors.dart';
class AddInitiativeScreen extends StatefulWidget {
  const AddInitiativeScreen({super.key});

  @override
  _InitiativeScreenState createState() => _InitiativeScreenState();
}

class _InitiativeScreenState extends State<AddInitiativeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _maxParticipantsController = TextEditingController();
  final _detailsController = TextEditingController();
  final _hoursController = TextEditingController();
  final _dateFormat = DateFormat('yyyy-MM-dd');
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
              return OwnerDashboardScreen();
            }));
          },
        ),
        title: Text('إضافة مبادرة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
               Container(
                 decoration: BoxDecoration(
                   color: Colors.amber.shade100,
                 ),
                 child: ListTile(
                   leading: Icon(Icons.warning),
                   title: Text('يجب أن يكون تاريخ بدء المبادرة بعد تاريخ انتهاء التسجيل'),
                 ),
               ),
              SizedBox(height: 10,),
              _buildTextField(_nameController, 'اسم المبادرة', Icons.title),
              _buildTextField(_locationController, 'الموقع', Icons.location_on),
              _buildDateField(_endDateController, 'تاريخ انتهاء التسجيل'),
              _buildDateField(_startDateController, ' تاريخ بدء المبادرة'),
              _buildTextField(_maxParticipantsController, 'الحد الأقصى للمشاركين', Icons.group, isNumber: true),
              _buildTextField(_detailsController, 'التفاصيل', Icons.description, maxLines: 3),
              _buildTextField(_hoursController, 'عدد الساعات', Icons.access_time, isNumber: true),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator(color: ColorsManager.primary))
                  : ElevatedButton(
                onPressed: _submitInitiative,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('إضافة', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {bool isNumber = false, int maxLines = 1}) {
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
        validator: (value) => (value == null || value.isEmpty) ? 'هذا الحقل مطلوب' : null,
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String label) {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          controller.text = _dateFormat.format(picked);
        }
      },
      child: AbsorbPointer(
        child: _buildTextField(controller, label, Icons.calendar_today),
      ),
    );
  }

  Future<void> _submitInitiative() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final startDate = _dateFormat.parse(_startDateController.text);
      final endDate = _dateFormat.parse(_endDateController.text);

      // if (startDate.isAfter(endDate)) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('تاريخ البدء يجب أن يكون قبل أو يساوي تاريخ الانتهاء')),
      //   );
      //   return;
      // }

      setState(() => isLoading = true);

      final success = await InitiativesApiController().submitInitiative(
        name: _nameController.text.trim(),
        location: _locationController.text.trim(),
        startDate: _startDateController.text.trim(),
        endDate: _endDateController.text.trim(),
        maxParticipants: int.tryParse(_maxParticipantsController.text.trim()) ?? 0,
        details: _detailsController.text.trim(),
        hours: int.tryParse(_hoursController.text.trim()) ?? 0,
      );

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'تمت إضافة المبادرة بنجاح' : 'فشل في الإضافة'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );

      if (success) Navigator.push(context, MaterialPageRoute(builder: (c){
        return OwnerDashboardScreen();
      }));
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e'), backgroundColor: Colors.red),
      );
    }
  }
}
