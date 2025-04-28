import 'package:get/get.dart';
import 'package:erosta_loans/core/route/route.dart';

class LoanController extends GetxController {
  bool isPlan = true;
  void changeTab(bool isPlan) {
    this.isPlan = isPlan;
    update();
  }

  String getPreviousRoute() {
    String previousRoute = Get.previousRoute;
    if (previousRoute == RouteHelper.notificationScreen) {
      return RouteHelper.notificationScreen;
    } else {
      return RouteHelper.bottomNavScreen;
    }
  }
}
