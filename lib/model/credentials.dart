import 'package:flutter_bloc_login_example/model/password.dart';

class Credentials {
  Password password;

  Credentials({this.password});

  Credentials.fromJson(Map<String, dynamic> json) {
    password = json['password'] != null
        ? new Password.fromJson(json['password'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.password != null) {
      data['password'] = this.password.toJson();
    }
    return data;
  }
}
