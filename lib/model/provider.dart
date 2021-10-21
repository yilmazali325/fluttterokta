class Provider {
  String type;
  String name;

  Provider({this.type, this.name});

  Provider.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    return data;
  }
}
