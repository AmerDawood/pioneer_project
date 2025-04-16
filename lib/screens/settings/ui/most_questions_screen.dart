import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/spacing.dart';
import '../../../theming/colors.dart';
class MostQuestionsScreen extends StatefulWidget {
  const MostQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<MostQuestionsScreen> createState() => _MostQuestionsScreenState();
}

class _MostQuestionsScreenState extends State<MostQuestionsScreen> {
  List<bool> _isExpandedList = List.generate(5, (_) => false); // 5 أسئلة

  final List<String> questions = [
    'ما هي فكرة عمل التطبيق؟',
    'كيف أستطيع التسجيل؟',
    'هل التطبيق مجاني؟',
    'كيف أقدم مبادرة؟',
    'هل يمكن التواصل مع الدعم؟',
  ];

  final List<String> answers = [
    'أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف.',
    'قم بالضغط على زر التسجيل واملأ البيانات المطلوبة.',
    'نعم، التطبيق مجاني بالكامل.',
    'من خلال قسم المبادرات داخل التطبيق.',
    'نعم، من خلال صفحة "اتصل بنا".',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          title: Text("الأسئلة الشائعة", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpandedList[index] = !_isExpandedList[index];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        width: 1.5,
                        color: ColorsManager.primary,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                questions[index],
                                style: GoogleFonts.cairo(
                                  color: ColorsManager.primary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                _isExpandedList[index]
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down_rounded,
                              ),
                            ],
                          ),
                          if (_isExpandedList[index]) ...[
                            verticalSpace(10),
                            Text(
                              answers[index],
                              style: GoogleFonts.cairo(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
