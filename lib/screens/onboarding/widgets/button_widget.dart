import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color color ;
  final Color borderColor;
  final Color labelColor;

  const ButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    required this.color,
    required this.borderColor,
    required this.labelColor,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w, // Set the width
      height: 56.h, // Set the height// Set the position (top and left)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
        border: Border.all(
          color: borderColor,
        ),
        color: color,
        // gradient: LinearGradient(
        //   colors: [
        //     Color(0xFF174884), // #174884
        //     Color(0xFF141645), // #141645
        //   ],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
      ),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make button background transparent to show the gradient
          shadowColor: Colors.transparent, // Remove shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Border radius
          ),
        ),
        child: Text(title,

        style: TextStyle(
          color:labelColor,
        ),
        ),
      ),
    );
  }
}
