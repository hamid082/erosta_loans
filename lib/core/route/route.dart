import 'package:get/get.dart';
import 'package:erosta_loans/core/helper/shared_preference_helper.dart';
import 'package:erosta_loans/data/model/user/user.dart';
import 'package:erosta_loans/views/screens/all_loan/all_loan_screen.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:erosta_loans/views/screens/about/faq/faq_screen.dart';
import 'package:erosta_loans/views/screens/about/privacy/privacy_screen.dart';
import 'package:erosta_loans/views/screens/account/change-password/change_password_screen.dart';
import 'package:erosta_loans/views/screens/account/profile/my_profile_screen.dart';
import 'package:erosta_loans/views/screens/auth/email_verification_page/email_verification_screen.dart';
import 'package:erosta_loans/views/screens/auth/forget-password/forget_password_screen.dart';
import 'package:erosta_loans/views/screens/auth/kyc/kyc.dart';
import 'package:erosta_loans/views/screens/auth/login/login_screen.dart';
import 'package:erosta_loans/views/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:erosta_loans/views/screens/auth/registration/registration_screen.dart';
import 'package:erosta_loans/views/screens/auth/reset_password/reset_password_screen.dart';
import 'package:erosta_loans/views/screens/auth/sms_verification_page/sms_verification_screen.dart';
import 'package:erosta_loans/views/screens/auth/two_factor_screen/two_factor_verification_screen.dart';
import 'package:erosta_loans/views/screens/auth/verify_forget_password/verify_forget_password_screen.dart';
import 'package:erosta_loans/views/screens/deposits/deposit_webview/deposit_payment_webview.dart';
import 'package:erosta_loans/views/screens/deposits/deposits_screen.dart';
import 'package:erosta_loans/views/screens/deposits/new_deposit/new_deposit_screen.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/home/home_screen.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/loan/loan_confirm_screen/loan_confirm_screen.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/loan/loan_installment_log/loan_installment_log_screen.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/loan/loan_screen/loan_screen.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/loan/my_loan_screen/my_loan_screen.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/menu/menu_screen.dart';
import 'package:erosta_loans/views/screens/language/language_screen.dart';
import 'package:erosta_loans/views/screens/notification/notification_screen.dart';
import 'package:erosta_loans/views/screens/otp_screen/otp_screen.dart';
import 'package:erosta_loans/views/screens/splash/splash_screen.dart';
import 'package:erosta_loans/views/screens/bottom_nav_screen/transaction/transaction_screen.dart';
import 'package:erosta_loans/views/screens/two_factor/two_factor_setup_screen/two_factor_setup_screen.dart';
import 'package:erosta_loans/views/screens/withdraw/add_withdraw_screen/add_withdraw_method_screen.dart';
import 'package:erosta_loans/views/screens/withdraw/confirm_withdraw_screen/withdraw_confirm_screen.dart';
import 'package:erosta_loans/views/screens/withdraw/withdraw_history/withdraw_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../views/screens/account/edit_profile/edit_profile_screen.dart';

class RouteHelper {
  static const String bottomNavScreen = '/bottom_nav_screen';
  static const String splashScreen = "/splash";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String onBoardScreen = "/onboard";
  static const String loginScreen = "/login";
  static const String registrationScreen = "/registration";
  static const String homeScreen = "/home_screen";

  static const String emailVerificationScreen = '/verify_email';
  static const String smsVerificationScreen = '/verify_sms';
  static const String forgetPasswordScreen = '/forget_password';
  static const String verifyPassCodeScreen = '/verify_pass_code';
  static const String resetPasswordScreen = '/reset_pass';
  static const String twoFactorVerificationScreen = '/two_fa_screen';
  static const String privacyScreen = '/privacy_screen';
  static const String twoFactorScreen = "/two-factor-screen";

  //account
  static const String profileScreen = '/profile';
  static const String editProfileScreen = "/edit_profile";
  static const String profileCompleteScreen = '/profile_complete_screen';
  static const String changePasswordScreen = '/change_password';

  //notification
  static const String notificationScreen = '/notification_screen';
  static const String kycScreen = '/kyc_screen';
  static const String menuScreen = '/menu_screen';

  //refer screen
  static const String referralScreen = "/referral";

  //deposit
  static const String depositsScreen = "/deposits";
  static const String depositsDetailsScreen = "/deposits_details";
  static const String newDepositScreenScreen = "/deposits_money";
  static const String depositWebViewScreen = '/deposit_webView';

