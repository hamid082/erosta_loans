import 'dart:convert';

import 'package:get/get.dart';
import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/data/model/about/privacy_response_model.dart';
import 'package:erosta_loans/data/model/global/response_model/response_model.dart';
import 'package:erosta_loans/data/repo/privacy_repo/privacy_repo.dart';
import 'package:erosta_loans/views/components/snackbar/show_custom_snackbar.dart';

class PrivacyController extends GetxController {
  int selectedIndex = 1;
  PrivacyRepo repo;
  bool isLoading = true;

  List<PolicyPages> policyList = [];
  late var selectedHtml = '';

  PrivacyController({required this.repo});

  void loadData() async {
    ResponseModel model = await repo.loadPrivacyAndPolicy();
    if (model.statusCode == 200) {
      PrivacyResponseModel responseModel =
          PrivacyResponseModel.fromJson(jsonDecode(model.responseJson));
      List<PolicyPages>? tempPolicyList = responseModel.data?.policyPages;
      if (tempPolicyList != null && tempPolicyList.isNotEmpty) {
        policyList.addAll(tempPolicyList);
        changeIndex(0);
        updateLoading(false);
      } else {
        CustomSnackBar.error(
            errorList:
                responseModel.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
      updateLoading(false);
    }
  }

  void changeIndex(int index) {
    selectedIndex = index;
    selectedHtml = policyList[index].dataValues?.content ?? '';
    update();
  }

  updateLoading(bool status) {
    isLoading = status;
    update();
  }
}
