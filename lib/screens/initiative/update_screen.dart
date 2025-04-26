import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../api/controller/initiatives_api_controller.dart';
import '../../theming/colors.dart';

class UpdateInitiativeScreen extends StatefulWidget {
  final int initiativeId;

  // تمرير بيانات المبادرة إن وُجدت لتعبئة الحقول تلقائيًا
  final String name;
  final String location;
  final String startDate;
  final String endDate;
  final int maxParticipants;
  final String details;
  final int hours;

  const UpdateInitiativeScreen({
    super.key,
    required this.initiativeId,
    required this.name,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.maxParticipants,
    required this.details,
    required this.hours,
  });

  @override
  State<UpdateInitiativeScreen> createState() => _UpdateInitiativeScreenState();
}

class _UpdateInitiativeScreenState extends State<UpdateInitiativeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _maxParticipantsController;
  late TextEditingController _detailsController;
  late TextEditingController _hoursController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _locationController = TextEditingController(text: widget.location);
    _startDateController = TextEditingController(text: widget.startDate);
    _endDateController = TextEditingController(text: widget.endDate);
    _maxParticipantsController = TextEditingController(text: widget.maxParticipants.toString());
    _detailsController = TextEditingController(text: widget.details);
    _hoursController = TextEditingController(text: widget.hours.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _maxParticipantsController.dispose();
    _detailsController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  Future<void> _updateInitiative() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final success = await InitiativesApiController().updateInitiative(
      id: widget.initiativeId,
      name: _nameController.text,
      location: _locationController.text,
      startDate: _startDateController.text,
      endDate: _endDateController.text,
      maxParticipants: int.tryParse(_maxParticipantsController.text) ?? 0,
      details: _detailsController.text,
      hours: int.tryParse(_hoursController.text) ?? 0,
    );

    setState(() => isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم تحديث المبادرة بنجاح')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل في التحديث')));
    }
  }



  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {int maxLines = 1, bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        validator: (value) => value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.tryParse(controller.text) ?? DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            controller.text = DateFormat('yyyy-MM-dd').format(picked);
          }
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.primary,
        title: Text('تحديث المبادرة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_nameController, 'اسم المبادرة', Icons.title),
              _buildTextField(_locationController, 'الموقع', Icons.location_on),
              _buildDateField(_startDateController, 'تاريخ البدء'),
              _buildDateField(_endDateController, 'تاريخ الانتهاء'),
              _buildTextField(_maxParticipantsController, 'الحد الأقصى للمشاركين', Icons.group, isNumber: true),
              _buildTextField(_detailsController, 'التفاصيل', Icons.description, maxLines: 3),
              _buildTextField(_hoursController, 'عدد الساعات', Icons.access_time, isNumber: true),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator(color: ColorsManager.primary))
                  : ElevatedButton(
                onPressed: _updateInitiative,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('تحديث', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
