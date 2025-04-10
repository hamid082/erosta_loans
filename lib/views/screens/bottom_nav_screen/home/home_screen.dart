// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/utils/dimensions.dart';
import 'package:rapid_loan/core/utils/my_color.dart';
import 'package:rapid_loan/data/controller/home/home_controller.dart';
import 'package:rapid_loan/data/controller/loan/loan_plan_controller.dart';
import 'package:rapid_loan/data/repo/home/home_repo.dart';
import 'package:rapid_loan/data/repo/loan/loan_repo.dart';
import 'package:rapid_loan/data/services/api_service.dart';

import 'package:rapid_loan/views/components/custom_loader.dart';
import 'package:rapid_loan/views/components/will_pop_widget.dart';
import 'package:rapid_loan/views/screens/bottom_nav_screen/home/widget/home_screen_items_section.dart';
import 'package:rapid_loan/views/screens/bottom_nav_screen/home/widget/home_screen_top.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoanRepo(apiClient: Get.find()));

    Get.put(HomeRepo(apiClient: Get.find()));
    final planController = Get.put(LoanPlanController(loanRepo: Get.find()));
    final controller = Get.put(HomeController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
      planController.loadLoanPlan();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.bgColor1,
            body: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              child: controller.isLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: CustomLoader(),
                    )
                  : Column(
                      children: const [
                        HomeScreenTop(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space14),
                          child: HomeScreenItemsSection(),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
