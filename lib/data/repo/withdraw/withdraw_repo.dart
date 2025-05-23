import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:erosta_loans/core/utils/method.dart' as request;
import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/core/utils/url.dart';
import 'package:erosta_loans/data/model/authorization/authorization_response_model.dart';
import 'package:erosta_loans/data/model/dynamic_form/form.dart';
import 'package:erosta_loans/data/model/global/response_model/response_model.dart';
import 'package:erosta_loans/data/model/withdraw/withdraw_history_response_model.dart';
// import 'package:erosta_loans/data/model/withdraw/withdraw_preview_response_model.dart';
import 'package:erosta_loans/data/repo/kyc/kyc_repo.dart';
import 'package:erosta_loans/data/services/api_service.dart';
import 'package:erosta_loans/views/components/snackbar/show_custom_snackbar.dart';

class WithdrawRepo {
  ApiClient apiClient;

  WithdrawRepo({required this.apiClient});

  Future<dynamic> getAllWithdrawMethod() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.withdrawMethodUrl}';
    ResponseModel responseModel = await apiClient.request(url, request.Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic> getWithdrawConfirmScreenData(String trxId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.withdrawConfirmScreenUrl}$trxId';
    ResponseModel responseModel = await apiClient.request(url, request.Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic> addWithdrawRequest(int methodCode, double amount, String? authMode) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.addWithdrawRequestUrl}';
    Map<String, dynamic> params = {'method_code': methodCode.toString(), 'amount': amount.toString()};

    if (authMode != null && authMode.isNotEmpty && authMode.toLowerCase() != MyStrings.selectOne.toLowerCase()) {
      params['auth_mode'] = authMode.toLowerCase();
    }

    ResponseModel responseModel = await apiClient.request(url, request.Method.postMethod, params, passHeader: true);

    return responseModel;
  }

  List<Map<String, String>> fieldList = [];
  List<ModelDynamicValue> filesList = [];

  Future<dynamic> confirmWithdrawRequest(String trx, List<FormModel> list, String twoFactorCode) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.withdrawRequestConfirm}';
    log(trx);

    apiClient.initToken();
    await modelToMap(list);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> finalMap = {'trx': trx};

    for (var element in fieldList) {
      finalMap.addAll(element);
    }

    request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

    for (var file in filesList) {
      request.files.add(http.MultipartFile(file.key ?? '', file.value.readAsBytes().asStream(), file.value.lengthSync(), filename: file.value.path.split('/').last));
    }

    if (twoFactorCode.isNotEmpty) {
      request.fields.addAll({'authenticator_code': twoFactorCode});
    }

    request.fields.addAll(finalMap);

    http.StreamedResponse response = await request.send();
    String jsonResponse = await response.stream.bytesToString();
    AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

    return model;
  }

  Future<dynamic> getAllWithdrawHistory(int page, {String searchText = ""}) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.withdrawHistoryUrl}?page=$page&search=$searchText";
    ResponseModel responseModel = await apiClient.request(url, request.Method.getMethod, null, passHeader: true);

    if (responseModel.statusCode == 200) {
      WithdrawHistoryResponseModel model = WithdrawHistoryResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'success') {
        return model;
      } else {
        CustomSnackBar.error(
          errorList: model.message?.error ?? ['Something Wrong'],
        );
        return WithdrawHistoryResponseModel();
      }
    } else {
      return WithdrawHistoryResponseModel();
    }
  }

  Future<dynamic> modelToMap(List<FormModel> list) async {
    for (var e in list) {
      print(e.type);
      if (e.type == 'checkbox') {
        if (e.cbSelected != null && e.cbSelected!.isNotEmpty) {
          for (int i = 0; i < e.cbSelected!.length; i++) {
            fieldList.add({'${e.label}[$i]': e.cbSelected![i]});
          }
        }
      } else if (e.type == 'file') {
        if (e.file != null) {
          filesList.add(ModelDynamicValue(e.label, e.file!));
        }
      } else if (e.type == 'select') {
        if (e.selectedValue != null && e.selectedValue.toString() != MyStrings.selectOne) {
          fieldList.add({e.label ?? '': e.selectedValue});
        }
      } else {
        if (e.selectedValue != null && e.selectedValue.toString().isNotEmpty) {
          fieldList.add({e.label ?? '': e.selectedValue});
        }
      }
    }
  }
}
