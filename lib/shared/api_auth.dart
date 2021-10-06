import 'package:flutter_bloc_login_example/model/User.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'ApiClient.dart';

class ApiAuth {
  final apiClient = ApiClient();
  final Uri api = Uri.parse('https://dev-61149770.okta.com/api/v1/authn');
  Future login(String email, String password) async {
    String _token;
    Map<String, String> body = {"username": email, "password": password};
    final response = await apiClient.post(api, body: json.encode(body));
    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = json.decode(response.body);
      _token = apiResponse['sessionToken'];
      User _user = User.fromApiResponse(apiResponse);
      final queryParameters = {
        'client_id': '0oa23mblgfxUqsPnJ5d7',
        'scope': 'openid',
        'response_type': 'code',
        'redirect_uri': 'http://localhost:8080/login/callback',
        'code_challenge_method': 'S256',
        'code_challenge': 'iIZuEd013SW0cTjqkIezs7cd8U3ntfZJCKBwgZr3mek',
        'state': 'ABC',
      };
      final uri = Uri.https(
          'dev-68546164.okta.com', '/oauth2/v1/authorize', queryParameters);
      final request = new Request('GET', uri)..followRedirects = false;
      final authToken = await apiClient.send(request);
      final location = authToken.headers['location'];
      if (authToken.statusCode == 302) {
        print("302");
      } else if (authToken.statusCode == 200) {
        print("200");
      }
      //final location = authToken.headers;
      // Save values to local storage.
      // SharedPreferences storage = await SharedPreferences.getInstance();
      // await storage.setString('token', _token);
      // await storage.setString('user', json.encode(_user.toJson()));
      await Future.delayed(Duration(seconds: 1));
      return location;
    }
  }

  Future logout() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future changePassword() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future signUp() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future resendCode({email}) async {
    await Future.delayed(Duration(seconds: 2));
  }
}
