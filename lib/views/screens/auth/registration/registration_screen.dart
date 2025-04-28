import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erosta_loans/core/route/route.dart';
import 'package:erosta_loans/core/utils/dimensions.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/my_images.dart';
import 'package:erosta_loans/data/controller/auth/auth/registration_controller.dart';
import 'package:erosta_loans/data/repo/auth/general_setting_repo.dart';
import 'package:erosta_loans/data/repo/auth/signup_repo.dart';
import 'package:erosta_loans/data/services/api_service.dart';
import 'package:erosta_loans/views/components/appbar/custom_support_appbar.dart';
import 'package:erosta_loans/views/components/no_data/custom_nodata_noInternet.dart';
import 'package:erosta_loans/views/components/will_pop_widget.dart';
import 'package:erosta_loans/views/screens/auth/registration/widget/registration_form.dart';

import '../../../../core/utils/my_strings.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: GetBuilder<RegistrationController>(
            builder: (controller) => SafeArea(
              child: Scaffold(
                backgroundColor: MyColor.colorWhite,
                body: controller.noInternet
                    ? NoDataOrInternetScreen(
                        isNoInternet: true,
                        onChanged: (value) {
                          print(value.toString());
                          if (value) {
                            controller.initData();
                          }
                        },
                      )
                    : ListView(
                        children: [
                          CustomBackSupportAppBar(
                            press: () {
                              Get.find<RegistrationController>().clearAllData();
                              Get.offAndToNamed(RouteHelper.loginScreen);
                            },
                            title: MyStrings.signUp,
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                                  child: Center(
                                    child: Image.asset(MyImages.appLogo, height: Dimensions.appLogoHeight, fit: BoxFit.fill, width: Dimensions.appLogoWidth),
                                  ),
                                ),
                                const RegistrationForm(),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          )),
    );
  }
}
