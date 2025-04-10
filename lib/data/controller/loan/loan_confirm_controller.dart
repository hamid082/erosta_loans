import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/helper/date_converter.dart';
import 'package:rapid_loan/core/helper/string_format_helper.dart';
import 'package:rapid_loan/core/route/route.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/data/model/authorization/authorization_response_model.dart';
import 'package:rapid_loan/data/model/dynamic_form/form.dart';
import 'package:rapid_loan/data/model/global/response_model/response_model.dart';
import 'package:rapid_loan/data/model/loan/loan_preview_response_model.dart';
import 'package:rapid_loan/data/repo/loan/loan_repo.dart';
import 'package:rapid_loan/views/components/snackbar/show_custom_snackbar.dart';

class LoanConfirmController extends GetxController {
  LoanRepo repo;
  LoanConfirmController({required this.repo});

  bool isLoading = true;
  List<FormModel> formList = [];
  String selectOne = MyStrings.selectOne;
  String otpId = '';

  String planId = '';
  String amount = '';

  String planName = '';
  String totalInstallment = '';
  String perInstallment = '';
  String youNeedToPay = '';
  String chargeText = '';
  String applicationFee = '';

  String currencySymbol = '';
  loadData(LoanPreviewResponseModel model) async {
    currencySymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    setStatusTrue();
    planId = model.data?.plan?.id.toString() ?? '';
    amount = Converter.formatNumber(model.data?.amount ?? '');
    planName = model.data?.plan?.name ?? '';
    totalInstallment = model.data?.plan?.totalInstallment ?? '';
    perInstallment = model.data?.plan?.perInstallment ?? '';
    perInstallment = (((double.tryParse(amount) ?? 0) * (double.tryParse(perInstallment) ?? 0)) / 100).toString();
    youNeedToPay = Converter.mul(totalInstallment, perInstallment);
    String delayCharge = model.data?.delayCharge.toString() ?? '0';
    applicationFee = Converter.formatNumber(model.data?.applicationFee ?? '');
    chargeText = '${MyStrings.ifAnInstallmentIsDelayedFor} ${model.data?.plan?.delayValue} ${MyStrings.orMoreDaysThen} $currencySymbol$delayCharge ${MyStrings.willBeAppliedForEachDay}'.tr;

    List<FormModel>? tList = model.data?.plan?.form?.formData?.list;
    if (tList != null && tList.isNotEmpty) {
      formList.clear();
      for (var element in tList) {
        if (element.type == 'select') {
          bool? isEmpty = element.options?.isEmpty;
          bool empty = isEmpty ?? true;
          if (element.options != null && empty != true) {
            element.options?.insert(0, selectOne);
            element.selectedValue = element.options?.first;
            formList.add(element);
          }
        } else {
          formList.add(element);
        }
      }
    }
    setStatusFalse();
  }

  clearData() {
    formList.clear();
  }

  String twoFactorCode = '';
  bool submitLoading = false;
  Future<void> submitConfirmWithdrawRequest() async {
    isLoading = true;
    List<String> list = hasError();
    if (list.isNotEmpty) {
      CustomSnackBar.error(errorList: list);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel response = await repo.confirmLoanRequest(planId, amount, formList, twoFactorCode);
    if (response.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        Get.offAndToNamed(RouteHelper.bottomNavScreen, arguments: 'loan-list');
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.requestSuccess]);
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }

    submitLoading = false;
    isLoading = false;
    update();
  }

  List<String> hasError() {
    List<String> errorList = [];
    errorList.clear();
    for (var element in formList) {
      if (element.isRequired == 'required') {
        if (element.type == 'checkbox') {
          if (element.cbSelected == null) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        } else if (element.type == 'file') {
          if (element.file == null) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        } else {
          if (element.selectedValue == '' || element.selectedValue == selectOne) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }
      }
    }
    return errorList;
  }

  setStatusTrue() {
    isLoading = true;
    update();
  }

  setStatusFalse() {
    isLoading = false;
    update();
  }

  void changeSelectedValue(value, int index) {
    formList[index].selectedValue = value;
    update();
  }

  void changeSelectedRadioBtnValue(int listIndex, int selectedIndex) {
    formList[listIndex].selectedValue = formList[listIndex].options?[selectedIndex];
    update();
  }

  void changeSelectedCheckBoxValue(int listIndex, String value) {
    List<String> list = value.split('_');
    int index = int.parse(list[0]);
    bool status = list[1] == 'true' ? true : false;

    List<String>? selectedValue = formList[listIndex].cbSelected;

    if (selectedValue != null) {
      String? value = formList[listIndex].options?[index];
      if (status) {
        if (!selectedValue.contains(value)) {
          selectedValue.add(value!);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      } else {
        if (selectedValue.contains(value)) {
          selectedValue.removeWhere((element) => element == value);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      }
    } else {
      selectedValue = [];
      String? value = formList[listIndex].options?[index];
      if (status) {
        if (!selectedValue.contains(value)) {
          selectedValue.add(value!);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      } else {
        if (selectedValue.contains(value)) {
          selectedValue.removeWhere((element) => element == value);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      }
    }
  }

  //NEW DATE TIME
  void changeSelectedDateTimeValue(int index, BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        formList[index].selectedValue = DateConverter.estimatedDateTime(selectedDateTime);
        // formList[index].selectedValue = selectedDateTime.toIso8601String();
        formList[index].textEditingController?.text = DateConverter.estimatedDateTime(selectedDateTime);
        print(formList[index].textEditingController?.text);
        print(formList[index].selectedValue);
        update();
      }
    }

    update();
  }

  void changeSelectedDateOnlyValue(int index, BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final DateTime selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );

      formList[index].selectedValue = DateConverter.estimatedDate(selectedDateTime);
      formList[index].textEditingController?.text = DateConverter.estimatedDate(selectedDateTime);
      print(formList[index].textEditingController?.text);
      print(formList[index].selectedValue);
      update();
    }

    update();
  }

  void changeSelectedTimeOnlyValue(int index, BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final DateTime selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );

      formList[index].selectedValue = DateConverter.estimatedTime(selectedDateTime);
      formList[index].textEditingController?.text = DateConverter.estimatedTime(selectedDateTime);
      print(formList[index].textEditingController?.text);
      print(formList[index].selectedValue);
      update();
    }

    update();
  }

  void changeSelectedFile(File file, int index) {
    formList[index].file = file;
    update();
  }

  void pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx', 'csv', 'txt', 'docx', 'xls', 'xlsx']);

    if (result == null) return;

    formList[index].file = File(result.files.single.path!);
    String fileName = result.files.single.name;
    formList[index].selectedValue = fileName;
    update();
    return;
  }
}
