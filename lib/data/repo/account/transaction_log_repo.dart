import 'dart:developer';

import 'package:rapid_loan/core/utils/method.dart';
import 'package:rapid_loan/core/utils/url.dart';
import 'package:rapid_loan/data/model/global/response_model/response_model.dart';
import 'package:rapid_loan/data/services/api_service.dart';

class TransactionRepo {
  ApiClient apiClient;
  TransactionRepo({required this.apiClient});

  Future<ResponseModel> getTransactionList(int page,
      {String type = "",
      String remark = "",
      String searchText = "",
      String walletType = ''}) async {
    if (type.toLowerCase() == "all" ||
        (type.toLowerCase() != 'plus' && type.toLowerCase() != 'minus')) {
      type = '';
    }
    if (remark.isEmpty || remark.toLowerCase() == "all") {
      remark = '';
    }
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.transactionEndpoint}?page=$page&type=$type&remark=$remark&search=$searchText';
    log(url);
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}
