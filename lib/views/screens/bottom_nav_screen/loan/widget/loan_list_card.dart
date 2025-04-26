import 'package:flutter/material.dart';
import 'package:rapid_loan/core/helper/string_format_helper.dart';
import 'package:rapid_loan/core/utils/dimensions.dart';
import 'package:rapid_loan/core/utils/my_color.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/core/utils/style.dart';
import 'package:rapid_loan/core/utils/util.dart';
import 'package:rapid_loan/views/components/column/card_column.dart';
import 'package:rapid_loan/views/components/status/status_widget.dart';
import 'package:rapid_loan/views/components/widget-divider/widget_divider.dart';

class LoanListCard extends StatelessWidget {
  final String loanName;
  final String status;
  final String amount;
  final String loanNumber;
  final VoidCallback press;
  final String currency;
  final Color statusColor;

  const LoanListCard(
      {Key? key,
      required this.loanName,
      required this.status,
      required this.amount,
      required this.loanNumber,
      required this.press,
      required this.statusColor,
      required this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.space15),
        decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
            boxShadow: MyUtil.getCardShadow()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardColumn(
                  header: loanName,
                  headerTextDecoration: interSemiBoldDefault.copyWith(
                    color: MyColor.getGreyText1(),
                  ),
                  body: '',
                  isOnlyHeader: true,
                ),
                CardColumn(
                  alignmentEnd: true,
                  header: MyStrings.amount,
                  body: "${Converter.formatNumber(amount)} $currency",
                ),
              ],
            ),
            const WidgetDivider(space: Dimensions.space15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CardColumn(
                  header: MyStrings.loanNo,
                  body: loanNumber,
                ),
                StatusWidget(
                  needBorder: true,
                  status: status,
                  borderColor: statusColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
