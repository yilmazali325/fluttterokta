import 'package:flutter_bloc_login_example/model/change_password.dart';
import 'package:flutter_bloc_login_example/model/provider.dart';
import 'package:flutter_bloc_login_example/model/recovery_question.dart';

class ChangePasswordResponse {
  ChangePassword password;
  RecoveryQuestion recoveryQuestion;
  Provider provider;

  ChangePasswordResponse({this.password, this.recoveryQuestion, this.provider});

  ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    password = json['password'] != null
        ? new ChangePassword.fromJson(json['password'])
        : null;
    recoveryQuestion = json['recovery_question'] != null
        ? new RecoveryQuestion.fromJson(json['recovery_question'])
        : null;
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.password != null) {
      data['password'] = this.password.toJson();
    }
    if (this.recoveryQuestion != null) {
      data['recovery_question'] = this.recoveryQuestion.toJson();
    }
    if (this.provider != null) {
      data['provider'] = this.provider.toJson();
    }
    return data;
  }
}
