import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';
import '../../../theming/colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(Images.logo, height: 20),
              ),
            ),
          ),
          title: SvgPicture.asset(
            Images.logo,
            color: Colors.white,
            height: 35,
            width: 40,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.logo, height: 100),
                SizedBox(height: 20),
                Text(
                  'تم التسجيل بنجاح!',
                  style: TextStyle(
                    color: ColorsManager.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'لقد تم تقديم طلبك بنجاح للانضمام إلى المبادرة.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: Text('العودة إلى الصفحة الرئيسية',
                  style: TextStyle(
                    color: Colors.white
                  ),
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
