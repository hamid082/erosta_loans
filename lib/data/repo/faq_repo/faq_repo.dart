import 'package:erosta_loans/core/utils/url.dart';
import 'package:erosta_loans/data/services/api_service.dart';

import '../../../core/utils/method.dart';

class FaqRepo {
  ApiClient apiClient;
  FaqRepo({required this.apiClient});

  Future<dynamic> loadFaq() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.faqEndPoint}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }
}
