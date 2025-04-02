import 'package:flutter/cupertino.dart';

import '../../../../../theming/styles.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'هل نسيت كلمة المرور ؟',
            style: TextStyles.font12BlueRegular,
          )
        ],
      ),
    );
  }
}
