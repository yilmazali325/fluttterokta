import 'package:flutter_bloc_login_example/model/User.dart';
import 'package:flutter_bloc_login_example/model/change_password_request.dart';
import 'package:flutter_bloc_login_example/model/change_password_request_password_model.dart';
import 'package:flutter_bloc_login_example/model/change_password_response.dart';
import 'package:flutter_bloc_login_example/model/create_user_request.dart';
import 'package:flutter_bloc_login_example/model/create_user_response.dart';
import 'package:flutter_bloc_login_example/model/credentials.dart';
import 'package:flutter_bloc_login_example/model/password.dart';
import 'package:flutter_bloc_login_example/model/profile.dart';
import 'package:flutter_bloc_login_example/model/reset_password_response.dart';
import 'package:flutter_bloc_login_example/model/token_response.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'ApiClient.dart';

class ApiAuth {
  final apiClient = ApiClient();
  Map<String, String> requestHeaders = {
    'Authorization': 'SSWS ',
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };
  Future login(String email, String password) async {
    //await getUserWithId("00u125ebtz29gWDQr0h8");
    //await changePassword("00u125ebtz29gWDQr0h8", "MArvel_2021", "Marvel_2021");
    //await deactivateUser("00u12amj0xpexfNJS0h8");
    //await deleteUser("00u1292pb44t5YnZU0h8");
    //First call to get session token
    User _user = await getSesionToken();
    //Get authCode to make the token
    String authCode = await getAuthCode(_user.sessionToken);
    //If you wanna reset the password
    //resetPassword(_user.id);
    TokenResponse tokenResponse = await getAccessToken(authCode);
    await call(tokenResponse.access_token);
    //return tokenResponse.access_token;
  }

  Future call(String accessToken) async {
    final Uri authnApi = Uri.parse('http://localhost:3000/users');
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var response;
    try {
      response = await apiClient.get(authnApi, headers: requestHeaders);
    } catch (e) {
      print(e);
    }
    print(response);
  }

  Future getSesionToken() async {
    //For more info https://developer.okta.com/docs/reference/api/authn/#primary-authentication
    final Uri authnApi = Uri.parse('https://idm-dev.assurant.com/api/v1/authn');
    Map<String, String> requestHeaders = {'Authorization': 'SSWS '};
    Map<String, String> authnBody = {
      "username": "VII__ali2@example.com",
      "password": "Marvel_2021"
    };
    final response = await apiClient.post(authnApi,
        body: json.encode(authnBody), headers: requestHeaders);
    print(response);
    Map<String, dynamic> apiResponse = json.decode(response.body);
    User _user = User.fromApiResponse(apiResponse);
    print(_user);
    return _user;
  }

  //prepare and make the second call to get auth code
  Future getAuthCode(String sessionToken) async {
    //For more info https://developer.okta.com/docs/guides/implement-grant-type/authcode/main/#flow-specifics
    final queryParametersForAuthCode = {
      'client_id': '0oa11uv99ebjYLb7Y0h8',
      'scope': 'openid profile email offline_access',
      'response_type': 'code',
      'redirect_uri': 'com.assurant.virtualinspection:/callback',
      'code_challenge_method': 'S256',
      'code_challenge': 'iIZuEd013SW0cTjqkIezs7cd8U3ntfZJCKBwgZr3mek',
      'state': 'ABC',
      'response_mode': 'form_post',
      'sessionToken': sessionToken
    };
    Map<String, String> requestHeaders = {'Authorization': 'SSWS '};
    final authCodeUri = Uri.https('idm-dev.assurant.com',
        '/oauth2/v1/authorize', queryParametersForAuthCode);
    final authTokenResponse =
        await apiClient.get(authCodeUri, headers: requestHeaders);
    print(authTokenResponse);

    //parse and get html response
    var document = parse(authTokenResponse.body);
    //get the form object
    var form = document.getElementsByTagName('form')[0];
    //the second children has authcode
    var child1 = form.children[1];
    // get the value
    String authCode = child1.attributes['value'];
    return authCode;
  }

