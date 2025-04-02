
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pioneer_project/helpers/constants.dart';

import '../../helpers/spacing.dart';
import '../../theming/colors.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.primary,
          leading: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
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
                Icons.person_2_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back),
                    Text('Test Test'),
                    Icon(
                      Icons.abc_outlined,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SvgPicture.asset(
                    Images.logo,
                    height: 100,
                    width: 60,
                  ),
                ),
              ),
              Text(
                'Test Test Test ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Website'),
                        verticalSpace(10),
                        Text('www.nrc.com')
                      ],
                    ),
                    horizontalSpace(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Section'),
                        verticalSpace(10),
                        Text('WebsiteWebsiteWebsiteWebsite')
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Plase'),
                        verticalSpace(10),
                        Text('palestine/gaza')
                      ],
                    ),
                    horizontalSpace(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Size'),
                        verticalSpace(10),
                        Text('1000-5000')
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('type'),
                        verticalSpace(10),
                        Text('non price')
                      ],
                    ),
                    horizontalSpace(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('year'),
                        verticalSpace(10),
                        Text('1999 - 2005')
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'last of the averstment',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  )
                ],
              ),
              ListTile(
                title: Text(
                  'Test test',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                subtitle: Text('gaza-palestine'),
                trailing: Text(
                  '04 -Apr-2024',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Test test',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                subtitle: Text('gaza-palestine'),
                trailing: Text(
                  '04 -Apr-2024',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Test test',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                subtitle: Text('gaza-palestine'),
                trailing: Text(
                  '04 -Apr-2024',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
