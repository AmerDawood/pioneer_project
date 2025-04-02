import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/constants.dart';
import '../theming/colors.dart';
class CustomAppBarWidget extends StatelessWidget {

  final Icon? leadingIcon;
  final Icon? actionIcons;
  final Widget? titleWidget;

  const CustomAppBarWidget({
    Key? key, this.leadingIcon,  this.actionIcons, this.titleWidget

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.primary,
        leading:leadingIcon,
        title: titleWidget,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: actionIcons,
          ),
        ],
      ),
    );
  }
}
