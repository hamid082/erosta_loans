import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/style.dart';
import 'package:erosta_loans/views/components/divider/custom_divider.dart';
import 'package:erosta_loans/views/components/status/status_widget.dart';

class CustomRow extends StatelessWidget {
  final String firstText, lastText;
  final bool isStatus, isAbout, showDivider;
  final Color? statusTextColor;
  final bool hasChild;
  final Widget? child;

  const CustomRow(
      {Key? key,
      this.child,
      this.hasChild = false,
      this.statusTextColor,
      required this.firstText,
      required this.lastText,
      this.isStatus = false,
      this.isAbout = false,
      this.showDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasChild
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    firstText.tr,
                    style: interRegularDefault.copyWith(
                        color: MyColor.getPrimaryTextColor()),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )),
                  child ?? const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              showDivider
                  ? const Divider(
                      color: MyColor.borderColor,
                    )
                  : const SizedBox(),
              showDivider
                  ? const SizedBox(
                      height: 5,
                    )
                  : const SizedBox(),
            ],
          )
        : isAbout
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(firstText.tr,
                      style: interRegularDefault.copyWith(
                          color: MyColor.getPrimaryTextColor())),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    lastText.tr,
                    style: interRegularDefault.copyWith(
                        color: isStatus
                            ? statusTextColor
                            : MyColor.getPrimaryTextColor()),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        firstText.tr,
                        style: interRegularDefault.copyWith(
                            color: MyColor.getPrimaryTextColor()),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                      isStatus
                          ? StatusWidget(status: lastText)
                          : Flexible(
                              child: Text(
                              lastText.tr,
                              maxLines: 2,
                              style: interRegularDefault.copyWith(
                                  color: isStatus
                                      ? MyColor.green
                                      : MyColor.getPrimaryTextColor()),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ))
                    ],
                  ),
                  const SizedBox(height: 5),
                  showDivider ? const CustomDivider() : const SizedBox(),
                  showDivider
                      ? const SizedBox(
                          height: 5,
                        )
                      : const SizedBox(),
                ],
              );
  }
}
