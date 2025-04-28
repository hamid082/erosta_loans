import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:erosta_loans/core/route/route.dart';
import 'package:erosta_loans/core/utils/dimensions.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/my_images.dart';

import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/core/utils/style.dart';
import 'package:erosta_loans/core/utils/util.dart';
import 'package:erosta_loans/data/controller/auth/auth/social_login_controller.dart';

import 'package:erosta_loans/data/controller/auth/login_controller.dart';
import 'package:erosta_loans/data/repo/auth/login_repo.dart';
import 'package:erosta_loans/data/repo/auth/social_login_repo.dart';
import 'package:erosta_loans/data/services/api_service.dart';
import 'package:erosta_loans/views/components/buttons/rounded_button.dart';
import 'package:erosta_loans/views/components/buttons/rounded_loading_button.dart';

import 'package:erosta_loans/views/components/text-field/custom_text_form_field.dart';
import 'package:erosta_loans/views/components/will_pop_widget.dart';
import 'package:erosta_loans/views/screens/auth/login/widget/social_login_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool b = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    final controller = Get.put(LoginController(loginRepo: Get.find()));
    Get.put(SocialLoginRepo(apiClient: Get.find()));
    Get.put(SocialLoginController(repo: Get.find()));
//
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.remember = false;
    });
  }

  @override
  void dispose() {
    MyUtil.changeTheme();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: MyColor.colorWhite,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: MyColor.colorWhite,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: MyColor.backgroundColor,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.space40),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Center(
                              child: Image.asset(MyImages.appLogo, height: Dimensions.appLogoHeight, width: Dimensions.appLogoWidth),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .035,
                          ),
                          CustomTextFormField(
                            isUnderline: true,
                            hintText: MyStrings.enterEmailOrUserName,
                            isShowBorder: true,
                            isPassword: false,
                            isShowPrefixIcon: false,
                            controller: controller.emailController,
                            isShowSuffixIcon: false,
                            fillColor: MyColor.bgColor1,
                            label: MyStrings.enterEmailOrUserName,
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            focusNode: controller.emailFocusNode,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return MyStrings.enterEmailOrUserName.tr;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              return;
                            },
                            nextFocus: controller.passwordFocusNode,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            isShowBorder: true,
                            controller: controller.passwordController,
                            focusNode: controller.passwordFocusNode,
                            hintText: MyStrings.enterYourPassword_,
                            fillColor: MyColor.bgColor1,
                            isShowSuffixIcon: true,
                            label: MyStrings.password,
                            isUnderline: true,
                            isShowPrefixIcon: false,
                            isPassword: true,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.done,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return MyStrings.password.tr;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {},
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 23,
                                        height: 25,
                                        child: Checkbox(
                                            activeColor: MyColor.primaryColor,
                                            value: controller.remember,
                                            side: MaterialStateBorderSide.resolveWith(
                                              (states) => BorderSide(width: 1.0, color: controller.remember ? MyColor.transparentColor : MyColor.primaryColor),
                                            ),
                                            onChanged: (value) {
                                              controller.changeRememberMe();
                                            }),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Text(
                                          MyStrings.rememberMe.tr,
                                          style: interBoldDefault.copyWith(fontSize: Dimensions.fontDefault),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteHelper.forgetPasswordScreen);
                                    },
                                    child: Text(
                                      MyStrings.forgetPassword.tr,
                                      style: interRegularDefault.copyWith(color: MyColor.primaryColor, fontSize: Dimensions.fontDefault),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          controller.isSubmitLoading
                              ? const RoundedLoadingBtn()
                              : RoundedButton(
                                  press: () {
                                    if (formKey.currentState!.validate()) {
                                      controller.loginUser();
                                    }
                                  },
                                  text: MyStrings.login,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SocialLoginSection(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .15,
                          ),
                          Center(
                            child: Text(
                              MyStrings.doNotHaveAccount.tr,
                              style: mulishRegular.copyWith(fontSize: Dimensions.fontLarge),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                controller.clearData();
                                Get.offAndToNamed(RouteHelper.registrationScreen);
                              },
                              child: Text(
                                MyStrings.createNew.tr,
                                style: interRegularDefault.copyWith(fontSize: 18, color: MyColor.primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
