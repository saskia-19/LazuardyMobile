class BaseApiClient {
  Future<Map<String, String>> getHeaders({String? token}) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }
}
