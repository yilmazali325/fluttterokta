import "package:http/http.dart" as http;

class ApiClient extends http.BaseClient {
  http.Client _httpClient = new http.Client();

  ApiClient();

  // Request headers.
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(headers);
    return _httpClient.send(request);
  }

  Future<http.StreamedResponse> send2(
      http.BaseRequest request, Map<String, String> header) {
    request.headers.addAll(header);
    return _httpClient.send(request);
  }
}
