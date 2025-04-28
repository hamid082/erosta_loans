import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erosta_loans/core/helper/string_format_helper.dart';
import 'package:erosta_loans/core/utils/dimensions.dart';
import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/data/controller/loan/loan_plan_controller.dart';
import 'package:erosta_loans/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:erosta_loans/views/components/buttons/rounded_button.dart';
import 'package:erosta_loans/views/components/buttons/rounded_loading_button.dart';
import 'package:erosta_loans/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:erosta_loans/views/components/row_item/warning_row.dart';

import '../../../../../components/text-field/custom_amount_text_field.dart';

class ApplyLoanBottomSheet {
  void bottomSheet(BuildContext context, int index) {
    try {
      Get.find<LoanPlanController>().amountController.text = '';
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    CustomBottomSheet(
        child: GetBuilder<LoanPlanController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetTopRow(header: MyStrings.applyForLoan),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAmountTextField(
                    required: true,
                    controller: controller.amountController,
                    currency: controller.currency,
                    labelText: MyStrings.amount,
                    hintText: MyStrings.enterAmount,
                    onChanged: (value) {}),
                WarningRow(
                  text: '${MyStrings.limit.tr}: ${controller.currencySymbol}${Converter.formatNumber(controller.selectcatagori?.plans![index].minimumAmount ?? '0')} - ${controller.currencySymbol}${Converter.formatNumber(controller.selectcatagori?.plans![index].maximumAmount ?? '0')}',
                ),
                const SizedBox(height: Dimensions.space30),
                controller.submitLoading
                    ? const RoundedLoadingBtn()
                    : RoundedButton(
                        press: () {
                          String planId = controller
                                  .selectcatagori?.plans![index].id
                                  .toString() ??
                              "-1";
                          controller.submitLoanPlan(planId, index);
                        },
                        text: MyStrings.applyNow,
                      )
              ],
            ),
          )
        ],
      ),
    )).customBottomSheet(context);
  }
}
