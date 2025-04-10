import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/utils/style.dart';

class TitleLabel extends StatelessWidget {
  final String titleLabel;
  const TitleLabel({Key? key,required this.titleLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        titleLabel.tr,
        style: interSemiBoldDefault,
      ),
    );
  }
}
