import 'package:pioneer_project/models/news.dart';
import 'package:intl/intl.dart';

final List<News> news = [
  News(
    id: 1,
    title: 'أول خبر إخباري',
    details: 'هذا هو المحتوى التفصيلي لأول خبر إخباري في التطبيق. يحتوي على معلومات مهمة للمستخدمين.',
    image: 'assets/news/IMG_8661.JPG',
    newsDate: '22/02/2023',
    organizationId: 1,
    organization: Organization(
      id: 1,
      name: 'أنيرا',
      logo: 'assets/news/IMG_8661.JPG',
      description: 'منظمة أنيرا للمساعدات الإنسانية',
    ),
  ),
  News(
    id: 2,
    title: 'تحديثات جديدة',
    details: 'يحتوي هذا الخبر على آخر التحديثات والمستجدات في مجال العمل الإنساني.',
    image: 'assets/news/IMG_8663.JPG',
    newsDate: '22/02/2023',
    organizationId: 1,
    organization: Organization(
      id: 1,
      name: 'أنيرا',
      logo: 'assets/news/IMG_8664.JPG',
      description: 'منظمة أنيرا للمساعدات الإنسانية',
    ),
  ),
  News(
    id: 3,
    title: 'فعاليات قادمة',
    details: 'تعرف على الفعاليات والمؤتمرات القادمة التي ستنظمها المنظمة خلال الشهر الجاري.',
    image: 'assets/news/IMG_8665.assets/news/IMG_8663.JPG',
    newsDate: '22/02/2023',
    organizationId: 1,
    organization: Organization(
      id: 1,
      name: 'أنيرا',
      logo: 'assets/news/IMG_8664.JPG',
      description: 'منظمة أنيرا للمساعدات الإنسانية',
    ),
  ),
  News(
    id: 4,
    title: 'إنجازات المنظمة',
    details: 'تقرير مفصل عن إنجازات المنظمة خلال الربع الأول من العام الحالي.',
    image: 'assets/news/IMG_8665.JPG',
    newsDate: '22/02/2023',
    organizationId: 1,
    organization: Organization(
      id: 1,
      name: 'أنيرا',
      logo: 'assets/news/IMG_8665.JPG',
      description: 'منظمة أنيرا للمساعدات الإنسانية',
    ),
  ),
];