  //withdraw
  static const String withdrawScreen = "/withdraw";
  static const String addWithdrawMethodScreen = "/withdraw_method";
  static const String withdrawOtpScreen = "/withdraw_otp";
  static const String withdrawConfirmScreenScreen = "/withdraw_confirm_screen";
  static const String otpScreen = "/otp_screen";

  //load screen
  static const String loanScreen = "/loan_plan_screen";
  static const String allLoanPlanScreen = "/all_loan_plan_screen";
  static const String loanConfirmScreen = "/loan_confirm_screen";
  static const String applyLoanScreen = "/apply_loan";
  static const String loanInstallmentLogScreen = "/loan_installment_log_screen";
  static const String myLoanScreen = "/my_loan_screen";

  //transaction screen
  static const String transactionScreen = "/transaction";

  //privacy policy screen
  static const String termsServicesScreen = "/terms_services";
  static const String faqScreen = "/faq-screen";
  static const String twoFactorSetupScreen = "/two-factor-setup-screen";
  static const String languageScreen = "/languages_screen";

  static List<GetPage> routes = [
    GetPage(name: bottomNavScreen, page: () => const BottomNavBarScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: emailVerificationScreen, page: () => const EmailVerificationScreen()),
    GetPage(name: smsVerificationScreen, page: () => const SmsVerificationScreen()),
    GetPage(name: forgetPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: verifyPassCodeScreen, page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: profileCompleteScreen, page: () => const ProfileCompleteScreen()),
    GetPage(name: depositsScreen, page: () => const DepositsScreen()),
    GetPage(name: newDepositScreenScreen, page: () => const NewDepositScreen()),
    GetPage(name: withdrawScreen, page: () => const WithdrawScreen()),
    GetPage(name: addWithdrawMethodScreen, page: () => const AddWithdrawMethod()),
    GetPage(name: withdrawConfirmScreenScreen, page: () => const WithdrawConfirmScreen()),
    GetPage(name: allLoanPlanScreen, page: () => const AllLoanPlanScreen()),
    GetPage(name: loanScreen, page: () => const LoanScreen()),
    GetPage(name: loanConfirmScreen, page: () => const LoanConfirmScreen()),
    GetPage(name: loanInstallmentLogScreen, page: () => const LoanInstallmentLogScreen()),
    GetPage(name: myLoanScreen, page: () => const MyLoanScreen()),
    GetPage(name: transactionScreen, page: () => const TransactionScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: menuScreen, page: () => const MenuScreen()),
    GetPage(name: profileScreen, page: () => const MyProfileScreen()),
    GetPage(name: termsServicesScreen, page: () => const PrivacyScreen()),
    GetPage(name: notificationScreen, page: () => const NotificationScreen()),
    GetPage(name: depositWebViewScreen, page: () => WebViewExample(redirectUrl: Get.arguments)),
    GetPage(name: faqScreen, page: () => const FaqScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyScreen()),
    GetPage(name: kycScreen, page: () => const KycScreen()),
    GetPage(name: otpScreen, page: () => const OtpScreen()),
    GetPage(name: twoFactorSetupScreen, page: () => const TwoFactorSetupScreen()),
    GetPage(name: twoFactorScreen, page: () => const TwoFactorVerificationScreen()),
    GetPage(name: languageScreen, page: () => const LanguageScreen()),
    // GetPage(name: twoFactorVerificationScreen, page: () => TwoFactorVerificationScreen(isProfileCompleteEnable: Get.arguments)),
  ];

  static Future<void> checkUserStatusAndGoToNextStep(User? user, {bool isRemember = false, String accessToken = "", String tokenType = ""}) async {
    bool needEmailVerification = user?.ev == "1" ? false : true;
    bool needSmsVerification = user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = user?.tv == '1' ? false : true;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (isRemember) {
      await sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    }

    await sharedPreferences.setString(SharedPreferenceHelper.userIdKey, user?.id.toString() ?? '-1');
    await sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, user?.email ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, user?.mobile ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userNameKey, user?.username ?? '');

    if (accessToken.isNotEmpty) {
      await sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, accessToken ?? '');
      await sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, tokenType ?? '');
    }

    bool isProfileCompleteEnable = user?.profileComplete == '0' ? true : false;

    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(RouteHelper.twoFactorScreen);
    } else {
      Get.offAndToNamed(RouteHelper.bottomNavScreen, arguments: [true]);
    }
  }
}
