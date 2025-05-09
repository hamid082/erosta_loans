import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erosta_loans/core/helper/date_converter.dart';
import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/core/utils/dimensions.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/data/controller/loan/loan_installment_log_controller.dart';
import 'package:erosta_loans/data/repo/loan/loan_repo.dart';
import 'package:erosta_loans/data/services/api_service.dart';
import 'package:erosta_loans/views/components/appbar/custom_appbar.dart';
import 'package:erosta_loans/views/components/custom_loader.dart';
import 'package:erosta_loans/views/components/no_data/no_data_found.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/loan/loan_installment_log/widget/installment_log_list_item.dart';

import 'widget/loan_installment_bottom_sheet.dart';

class LoanInstallmentLogScreen extends StatefulWidget {
  const LoanInstallmentLogScreen({Key? key}) : super(key: key);

  @override
  State<LoanInstallmentLogScreen> createState() =>
      _LoanInstallmentLogScreenState();
}

class _LoanInstallmentLogScreenState extends State<LoanInstallmentLogScreen> {
  final ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<LoanInstallmentLogController>().hasNext()) {
        Get.find<LoanInstallmentLogController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    String trxId = Get.arguments;
    log(trxId);
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoanRepo(apiClient: Get.find()));
    final controller =
        Get.put(LoanInstallmentLogController(loanRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loanId = trxId;
      controller.initialSelectedValue();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LoanInstallmentLogController>(
        builder: (controller) => Scaffold(
          backgroundColor: MyColor.getScreenBgColor1(),
          appBar: CustomAppBar(
            title: MyStrings.loanInstallment,
            isShowActionBtn: true,
            actionIcon: Icons.info_outline,
            actionText: MyStrings.loanInfo,
            action: [
              GestureDetector(
                onTap: () {
                  LoanInstallmentPreviewBottomSheet()
                      .bottomSheet(context);
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.only(
                      end: 7, bottom: 7, top: 7),
                  padding: const EdgeInsets.all(Dimensions.space7),
                  decoration: const BoxDecoration(
                      color: MyColor.colorWhite,
                      shape: BoxShape.circle),
                  child: const Icon(Icons.info_outline,
                      color: MyColor.primaryColor, size: 15),
                ),
              ),
            ],
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : controller.installmentLogList.isEmpty
                  ? const NoDataWidget()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(
                          Dimensions.screenPadding),
                      child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          itemCount:
                              controller.installmentLogList.length + 1,
                          separatorBuilder: (context, index) =>
                              const SizedBox(
                                  height: Dimensions.space10),
                          itemBuilder: (context, index) {
                            if (controller.installmentLogList.length ==
                                index) {
                              return controller.hasNext()
                                  ? const CustomLoader(
                                      isPagination: true)
                                  : const SizedBox.shrink();
                            }
                            return InstallmentLogItem(
                                serialNumber: '${index + 1}',
                                installmentDate: controller
                                        .installmentLogList[index]
                                        .installmentDate ??
                                    '',
                                giveOnDate: controller
                                        .installmentLogList[index]
                                        .givenAt ??
                                    '',
                                delay: DateConverter.delayDate(
                                    controller.installmentLogList[index]
                                        .installmentDate,
                                    controller.installmentLogList[index]
                                        .givenAt));
                          }),
                    ),
          )
      )
    );
  }
}
