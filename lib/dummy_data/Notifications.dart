
import '../models/Notifications.dart';

List<NotificationModel> notifications = [
  NotificationModel(
    id: 1,
    title: 'إشعار جديد',
    message: 'تمت إضافة فرصة تطوعية جديدة',
    // volunteerHours: 10,

    isRead: false,
    createdAt: DateTime.now().subtract(Duration(minutes: 15)),
  ),
  NotificationModel(
    id: 2,
    title: 'تحديث المبادرات',
    message: 'تم تحديث حالة المبادرة التي انضممت إليها',
    // volunteerHours: 5,
    isRead: true,
    createdAt: DateTime.now().subtract(Duration(hours: 2)),
  ),
  NotificationModel(
    id: 3,
    title: 'تذكير',
    message: 'لا تنسَ حضور الحدث التطوعي القادم',
    // volunteerHours: 3,
    isRead: false,
    createdAt: DateTime.now().subtract(Duration(days: 1)),
  ),
  NotificationModel(
    id: 4,
    title: 'شهادة جديدة',
    message: 'حصلت على شهادة مشاركة في المبادرة',
    // volunteerHours: 20,
    isRead: true,
    createdAt: DateTime.now().subtract(Duration(days: 3)),
  ),
];
