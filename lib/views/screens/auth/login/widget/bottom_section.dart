import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/core/route/route.dart';
import 'package:rapid_loan/core/utils/my_color.dart';
import 'package:rapid_loan/core/utils/style.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(MyStrings.doNotHaveAccount.tr, style: interRegularDefault),
        TextButton(
          onPressed: () {
            Get.offAndToNamed(RouteHelper.registrationScreen);
          },
          child: Text(
            MyStrings.signUpNow.tr,
            style: interRegularDefault.copyWith(
                color: MyColor.primaryColor,
                decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
