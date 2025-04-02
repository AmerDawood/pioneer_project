
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/screens/onboarding/widgets/button_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../data/models/onboarding_model.dart';
import '../../theming/colors.dart';
import 'data/models/onboarding_model.dart';

List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    id: 0,
    title: 'اكتشف قوة العطاء',
    description: 'التطوع هو قوة التغيير الحقيقية. بعملنا المشترك وتكاتف جهودنا، نصنع أثرًا لا يُنسى ونرسم مستقبلًا مشرقًا للجميع.',
    imagePath: 'assets/onboarding/first_onboarding_image.svg',
  ),
  OnboardingItem(
    id: 1,
    title: 'معًا نصنع الفرق',
    description: 'ساهم في صناعة مستقبل أفضل لمجتمعك. التطوع هو فرصة لتترك أثرًا إيجابيًا في حياة الآخرين وتكون جزءًا من التغيير الذي تحتاجه مجتمعاتنا.',
    imagePath: 'assets/onboarding/second_onboarding_image.svg',
  ),
  OnboardingItem(
    id: 2,
    title: 'العطاء يجمعنا',
    description: 'عندما نجتمع على الخير، لا شيء مستحيل. معًا، نبني مجتمعات أقوى ونغرس قيم العطاء والتعاون لتبقى أثرًا يدوم..',
    imagePath: 'assets/onboarding/third_onboarding_image.svg',
  ),
  OnboardingItem(
    id: 3,
    title: 'العطاء يجمعنا',
    description: 'عندما نجتمع على الخير، لا شيء مستحيل. معًا، نبني مجتمعات أقوى ونغرس قيم العطاء والتعاون لتبقى أثرًا يدوم..',
    imagePath: 'assets/onboarding/forth_onboarding_image.svg',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      if (currentPageIndex == onboardingItems.length - 1) {
                        // If it's the last page, navigate to the next screen
                        Navigator.pushReplacementNamed(context, '/login');
                      } else {
                        // If it's NOT the last page, jump to the last page.
                        _pageController.animateToPage(onboardingItems.length-1, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      }
                    },
                    child:Text('تخطي',

                      style: GoogleFonts.josefinSans(
                        color: ColorsManager.secondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController, // Use the PageController
                    itemCount: onboardingItems.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentPageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = onboardingItems[index];
                      return Visibility(
                        visible: currentPageIndex == index, // Show content only for the current page
                        child: Column(

                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 84.h,),
                            Container(
                                height: 322.h,
                                child: SvgPicture.asset(item.imagePath, fit: BoxFit.fitWidth)),


                            currentPageIndex != 3 ?
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 32.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SmoothPageIndicator(
                                            controller: _pageController,
                                            count: onboardingItems.length,
                                            effect: WormEffect(
                                              dotWidth: 7.0.w,
                                              dotHeight: 7.0.h,
                                              spacing: 8.0.w,
                                              dotColor: ColorsManager.secondary,
                                              activeDotColor: ColorsManager.primary,
                                            ),

                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 32.h),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          item.title,
                                          style: GoogleFonts.josefinSans(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                            item.description,
                                            style: GoogleFonts.josefinSans(
                                              color: ColorsManager.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )

                            : Container(

                            ),




                            // Text(
                            //   item.description,
                            //   style: GoogleFonts.josefinSans(
                            //     color: ColorsManager.grey,
                            //     fontWeight: FontWeight.w500,
                            //     fontSize: 15.sp,
                            //   ),
                            //   // textAlign: TextAlign.center,
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentPageIndex > 0 && currentPageIndex != 3)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ButtonWidget(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              title: 'السابق',
                              color: ColorsManager.white,
                              borderColor: ColorsManager.primary,
                              labelColor: ColorsManager.primary,
                            ),
                          ),
                        ),

                      if (currentPageIndex < onboardingItems.length - 1) // Show 'التالي' only if it's not the last page
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ButtonWidget(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,

                                );
                              },
                              title: 'التالي',
                              color: ColorsManager.primary,
                              borderColor: ColorsManager.white,
                              labelColor: ColorsManager.white,
                            ),
                          ),
                        ),

                      // Show Login/Register buttons on the last page
                      if (currentPageIndex == onboardingItems.length - 1)
                        Column(
                          children: [
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushReplacementNamed(context, '/login');
                            //   },
                            //   child: const Text('تسجيل الدخول'), // Login button
                            // ),


                            ButtonWidget(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              title: 'تسجيل الدخول',


                              color: ColorsManager.secondary,
                              borderColor: ColorsManager.primary,
                              labelColor: Colors.white,
                            ),
                            SizedBox(height: 5.h), // Add spacing between buttons
                            ButtonWidget(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              title: 'التسجيل كأصحاب مبادرات',
                              color: ColorsManager.gray.withOpacity(0.7),
                              borderColor: ColorsManager.white,
                              labelColor: ColorsManager.white,
                            ),
                            SizedBox(height: 20.h), // Add spacing between buttons
                            ButtonWidget(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              title: 'التالي',
                              color: ColorsManager.primary,
                              borderColor: ColorsManager.white,
                              labelColor: ColorsManager.white,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),





              ],
            ),
          ),
        ),
      ),
    );
  }
}