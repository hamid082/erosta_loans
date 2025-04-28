import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erosta_loans/core/utils/dimensions.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/core/utils/style.dart';
import 'package:erosta_loans/core/utils/util.dart';
import 'package:erosta_loans/data/controller/loan/loan_confirm_controller.dart';
import 'package:erosta_loans/data/repo/loan/loan_repo.dart';
import 'package:erosta_loans/data/services/api_service.dart';
import 'package:erosta_loans/views/components/appbar/custom_appbar.dart';
import 'package:erosta_loans/views/components/buttons/rounded_button.dart';
import 'package:erosta_loans/views/components/buttons/rounded_loading_button.dart';
import 'package:erosta_loans/views/components/checkbox/custom_check_box.dart';
import 'package:erosta_loans/views/components/custom_loader.dart';
import 'package:erosta_loans/views/components/custom_radio_button.dart';
import 'package:erosta_loans/views/components/divider/custom_divider.dart';
import 'package:erosta_loans/views/components/row_item/form_row.dart';
import 'package:erosta_loans/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:erosta_loans/views/components/text-field/custom_text_field.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/loan/loan_confirm_screen/widget/preview_row.dart';

import 'package:erosta_loans/views/screens/withdraw/confirm_withdraw_screen/widget/choose_file_list_item.dart';

import '../../../../../data/model/dynamic_form/form.dart';
import '../../../../../data/model/loan/loan_preview_response_model.dart';

class LoanConfirmScreen extends StatefulWidget {
  const LoanConfirmScreen({Key? key}) : super(key: key);

  @override
  State<LoanConfirmScreen> createState() => _LoanConfirmScreenState();
}

