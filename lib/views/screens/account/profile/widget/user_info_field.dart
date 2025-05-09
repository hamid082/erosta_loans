import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:erosta_loans/core/utils/dimensions.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/style.dart';

class UserInfoField extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const UserInfoField(
      {Key? key, required this.icon, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('this icon$icon contains svg: ${icon.contains('svg')}');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: MyColor.getScreenBgColor(), shape: BoxShape.circle),
          child: icon.contains('svg')
              ? SvgPicture.asset(
                  icon,
                  height: 16,
                  width: 16,
                  color: MyColor.getPrimaryColor(),
                )
              : Image.asset(
                  icon,
                  color: MyColor.getPrimaryColor(),
                  height: 16,
                  width: 16,
                ),
        ),
        const SizedBox(width: Dimensions.space15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: interRegularSmall.copyWith(
                  color: MyColor.getLabelTextColor(),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: Dimensions.space5),
            Text(
              value,
              style:
                  interRegularDefault.copyWith(color: MyColor.getTextColor()),
            ),
          ],
        ),
      ],
    );
  }
}
