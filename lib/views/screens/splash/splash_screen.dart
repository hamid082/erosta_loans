import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/theme/theme_util.dart';
import 'package:rapid_loan/core/utils/dimensions.dart';
import 'package:rapid_loan/core/utils/my_color.dart';
import 'package:rapid_loan/core/utils/my_images.dart';
import 'package:rapid_loan/data/controller/localization/localization_controller.dart';
import 'package:rapid_loan/data/controller/splash/splash_controller.dart';
import 'package:rapid_loan/data/repo/auth/general_setting_repo.dart';
import 'package:rapid_loan/data/services/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    ThemeUtil.makeSplashTheme();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(
        SplashController(repo: Get.find(), localizationController: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    ThemeUtil.allScreenTheme();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (controller) => Scaffold(
              backgroundColor: controller.noInternet
                  ? MyColor.colorWhite
                  : MyColor.primaryColor,
              body: Center(
                child: Image.asset(
                  MyImages.appLogoWhite,
                  height: Dimensions.appLogoHeight,
                  width: Dimensions.appLogoWidth
                ),
              ),
            ));
  }
}