class _LoanConfirmScreenState extends State<LoanConfirmScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoanRepo(apiClient: Get.find()));
    final controller = Get.put(LoanConfirmController(repo: Get.find()));
    LoanPreviewResponseModel model = Get.arguments;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LoanConfirmController>(
          builder: (controller) => Scaffold(
              backgroundColor: MyColor.getScreenBgColor1(),
              appBar: CustomAppBar(title: MyStrings.applyForLoan),
              body: controller.isLoading
                  ? const CustomLoader()
                  : SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: Dimensions.screenPaddingHV,
                        decoration: BoxDecoration(color: MyColor.getScreenBgColor2(), borderRadius: BorderRadius.circular(3), boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(2, 2), blurRadius: 2)]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: MyColor.borderColor, width: .5)),
                                    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Text(MyStrings.youAreApplyingToTakeLoan.tr, style: header),
                                      Text(
                                        '(${MyStrings.beSureBeforeConfirm.tr})',
                                        style: interRegularDefault.copyWith(color: MyColor.colorRed),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      PreviewRow(firstText: MyStrings.planName, secondText: controller.planName),
                                      PreviewRow(firstText: MyStrings.loanAmount, secondText: '${controller.currencySymbol}${controller.amount}'),
                                      PreviewRow(firstText: MyStrings.totalInstallment, secondText: controller.totalInstallment),
                                      PreviewRow(firstText: MyStrings.perInstallment, secondText: '${controller.currencySymbol}${controller.perInstallment}'),
                                      PreviewRow(
                                        firstText: MyStrings.youNeedToPay,
                                        secondText: '${controller.currencySymbol}${controller.youNeedToPay}',
                                      ),
                                      PreviewRow(
                                        firstText: MyStrings.applicationFee,
                                        secondText: '${controller.currencySymbol}${controller.applicationFee}',
                                        secondTextStyle: interSemiBold.copyWith(
                                          fontSize: Dimensions.fontSmall12,
                                          color: MyColor.redCancelTextColor,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '*${controller.chargeText}',
                                          style: interRegularDefault.copyWith(
                                            color: MyColor.redCancelTextColor,
                                          ),
                                        ),
                                      )
                                    ]))),
                            const SizedBox(
                              height: 20,
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: MyColor.borderColor, width: .5)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(MyStrings.applicationForm.tr, style: header),
                                    const CustomDivider(
                                      space: 15,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: controller.formList.length,
                                        itemBuilder: (ctx, index) {
                                          FormModel? model = controller.formList[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (MyUtil.getInputType(model.type ?? "text")) ...[
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CustomTextField(
                                                          hintText: (model.name ?? '').toLowerCase().capitalizeFirst,
                                                          animatedLabel: true,
                                                          needOutlineBorder: true,
                                                          labelText: model.name ?? '',
                                                          textInputType: MyUtil.getInputTextFieldType(model.type ?? "text"),
                                                          isRequired: model.isRequired == 'optional' ? false : true,
                                                          onChanged: (value) {
                                                            controller.changeSelectedValue(value, index);
                                                          }),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                model.type == 'textarea'
                                                    ? Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          CustomTextField(
                                                              animatedLabel: true,
                                                              needOutlineBorder: true,
                                                              labelText: model.name ?? '',
                                                              isRequired: model.isRequired == 'optional' ? false : true,
                                                              hintText: (model.name ?? '').capitalizeFirst,
                                                              onChanged: (value) {
                                                                controller.changeSelectedValue(value, index);
                                                              }),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      )
                                                    : model.type == 'select'
                                                        ? Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              FormRow(label: model.name ?? '', isRequired: model.isRequired == 'optional' ? false : true),
                                                              CustomDropDownTextField(
                                                                list: model.options ?? [],
                                                                onChanged: (value) {
                                                                  controller.changeSelectedValue(value, index);
                                                                },
                                                                selectedValue: model.selectedValue,
                                                              ),
                                                            ],
                                                          )
                                                        : model.type == 'radio'
                                                            ? Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  FormRow(label: model.name ?? '', isRequired: model.isRequired == 'optional' ? false : true),
                                                                  CustomRadioButton(
                                                                    title: model.name,
                                                                    selectedIndex: controller.formList[index].options?.indexOf(model.selectedValue ?? '') ?? 0,
                                                                    list: model.options ?? [],
                                                                    onChanged: (selectedIndex) {
                                                                      controller.changeSelectedRadioBtnValue(index, selectedIndex);
                                                                    },
                                                                  ),
                                                                ],
                                                              )
                                                            : model.type == 'checkbox'
                                                                ? Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      FormRow(label: model.name ?? '', isRequired: model.isRequired == 'optional' ? false : true),
                                                                      CustomCheckBox(
                                                                        selectedValue: controller.formList[index].cbSelected,
                                                                        list: model.options ?? [],
                                                                        onChanged: (value) {
                                                                          controller.changeSelectedCheckBoxValue(index, value);
                                                                        },
                                                                      ),
                                                                    ],
                                                                  )
                                                                : model.type == 'file'
                                                                    ? Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          FormRow(label: model.name ?? '', isRequired: model.isRequired == 'optional' ? false : true),
                                                                          Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                                                              child: SizedBox(
                                                                                child: InkWell(
                                                                                    onTap: () {
                                                                                      controller.pickFile(index);
                                                                                    },
                                                                                    child: ChooseFileItem(
                                                                                      fileName: model.selectedValue ?? MyStrings.chooseFile.tr,
                                                                                    )),
                                                                              ))
                                                                        ],
                                                                      )
                                                                    : model.type == 'datetime'
                                                                        ? Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                                                                child: CustomTextField(
                                                                                    instructions: model.extensions,
                                                                                    isRequired: model.isRequired == 'optional' ? false : true,
                                                                                    hintText: (model.name ?? '').toString().capitalizeFirst,
                                                                                    needOutlineBorder: true,
                                                                                    labelText: model.name ?? '',
                                                                                    controller: controller.formList[index].textEditingController,
                                                                                    // initialValue: controller.formList[index].selectedValue == "" ? (model.name ?? '').toString().capitalizeFirst : controller.formList[index].selectedValue,
                                                                                    textInputType: TextInputType.datetime,
                                                                                    readOnly: true,
                                                                                    validator: (value) {
                                                                                      if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                                                                        return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                                                                      } else {
                                                                                        return null;
                                                                                      }
                                                                                    },
                                                                                    onTap: () {
                                                                                      print(model.isRequired);

                                                                                      controller.changeSelectedDateTimeValue(index, context);
                                                                                    },
                                                                                    onChanged: (value) {
                                                                                      print(value);
                                                                                      controller.changeSelectedValue(value, index);
                                                                                    }),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : model.type == 'date'
                                                                            ? Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                                                                    child: CustomTextField(
                                                                                        instructions: model.instruction,
                                                                                        isRequired: model.isRequired == 'optional' ? false : true,
                                                                                        hintText: (model.name ?? '').toString().capitalizeFirst,
                                                                                        needOutlineBorder: true,
                                                                                        labelText: model.name ?? '',
                                                                                        controller: controller.formList[index].textEditingController,
                                                                                        // initialValue: controller.formList[index].selectedValue == "" ? (model.name ?? '').toString().capitalizeFirst : controller.formList[index].selectedValue,
                                                                                        textInputType: TextInputType.datetime,
                                                                                        readOnly: true,
                                                                                        validator: (value) {
                                                                                          print(model.isRequired);
                                                                                          if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                                                                            return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                                                                          } else {
                                                                                            return null;
                                                                                          }
                                                                                        },
                                                                                        onTap: () {
                                                                                          controller.changeSelectedDateOnlyValue(index, context);
                                                                                        },
                                                                                        onChanged: (value) {
                                                                                          print(value);
                                                                                          controller.changeSelectedValue(value, index);
                                                                                        }),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : model.type == 'time'
                                                                                ? Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                                                                        child: CustomTextField(
                                                                                            instructions: model.instruction,
                                                                                            isRequired: model.isRequired == 'optional' ? false : true,
                                                                                            hintText: (model.name ?? '').toString().capitalizeFirst,
                                                                                            needOutlineBorder: true,
                                                                                            labelText: model.name ?? '',
                                                                                            controller: controller.formList[index].textEditingController,
                                                                                            // initialValue: controller.formList[index].selectedValue == "" ? (model.name ?? '').toString().capitalizeFirst : controller.formList[index].selectedValue,
                                                                                            textInputType: TextInputType.datetime,
                                                                                            readOnly: true,
                                                                                            validator: (value) {
                                                                                              print(model.isRequired);
                                                                                              if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                                                                                return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                                                                              } else {
                                                                                                return null;
                                                                                              }
                                                                                            },
                                                                                            onTap: () {
                                                                                              controller.changeSelectedTimeOnlyValue(index, context);
                                                                                            },
                                                                                            onChanged: (value) {
                                                                                              print(value);
                                                                                              controller.changeSelectedValue(value, index);
                                                                                            }),
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : const SizedBox(),
                                                const SizedBox(height: 5),
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.space25),
                            controller.submitLoading
                                ? const Center(child: RoundedLoadingBtn())
                                : Center(
                                    child: RoundedButton(
                                      color: MyColor.getButtonColor(),
                                      press: () {
                                        controller.submitConfirmWithdrawRequest();
                                      },
                                      text: MyStrings.submit.tr,
                                      textColor: MyColor.getButtonTextColor(),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ))),
    );
  }
}
