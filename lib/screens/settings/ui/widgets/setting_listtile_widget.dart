import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SettingListTileWidget extends StatelessWidget {
  final Icon leadingIcon;
  final Text title;
  final Function function;
  const SettingListTileWidget({

    super.key,
    required this.leadingIcon,
    required this.title,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> function(),
      child: Container(
        height: 50.h,
        child: ListTile(
          leading:leadingIcon,
          title: title,

          trailing: Icon(Icons.arrow_forward_ios_rounded,size: 17,),
        ),
      ),
    );
  }
}
