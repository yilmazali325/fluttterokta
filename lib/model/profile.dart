class Profile {
  String firstName;
  String lastName;
  String email;
  String login;
  String mobilePhone;

  Profile(
      {this.firstName,
      this.lastName,
      this.email,
      this.login,
      this.mobilePhone});

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    login = json['login'];
    mobilePhone = json['mobilePhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['login'] = this.login;
    data['mobilePhone'] = this.mobilePhone;
    return data;
  }
}
