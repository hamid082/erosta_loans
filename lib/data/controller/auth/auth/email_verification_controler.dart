import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/core/route/route.dart';
import 'package:rapid_loan/data/model/authorization/authorization_response_model.dart';
import 'package:rapid_loan/data/model/global/response_model/response_model.dart';
import 'package:rapid_loan/data/repo/auth/sms_email_verification_repo.dart';
import 'package:rapid_loan/views/components/snackbar/show_custom_snackbar.dart';

class EmailVerificationController extends GetxController {
  SmsEmailVerificationRepo repo;

  EmailVerificationController({required this.repo});

  String currentText = "";
  bool needTwoFactor = false;
  bool submitLoading = false;
  bool isLoading = true;
  bool resendLoading = false;

  loadData() async {
    isLoading = true;
    update();
    await repo.sendAuthorizationRequest();
    isLoading = false;
    update();
  }

  Future<void> verifyEmail(String text) async {
    if (text.isEmpty) {
      CustomSnackBar.error(
        errorList: [MyStrings.otpFieldEmptyMsg],
      );
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(text);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      bool isSMSVerificationEnable = model.data?.user?.sv == "0" ? true : false;
      bool is2FAEnable = model.data?.user?.tv == "0" ? true : false;

      if (model.status == MyStrings.success) {
        CustomSnackBar.success(successList: model.message?.success ?? [(MyStrings.emailVerificationSuccess)]);
        if (isSMSVerificationEnable) {
          Get.offAndToNamed(RouteHelper.smsVerificationScreen);
        } else if (is2FAEnable) {
          Get.offAndToNamed(RouteHelper.twoFactorScreen);
        } else {
          Get.offAndToNamed(RouteHelper.bottomNavScreen);
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [(MyStrings.emailVerificationFailed)]);
      }
    } else {
      CustomSnackBar.error(
        errorList: [responseModel.message],
      );
    }

    submitLoading = false;
    update();
  }

  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    await repo.resendVerifyCode(isEmail: true);
    resendLoading = false;
    update();
  }
}
