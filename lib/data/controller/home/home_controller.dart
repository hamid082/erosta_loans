import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:erosta_loans/core/helper/date_converter.dart';
import 'package:erosta_loans/core/helper/string_format_helper.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/data/model/dashboard/dashboard_response_model.dart';
import 'package:erosta_loans/data/model/global/response_model/response_model.dart';
import 'package:erosta_loans/data/model/loan/running_loan_response.dart';
import 'package:erosta_loans/data/repo/home/home_repo.dart';
import 'package:erosta_loans/views/components/snackbar/show_custom_snackbar.dart';

class HomeController extends GetxController {
  HomeRepo repo;
  // MyLoanController myLoanController;
  HomeController({
    required this.repo,
  });

  bool isLoading = true;
  String username = "";
  String email = "";
  String balance = "";
  String accountNumber = "";
  String accountName = "";
  String currency = "";
  String currencySymbol = "";
  String imagePath = "";
  //attention:  insights data only for Visor Loan
  String remainingLoanAmount = "";
  String runningLoan = "";
  String pendingLoan = "";
  String nextInstallmentAmount = "";
  String nextInstallmentDate = "";

  List<LatestDebitsData> debitsLists = [];
  // List<Widget> moduleList = [];
  List<RunningLoanModel> runningLoanList = [];

  bool isKycVerified = true;
  bool isKycPending = false;

  Future<void> loadData() async {
    // moduleList = repo.apiClient.getModuleList();
    currency = repo.apiClient.getCurrencyOrUsername();
    currencySymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);

    debitsLists.clear();

    ResponseModel responseModel = await repo.getData();
    if (responseModel.statusCode == 200) {
      DashboardResponseModel model = DashboardResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status.toString().toLowerCase() == 'success') {
        username = model.data?.user?.username ?? "";
        email = model.data?.user?.email ?? "";
        isKycVerified = model.data?.user?.kv == '1';
        isKycPending = model.data?.user?.kv == '2';
        imagePath = model.data?.user?.image ?? '';
        balance = Converter.formatNumber(model.data?.user?.balance ?? "");
        remainingLoanAmount = model.data?.insights?.nextInstallmentAmount.toString() ?? "0";
        runningLoan = model.data?.insights?.runningLoan ?? "_ _";
        pendingLoan = model.data?.insights?.pendingLoan ?? "_ _";
        nextInstallmentAmount = Converter.formatNumber(model.data?.insights?.nextInstallmentAmount ?? "_ _");
        nextInstallmentDate = DateConverter.isoStringToLocalDateOnly(model.data?.insights?.nextInstallmentDate ?? "_ _");

        List<RunningLoanModel>? temrunningLoan = model.data?.runningLoanList;
        runningLoanList.clear();
        if (temrunningLoan != null && temrunningLoan.isNotEmpty) {
          runningLoanList.addAll(temrunningLoan);
          log(runningLoanList.length.toString());
        } else {
          log("clearing runningLoan list");
        }
      } else {
        CustomSnackBar.error(
          errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
        );
      }
    } else {
      if (responseModel.statusCode == 503) {
        changeNoInternetStatus(true);
      }
      CustomSnackBar.error(
        errorList: [responseModel.message],
      );
    }

    isLoading = false;
    update();
    await repo.refreshGeneralSetting();
    update();
  }

  dynamic getStatusAndColor(int index, {isStatus = true}) {
    String status = runningLoanList[index].status ?? '';
    if (isStatus) {
      return status == '0'
          ? MyStrings.pending
          : status == '1'
              ? MyStrings.running
              : status == '2'
                  ? MyStrings.paid
                  : MyStrings.rejected;
    } else {
      return status == '0'
          ? MyColor.pendingColor
          : status == '1'
              ? MyColor.greenSuccessColor
              : status == '2'
                  ? MyColor.greenSuccessColor
                  : MyColor.redCancelTextColor;
    }
  }

  String getNeedToPayAmount(int index) {
    double totalInstallment = double.tryParse(runningLoanList[index].nextInstallment?.loan?.totalInstallment ?? '0') ?? 0;
    double perInstallment = double.tryParse(runningLoanList[index].perInstallment ?? '0') ?? 0;
    double needToPay = totalInstallment * perInstallment;
    return Converter.formatNumber(needToPay.toString());
  }

  bool noInternet = false;
  void changeNoInternetStatus(bool status) {
    noInternet = status;
    update();
  }
}
