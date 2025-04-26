import 'package:flutter/material.dart';

import '../../../api/controller/notification_api_controller.dart';
import '../../../theming/colors.dart';
class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({super.key});

  @override
  State<AddNotificationScreen> createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إرسال إشعار'),
        backgroundColor: ColorsManager.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_userIdController, 'رقم المستخدم (user_id)', Icons.person),
              _buildTextField(_titleController, 'عنوان الإشعار', Icons.title),
              _buildTextField(_messageController, 'الرسالة', Icons.message, maxLines: 3),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _submitNotification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('إرسال', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
          return null;
        },
      ),
    );
  }

  Future<void> _submitNotification() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final success = await NotificationApiController().addNotification(
      userId: _userIdController.text.trim(),
      title: _titleController.text.trim(),
      message: _messageController.text.trim(),
    );

    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'تم إرسال الإشعار بنجاح' : 'فشل في إرسال الإشعار'),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );

    if (success) {
      _formKey.currentState!.reset();
      _userIdController.clear();
      _titleController.clear();
      _messageController.clear();
    }
  }
}
