import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:erosta_loans/core/utils/dimensions.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/my_images.dart';
import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/core/utils/style.dart';
import 'package:erosta_loans/data/controller/auth/forget_password/verify_password_controller.dart';
import 'package:erosta_loans/data/repo/auth/login_repo.dart';
import 'package:erosta_loans/data/services/api_service.dart';
import 'package:erosta_loans/views/components/appbar/custom_appbar.dart';
import 'package:erosta_loans/views/components/buttons/rounded_button.dart';
import 'package:erosta_loans/views/components/buttons/rounded_loading_button.dart';
import 'package:erosta_loans/views/components/text/default_text.dart';

class VerifyForgetPassScreen extends StatefulWidget {
  const VerifyForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<VerifyForgetPassScreen> createState() => _VerifyForgetPassScreenState();
}

class _VerifyForgetPassScreenState extends State<VerifyForgetPassScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    final controller = Get.put(VerifyPasswordController(loginRepo: Get.find()));
    controller.email = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            fromAuth: true,
            isShowBackBtn: true,
            title: MyStrings.passVerification.tr,
          ),
          body: GetBuilder<VerifyPasswordController>(
              builder: (controller) => controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: MyColor.primaryColor))
                  : SingleChildScrollView(
                      padding: Dimensions.screenPaddingHV,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: Dimensions.space50),
                            Container(
                              height: 100,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: MyColor.primaryColor600,
                                  shape: BoxShape.circle),
                              child: SvgPicture.asset(MyImages.emailVerifyImage,
                                  height: 50,
                                  width: 50,
                                  color: MyColor.primaryColor),
                            ),
                            const SizedBox(height: Dimensions.space25),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * .1),
                              child: DefaultText(
                                  text:
                                      '${MyStrings.verifyPasswordSubText.tr} : ${controller.getFormatedMail().tr}',
                                  textAlign: TextAlign.center,
                                  textColor:
                                      MyColor.colorBlack.withOpacity(0.5)),
                            ),
                            const SizedBox(height: Dimensions.space40),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.space30),
                              child: PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: interRegularDefault.copyWith(
                                    color: MyColor.primaryColor),
                                length: 6,
                                textStyle: interRegularDefault.copyWith(
                                    color: MyColor.colorBlack),
                                obscureText: false,
                                obscuringCharacter: '*',
                                blinkWhenObscuring: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderWidth: 1,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 40,
                                    fieldWidth: 40,
                                    inactiveColor: MyColor.borderColor,
                                    inactiveFillColor: MyColor.transparentColor,
                                    activeFillColor: MyColor.transparentColor,
                                    activeColor: MyColor.primaryColor,
                                    selectedFillColor: MyColor.transparentColor,
                                    selectedColor: MyColor.primaryColor),
                                cursorColor: MyColor.colorBlack,
                                animationDuration:
                                    const Duration(milliseconds: 100),
                                enableActiveFill: true,
                                keyboardType: TextInputType.number,
                                beforeTextPaste: (text) {
                                  return true;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    controller.currentText = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: Dimensions.space25),
                            controller.verifyLoading
                                ? const RoundedLoadingBtn()
                                : RoundedButton(
                                    color: MyColor.primaryColor,
                                    textColor: MyColor.colorWhite,
                                    text: MyStrings.verify.tr,
                                    press: () {
                                      if (controller.currentText.length != 6) {
                                        controller.hasError = true;
                                      } else {
                                        controller.verifyForgetPasswordCode(
                                            controller.currentText);
                                      }
                                    }),
                            const SizedBox(height: Dimensions.space25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DefaultText(
                                    text: MyStrings.didNotReceiveCode.tr,
                                    textColor:
                                        MyColor.colorBlack.withOpacity(0.5)),
                                SizedBox(
                                    width: controller.isResendLoading
                                        ? Dimensions.space5
                                        : 0),
                                controller.isResendLoading
                                    ? const SizedBox(
                                        height: 17,
                                        width: 17,
                                        child: CircularProgressIndicator(
                                          color: MyColor.primaryColor,
                                        ))
                                    : TextButton(
                                        onPressed: () {
                                          controller.resendForgetPassCode();
                                        },
                                        child: DefaultText(
                                            text: MyStrings.resend.tr,
                                            textStyle: interSemiBold.copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: MyColor.primaryColor,
                                                fontSize:
                                                    Dimensions.fontDefault)),
                                      )
                              ],
                            )
                          ],
                        ),
                      )))),
    );
  }
}
