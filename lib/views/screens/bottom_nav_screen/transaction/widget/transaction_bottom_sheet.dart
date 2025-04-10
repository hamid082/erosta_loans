import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/helper/string_format_helper.dart';
import 'package:rapid_loan/core/utils/dimensions.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/data/controller/transaction/transaction_controller.dart';
import 'package:rapid_loan/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:rapid_loan/views/components/column/bottom_sheet_column.dart';
import 'package:rapid_loan/views/components/custom_container/bottom_sheet_container.dart';
import 'package:rapid_loan/views/components/row_item/bottom_sheet_top_row.dart';

class TransactionBottomSheet {
  static void transactionBottomSheet(BuildContext context, int index) {
    CustomBottomSheet(
      child: GetBuilder<TransactionController>(
          builder: (controller) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BottomSheetTopRow(header: MyStrings.transactionDetails),
                  BottomSheetContainer(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: BottomSheetColumn(
                                  header: MyStrings.charge,
                                  body:
                                      "${Converter.formatNumber(controller.transactionList[index].charge.toString())} ${controller.currency}")),
                          Expanded(
                              child: BottomSheetColumn(
                                  alignmentEnd: true,
                                  header: MyStrings.postBalance,
                                  body:
                                      '${Converter.formatNumber(controller.transactionList[index].postBalance ?? '')} ${controller.currency}')),
                        ],
                      ),
                      const SizedBox(height: Dimensions.space20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: BottomSheetColumn(
                            // alignmentEnd: true,
                            header: MyStrings.details,
                            body: controller.transactionList[index].details
                                .toString(),
                          )),
                        ],
                      ),
                      const SizedBox(height: Dimensions.space20),
                    ],
                  )),
                ],
              )),
    ).customBottomSheet(context);
  }
}
