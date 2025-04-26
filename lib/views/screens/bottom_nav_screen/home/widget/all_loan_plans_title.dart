import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/core/utils/style.dart';

class AllLoanPlanTitle extends StatelessWidget {
  const AllLoanPlanTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        MyStrings.loanPlan.tr,
        style: interSemiBoldDefault,
      ),
    );
  }
}
