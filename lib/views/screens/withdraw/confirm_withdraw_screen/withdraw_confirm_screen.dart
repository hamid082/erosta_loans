import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erosta_loans/core/utils/dimensions.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/core/utils/util.dart';
import 'package:erosta_loans/data/controller/withdraw/add_new_withdraw_controller.dart';
import 'package:erosta_loans/data/model/dynamic_form/form.dart';

import 'package:erosta_loans/data/repo/account/profile_repo.dart';
import 'package:erosta_loans/data/services/api_service.dart';
import 'package:erosta_loans/views/components/appbar/custom_appbar.dart';
import 'package:erosta_loans/views/components/buttons/rounded_button.dart';
import 'package:erosta_loans/views/components/buttons/rounded_loading_button.dart';
import 'package:erosta_loans/views/components/checkbox/custom_check_box.dart';
import 'package:erosta_loans/views/components/custom_loader.dart';
import 'package:erosta_loans/views/components/custom_radio_button.dart';
import 'package:erosta_loans/views/components/row_item/form_row.dart';
import 'package:erosta_loans/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:erosta_loans/views/components/text-field/custom_text_field.dart';
import 'package:erosta_loans/views/components/text/label_text_with_instructions.dart';
import 'widget/choose_file_list_item.dart';

class WithdrawConfirmScreen extends StatefulWidget {
  const WithdrawConfirmScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawConfirmScreen> createState() => _WithdrawConfirmScreenState();
}

class _WithdrawConfirmScreenState extends State<WithdrawConfirmScreen> {
  @override
  void initState() {
    String trxId = Get.arguments;
    log(trxId);
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    Get.put(AddNewWithdrawController(
      repo: Get.find(),
      profileRepo: Get.find(),
    ));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // controller.trxId = trxId;
      // controller.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewWithdrawController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                  backgroundColor: MyColor.colorWhite,
                  appBar: CustomAppBar(title: MyStrings.withdrawConfirm),
                  body: controller.isLoading
                      ? const CustomLoader()
                      : SingleChildScrollView(
                          padding: Dimensions.previewPaddingHV,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius), border: Border.all(color: MyColor.borderColor, width: 1)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.formList.length,
                                    itemBuilder: (ctx, index) {
                                      log(controller.formList.length.toString());
                                      FormModel? model = controller.formList[index];
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (MyUtil.getInputType(model.type ?? "text")) ...[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CustomTextField(
                                                    hintText: (model.name ?? '').toLowerCase().capitalizeFirst,
                                                    animatedLabel: false,
                                                    needOutlineBorder: true,
                                                    labelText: model.name ?? '',
                                                    textInputType: MyUtil.getInputTextFieldType(model.type ?? "text"),
                                                    isRequired: model.isRequired == 'optional' ? false : true,
                                                    onChanged: (value) {
                                                      controller.changeSelectedValue(value, index);
                                                    }),
                                                const SizedBox(height: 10),
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
                                                        labelText: (model.name ?? '').tr,
                                                        isRequired: model.isRequired == 'optional' ? false : true,
                                                        hintText: '${((model.name ?? '').capitalizeFirst)?.tr}',
                                                        onChanged: (value) {
                                                          controller.changeSelectedValue(value, index);
                                                        }),
                                                    const SizedBox(height: 10),
                                                  ],
                                                )
                                              : model.type == 'select'
                                                  ? Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        LabelTextInstruction(
                                                          text: model.name ?? '',
                                                          isRequired: model.isRequired == 'optional' ? false : true,
                                                          instructions: model.instruction,
                                                        ),
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
                                                                LabelTextInstruction(
                                                                  text: model.name ?? '',
                                                                  isRequired: model.isRequired == 'optional' ? false : true,
                                                                  instructions: model.instruction,
                                                                ),
                                                                CustomCheckBox(
                                                                  selectedValue: controller.formList[index].cbSelected,
                                                                  list: model.options ?? [],
                                                                  onChanged: (value) {
                                                                    print("$index, $value");
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
                                                                        CustomTextField(
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
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      );
                                    }),
                                const SizedBox(height: Dimensions.space25),
                                controller.submitLoading
                                    ? const Center(child: RoundedLoadingBtn())
                                    : RoundedButton(
                                        color: MyColor.getButtonColor(),
                                        press: () {
                                          controller.submitConfirmWithdrawRequest();
                                        },
                                        text: MyStrings.submit.tr,
                                        textColor: MyColor.getButtonTextColor(),
                                      ),
                              ],
                            ),
                          ),
                        )),
            ));
  }
}
