import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/style.dart';

class NavBarItem extends StatelessWidget {
  final String imagePath;
  final int index;
  final String label;
  final VoidCallback press;
  final bool isSelected;

  const NavBarItem(
      {Key? key,
      required this.imagePath,
      required this.index,
      required this.label,
      required this.isSelected,
      required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(Dimensions.space10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isSelected
                    ? MyColor.primaryColor
                    : Colors.grey.withOpacity(0.2),
                shape: BoxShape.circle),
            child: imagePath.contains('svg')
                ? SvgPicture.asset(
                    imagePath,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? MyColor.colorWhite
                          : MyColor.getUnselectedIconColor(),
                      BlendMode.srcIn,
                    ),
                    width: 16,
                    height: 16,
                  )
                : Image.asset(
                    imagePath,
                    color: isSelected
                        ? MyColor.colorWhite
                        : MyColor.getUnselectedIconColor(),
                    width: 16,
                    height: 16,
                  ),
          ),
          const SizedBox(height: Dimensions.space10 / 2),
          Text(label.tr,
              textAlign: TextAlign.center,
              style: interRegularSmall.copyWith(
                  color: isSelected
                      ? MyColor.primaryColor
                      : MyColor.getPrimaryTextColor()))
        ],
      ),
    );
  }
}