  //prepare and make the third call to get the tokens
  Future getAccessToken(String authCode) async {
    //For more https://developer.okta.com/docs/guides/implement-oauth-for-okta-serviceapp/get-access-token/
    final Uri tokenApi =
        Uri.parse('https://idm-dev.assurant.com/oauth2/v1/token');
    Map<String, String> tokenBody = {
      'grant_type': 'authorization_code',
      'client_id': '0oa11uv99ebjYLb7Y0h8',
      'code': authCode,
      'redirect_uri': 'com.assurant.virtualinspection:/callback',
      'code_verifier':
          'OAZ7j3b1WjmB7JBes2iwvtKkSnf25kA0sQzDZVonj5mwzkBpH9r20MqWSVEiHxCdlNm5cFWghdX-EhFhTlCIFN7S',
    };
    var tokenCallResponse = await post(tokenApi, body: tokenBody);
    TokenResponse tokenResponse =
        TokenResponse.fromJson(json.decode(tokenCallResponse.body));

    return tokenResponse;
  }

  Future createUser() async {
    //For more info https://developer.okta.com/docs/reference/api/users/#create-user-with-password
    //Change the credentials next time
    Profile profile = Profile(
        firstName: "Ali",
        lastName: "Yilmaz",
        email: "VII__ali4@example.com",
        login: "VII__ali4@example.com",
        mobilePhone: "555-415-1337");
    List<String> groupIds = [];
    groupIds.add('00g11uv9hl1Yjs2Fr0h8');
    Password password = Password(value: "Marvel_2021");
    Credentials credentials = Credentials(password: password);
    CreateUserRequest createUserRequest = CreateUserRequest(
        profile: profile, groupIds: groupIds, credentials: credentials);
    final queryParametersForCreateUser = {
      'activate': 'true',
    };
    final createUserUri = Uri.https(
        'idm-dev.assurant.com', '/api/v1/users', queryParametersForCreateUser);
    var response = await post(createUserUri,
        body: json.encode(createUserRequest), headers: requestHeaders);

    print(response);
    CreateUserResponse createUserResponse =
        CreateUserResponse.fromJson(json.decode(response.body));
    return createUserResponse;
  }

  Future resetPassword(String userId) async {
    //it will return a url to reset pasword in the response when sendEmail = false
    //it will send a reset password link to user's email address when sendEmail = true
    //For more https://developer.okta.com/docs/reference/api/users/#reset-password
    final queryParametersForResetPassword = {
      'sendEmail': 'false',
    };
    final createResetPasswordUri = Uri.https(
        'idm-dev.assurant.com',
        '/api/v1/users/$userId/lifecycle/reset_password',
        queryParametersForResetPassword);

    var response;
    try {
      response = await post(createResetPasswordUri, headers: requestHeaders);
    } catch (e) {
      print(e);
    }
    print(response);
    ResetPasswordResponse resetPasswordResponse =
        ResetPasswordResponse.fromJson(json.decode(response.body));
    return resetPasswordResponse;
  }

  // It will return 204 when success
  Future deleteUser(String userId) async {
    //Sends a deactivation email to the administrator if sendEmail = true
    //For more details
    //https://developer.okta.com/docs/reference/api/users/#delete-user
    final queryParametersForDeleteUser = {
      'sendEmail': 'true',
    };

    final createResetPasswordUri = Uri.https('idm-dev.assurant.com',
        '/api/v1/users/$userId', queryParametersForDeleteUser);

    var response;
    try {
      response = await apiClient.delete(createResetPasswordUri,
          headers: requestHeaders);
    } catch (e) {
      print(e);
    }
    print(response);
  }

