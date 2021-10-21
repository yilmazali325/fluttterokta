import 'package:flutter_bloc_login_example/model/change_password_request_password_model.dart';

class ChangePasswordRequest {
  ChangePasswordRequestPasswordModel oldPassword;
  ChangePasswordRequestPasswordModel newPassword;

  ChangePasswordRequest({this.oldPassword, this.newPassword});

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'] != null
        ? new ChangePasswordRequestPasswordModel.fromJson(json['oldPassword'])
        : null;
    newPassword = json['newPassword'] != null
        ? new ChangePasswordRequestPasswordModel.fromJson(json['newPassword'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.oldPassword != null) {
      data['oldPassword'] = this.oldPassword.toJson();
    }
    if (this.newPassword != null) {
      data['newPassword'] = this.newPassword.toJson();
    }
    return data;
  }
}
