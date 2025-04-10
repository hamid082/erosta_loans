import 'package:rapid_loan/core/utils/method.dart';
import 'package:rapid_loan/core/utils/url.dart';
import 'package:rapid_loan/data/model/global/response_model/response_model.dart';
import 'package:rapid_loan/data/services/api_service.dart';

class SocialLoginRepo {
  ApiClient apiClient;

  SocialLoginRepo({required this.apiClient});

  Future<ResponseModel> socialLoginUser({
    String accessToken = '',
    String? provider,
  }) async {
    Map<String, String>? map;

    if (provider == 'google') {
      map = {'token': accessToken, 'provider': "google"};
    }

    if (provider == 'linkedin') {
      map = {'token': accessToken, 'provider': "linkedin"};
    }

    if (provider == 'facebook') {
      map = {'token': accessToken, 'provider': "facebook"};
    }

    String url = '${UrlContainer.baseUrl}${UrlContainer.socialLoginEndPoint}';
    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: false);
    return model;
  }
}
