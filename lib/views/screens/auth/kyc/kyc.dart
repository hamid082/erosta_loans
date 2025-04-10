import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/utils/my_color.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/core/utils/util.dart';
import 'package:rapid_loan/views/components/appbar/custom_appbar.dart';
import 'package:rapid_loan/views/components/buttons/rounded_button.dart';
import 'package:rapid_loan/views/components/buttons/rounded_loading_button.dart';
import 'package:rapid_loan/views/components/checkbox/custom_check_box.dart';
import 'package:rapid_loan/views/components/custom_loader.dart';
import 'package:rapid_loan/views/components/custom_radio_button.dart';
import 'package:rapid_loan/views/components/no_data/no_data_found_screen.dart';
import 'package:rapid_loan/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:rapid_loan/views/components/text-field/custom_text_field.dart';
import 'package:rapid_loan/views/screens/withdraw/confirm_withdraw_screen/widget/choose_file_list_item.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../data/controller/kyc_controller/kyc_controller.dart';
import '../../../../data/model/kyc/kyc_response_model.dart';
import '../../../../data/repo/kyc/kyc_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/row_item/form_row.dart';
import 'widget/already_verifed.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({Key? key}) : super(key: key);

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(KycRepo(apiClient: Get.find()));
    Get.put(KycController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<KycController>().beforeInitLoadKycData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KycController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(title: MyStrings.kyc),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: controller.isLoading
              ? const Padding(padding: EdgeInsets.all(Dimensions.paddingSize15), child: CustomLoader())
              : controller.isAlreadyVerified
                  ? const AlreadyVerifiedWidget()
                  : controller.isAlreadyPending
                      ? const AlreadyVerifiedWidget(
                          isPending: true,
                        )
                      : controller.isNoDataFound
                          ? const NoDataFoundScreen()
                          : Center(
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColor.getScreenBgColor2(),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: controller.formList.length,
                                          itemBuilder: (ctx, index) {
                                            KycFormModel? model = controller.formList[index];
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
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: controller.submitLoading
                                            ? const RoundedLoadingBtn()
                                            : RoundedButton(
                                                press: () {
                                                  controller.submitKycData();
                                                },
                                                text: MyStrings.submit.tr,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
        ),
      ),
    );
  }
}
