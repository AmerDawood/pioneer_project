
import 'package:pioneer_project/models/Notifications.dart';

List<NotificationModel> notifications = [
  NotificationModel(
    title: 'إشعار جديد',
    subtitle: 'تمت إضافة فرصة تطوعية جديدة',
    volunteerHours: '10 ساعات',
    icon: 'assets/icons/volunteer.svg',
  ),
  NotificationModel(
    title: 'تحديث المبادرات',
    subtitle: 'تم تحديث حالة المبادرة التي انضممت إليها',
    volunteerHours: '5 ساعات',
    icon: 'assets/icons/update.svg',
  ),
  NotificationModel(
    title: 'تذكير',
    subtitle: 'لا تنسَ حضور الحدث التطوعي القادم',
    volunteerHours: '3 ساعات',
    icon: 'assets/icons/reminder.svg',
  ),
  NotificationModel(
    title: 'شهادة جديدة',
    subtitle: 'حصلت على شهادة مشاركة في المبادرة',
    volunteerHours: '20 ساعات',
    icon: 'assets/icons/certificate.svg',
  ),
];