import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erosta_loans/core/utils/dimensions.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/style.dart';

class LimitPreviewRow extends StatelessWidget {
  final String firstText, secondText;
  final bool showDivider;

  const LimitPreviewRow(
      {Key? key,
      required this.firstText,
      required this.secondText,
      this.showDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(firstText.tr,
                style: interSemiBold.copyWith(
                    fontSize: Dimensions.fontSmall12,
                    color: MyColor.getGreyText())),
            Text(secondText.tr,
                style: interSemiBold.copyWith(
                    fontSize: Dimensions.fontSmall,
                    color: MyColor.getGreyText1()))
          ],
        ),
        const SizedBox(height: 15),
        Visibility(
          visible: showDivider,
          child: Divider(
            height: .5,
            color: MyColor.getBorderColor(),
          ),
        ),
        Visibility(
          visible: showDivider,
          child: const SizedBox(height: 15),
        ),
      ],
    );
  }
}
