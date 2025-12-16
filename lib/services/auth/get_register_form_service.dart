import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/core/network/api_client.dart';
import 'package:flutter_application_1/models/form_data_model.dart';
import 'package:http/http.dart' as http;

class GetRegisterFormService extends BaseApiClient {
  Future<FormDataModel?> getFormData() async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${AppConfig.baseUrl}/form-data');

      print('🔗 Mengirim request ke: $uri');

      var response = await client
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw Exception('Request timeout - Backend tidak merespons'),
          );

      print('📊 Status Code: ${response.statusCode}');
      print('📝 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var json = response.body;
        return formDataFromJson(json);
      } else {
        throw Exception(
          'API Error: Status Code ${response.statusCode}\n'
          'Response: ${response.body}',
        );
      }
    } catch (e) {
      print('❌ Error: $e');
      rethrow;
    }
  }
}