  Future activateUser(String userId) async {
    //Sends a link to the user to activate the account when sendemail = true
    //For more details
    //https://developer.okta.com/docs/reference/api/users/#delete-user
    final queryParametersForDeleteUser = {
      'sendEmail': 'false',
    };

    final activateAccountUri = Uri.https(
        'idm-dev.assurant.com',
        '/api/v1/users/$userId/lifecycle/activate',
        queryParametersForDeleteUser);

    var response;
    try {
      response =
          await apiClient.post(activateAccountUri, headers: requestHeaders);
    } catch (e) {
      print(e);
    }
    print(response);
  }

  Future deactivateUser(String userId) async {
    //Sends a link to the user to activate the account when sendemail = true
    //For more details
    //https://developer.okta.com/docs/reference/api/users/#delete-user
    final queryParametersForDeleteUser = {
      'sendEmail': 'false',
    };

    final activateAccountUri = Uri.https(
        'idm-dev.assurant.com',
        '/api/v1/users/$userId/lifecycle/deactivate',
        queryParametersForDeleteUser);

    var response;
    try {
      response =
          await apiClient.post(activateAccountUri, headers: requestHeaders);
    } catch (e) {
      print(e);
    }
    print(response);
  }

  Future changePassword(
      String userId, String oldPasswordStr, String newPasswordStr) async {
    //https://developer.okta.com/docs/reference/api/users/#change-password

    final changePasswordUri = Uri.https('idm-dev.assurant.com',
        '/api/v1/users/$userId/credentials/change_password');
    ChangePasswordRequestPasswordModel oldPassword =
        ChangePasswordRequestPasswordModel(value: oldPasswordStr);
    ChangePasswordRequestPasswordModel newPassword =
        ChangePasswordRequestPasswordModel(value: newPasswordStr);
    ChangePasswordRequest changePasswordRequest = ChangePasswordRequest(
        oldPassword: oldPassword, newPassword: newPassword);
    var response;
    try {
      response = await apiClient.post(changePasswordUri,
          body: json.encode(changePasswordRequest), headers: requestHeaders);
    } catch (e) {
      print(e);
    }
    ChangePasswordResponse changePasswordResponse =
        ChangePasswordResponse.fromJson(json.decode(response.body));
    print(response);
    return changePasswordResponse;
  }

  Future getUserWithId(String userId) async {
    final getUserUri =
        Uri.https('idm-dev.assurant.com', '/api/v1/users/$userId');

    var response;
    try {
      response = await apiClient.get(getUserUri, headers: requestHeaders);
    } catch (e) {
      print(e);
    }
    print(response);
    CreateUserResponse userDetails =
        CreateUserResponse.fromJson(json.decode(response.body));
    return userDetails;
  }

  Future getUserWithLogin(String email) async {
    final getUserUri =
        Uri.https('idm-dev.assurant.com', '/api/v1/users/$email');

    var response;
    try {
      response = await apiClient.get(getUserUri, headers: requestHeaders);
    } catch (e) {
      print(e);
    }
    CreateUserResponse userDetails =
        CreateUserResponse.fromJson(json.decode(response.body));
    print(response);
    return userDetails;
  }

  Future getUserWithShortName(String shortName) async {
    final getUserUri =
        Uri.https('idm-dev.assurant.com', '/api/v1/users/$shortName');

    var response;
    try {
      response = await apiClient.get(getUserUri, headers: requestHeaders);
    } catch (e) {
      print(e);
    }
    CreateUserResponse userDetails =
        CreateUserResponse.fromJson(json.decode(response.body));
    print(response);
    return userDetails;
  }

  // Future getAllUsers(int limit) async {
  //   final queryParametersGetAllUsers = {
  //     'limit': limit,
  //   };
  //   final getUsersUri = Uri.https(
  //       'idm-dev.assurant.com', '/api/v1/users', queryParametersGetAllUsers);

  //   var response;
  //   try {
  //     response = await apiClient.get(getUsersUri, headers: requestHeaders);
  //   } catch (e) {
  //     print(e);
  //   }

  //   print(response);
  //   return userDetails;
  // }

  Future logout() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future signUp() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future resendCode({email}) async {
    await Future.delayed(Duration(seconds: 2));
  }
}
