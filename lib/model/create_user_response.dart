import 'package:flutter_bloc_login_example/model/profile.dart';
import 'package:flutter_bloc_login_example/model/schema.dart';

import 'credentials.dart';

class CreateUserResponse {
  String id;
  String status;
  String created;
  String activated;
  String statusChanged;
  String lastLogin;
  String lastUpdated;
  String passwordChanged;
  Schema type;
  Profile profile;
  Credentials credentials;

  CreateUserResponse({
    this.id,
    this.status,
    this.created,
    this.activated,
    this.statusChanged,
    this.lastLogin,
    this.lastUpdated,
    this.passwordChanged,
    this.type,
    this.profile,
    this.credentials,
  });

  CreateUserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    created = json['created'];
    activated = json['activated'];
    statusChanged = json['statusChanged'];
    lastLogin = json['lastLogin'];
    lastUpdated = json['lastUpdated'];
    passwordChanged = json['passwordChanged'];
    type = json['type'] != null ? new Schema.fromJson(json['type']) : null;
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    credentials = json['credentials'] != null
        ? new Credentials.fromJson(json['credentials'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['created'] = this.created;
    data['activated'] = this.activated;
    data['statusChanged'] = this.statusChanged;
    data['lastLogin'] = this.lastLogin;
    data['lastUpdated'] = this.lastUpdated;
    data['passwordChanged'] = this.passwordChanged;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    if (this.credentials != null) {
      data['credentials'] = this.credentials.toJson();
    }
    return data;
  }
}
