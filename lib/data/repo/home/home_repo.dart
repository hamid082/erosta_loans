import 'dart:convert';
import 'package:rapid_loan/core/utils/method.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/core/utils/url.dart';
import 'package:rapid_loan/data/model/general_setting/general_settings_response_model.dart';
import 'package:rapid_loan/data/model/global/response_model/response_model.dart';
import 'package:rapid_loan/data/services/api_service.dart';

class HomeRepo {
  ApiClient apiClient;

  HomeRepo({required this.apiClient});

  String token = '', tokenType = '';

  Future<ResponseModel> getData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.dashBoardEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> refreshGeneralSetting() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: false);

    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        apiClient.storeGeneralSetting(model);
      }
    }
  }
}
