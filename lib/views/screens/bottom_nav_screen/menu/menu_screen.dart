import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erosta_loans/core/route/route.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/my_images.dart';
import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/data/controller/menu_/menu_controller.dart' as menu;
import 'package:erosta_loans/data/repo/auth/general_setting_repo.dart';
import 'package:erosta_loans/data/services/api_service.dart';
import 'package:erosta_loans/views/components/appbar/custom_appbar.dart';
import 'package:erosta_loans/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:erosta_loans/views/components/divider/custom_divider.dart';
import 'package:erosta_loans/views/components/will_pop_widget.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/menu/widget/delete_account_bottom_sheet.dart';

import '../../../../../data/controller/localization/localization_controller.dart';
import '../../../../core/utils/dimensions.dart';
import 'widget/menu_card.dart';
import 'widget/menu_row_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    final controller = Get.put(menu.MenuController(repo: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizationController) {
      return GetBuilder<menu.MenuController>(
          builder: (menuController) => WillPopWidget(
                nextRoute: RouteHelper.bottomNavScreen,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: MyColor.getScreenBgColor1(),
                    appBar: CustomAppBar(title: MyStrings.menu.tr, isShowBackBtn: false, isShowActionBtn: false, bgColor: MyColor.getAppbarBgColor()),
                    body: SingleChildScrollView(
                      padding: Dimensions.screenPaddingHV,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MenuCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MenuRowWidget(
                                  image: MyImages.profile,
                                  label: MyStrings.profile,
                                  onPressed: () => Get.toNamed(RouteHelper.profileScreen),
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  image: MyImages.changePass,
                                  label: MyStrings.changePassword.tr,
                                  onPressed: () => Get.toNamed(RouteHelper.changePasswordScreen),
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  image: MyImages.twoFa,
                                  label: MyStrings.twoFactorAuth,
                                  onPressed: () => Get.toNamed(RouteHelper.twoFactorSetupScreen),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: Dimensions.space12),
                          MenuCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MenuRowWidget(
                                  image: MyImages.notificationIcon,
                                  label: MyStrings.notification.tr,
                                  onPressed: () => Get.toNamed(RouteHelper.notificationScreen),
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                Visibility(
                                    visible: menuController.isDepositEnable,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MenuRowWidget(
                                          image: MyImages.deposit,
                                          label: MyStrings.deposit.tr,
                                          onPressed: () => Get.toNamed(RouteHelper.depositsScreen),
                                        ),
                                        const CustomDivider(space: Dimensions.space15),
                                      ],
                                    )),
                                Visibility(
                                    visible: menuController.isWithdrawEnable,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MenuRowWidget(
                                          image: MyImages.withdrawIcon,
                                          label: MyStrings.withdraw.tr,
                                          onPressed: () => Get.toNamed(RouteHelper.withdrawScreen),
                                        ),
                                        const CustomDivider(space: Dimensions.space15),
                                      ],
                                    )),
                                // MenuRowWidget(
                                //   image: MyIcons.sellIcon,
                                //   label: MyStrings.myLoan.tr,
                                //   onPressed: () {
                                //     Get.toNamed(RouteHelper.myloanScreen);
                                //   },
                                // ),
                                // const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  image: MyImages.transferIcon2,
                                  label: MyStrings.transactionHistory.tr,
                                  onPressed: () {
                                    Get.toNamed(RouteHelper.transactionScreen);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: Dimensions.space12),
                          MenuCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                    visible: menuController.langSwitchEnable,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MenuRowWidget(
                                          image: MyImages.language,
                                          label: MyStrings.language.tr,
                                          onPressed: () {
                                            // final apiClient = Get.put(ApiClient(sharedPreferences: Get.find()));
                                            // SharedPreferences pref = apiClient.sharedPreferences;
                                            // String language = pref.getString(SharedPreferenceHelper.languageListKey) ?? '';
                                            // String countryCode = pref.getString(SharedPreferenceHelper.countryCode) ?? 'US';
                                            // String languageCode = pref.getString(SharedPreferenceHelper.languageCode) ?? 'en';
                                            // Locale local = Locale(languageCode, countryCode);
                                            // showLanguageDialog(language, local, context);
                                            Get.toNamed(RouteHelper.languageScreen);
                                          },
                                        ),
                                      ],
                                    )),
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  image: MyImages.termsAndCon,
                                  label: MyStrings.terms.tr,
                                  onPressed: () {
                                    Get.toNamed(RouteHelper.privacyScreen);
                                  },
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  image: MyImages.faq,
                                  label: MyStrings.faq.tr,
                                  onPressed: () {
                                    Get.toNamed(RouteHelper.faqScreen);
                                  },
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  isLoading: menuController.logoutLoading,
                                  image: MyImages.signOut,
                                  label: MyStrings.signOut.tr,
                                  onPressed: () {
                                    menuController.logout();
                                  },
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                ColorFiltered(
                                  colorFilter: const ColorFilter.mode(MyColor.colorRed, BlendMode.srcIn),
                                  child: MenuRowWidget(
                                    image: MyImages.userdeleteImage,
                                    label: MyStrings.deleteAccount.tr,
                                    number: "5",
                                    onPressed: () {
                                      const CustomBottomSheet(
                                        isNeedMargin: true,
                                        child: DeleteAccountBottomsheetBody(),
                                      ).customBottomSheet(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
    });
  }
}
