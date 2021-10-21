import 'package:flutter_bloc_login_example/model/profile.dart';

import 'credentials.dart';

class CreateUserRequest {
  Profile profile;
  List<String> groupIds;
  Credentials credentials;

  CreateUserRequest({this.profile, this.groupIds, this.credentials});

  CreateUserRequest.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    groupIds = json['groupIds'].cast<String>();
    credentials = json['credentials'] != null
        ? new Credentials.fromJson(json['credentials'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    data['groupIds'] = this.groupIds;
    if (this.credentials != null) {
      data['credentials'] = this.credentials.toJson();
    }
    return data;
  }
}
