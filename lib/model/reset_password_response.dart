class ResetPasswordResponse {
  String resetPasswordUrl;

  ResetPasswordResponse({this.resetPasswordUrl});

  ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    resetPasswordUrl = json['resetPasswordUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resetPasswordUrl'] = this.resetPasswordUrl;
    return data;
  }
}
