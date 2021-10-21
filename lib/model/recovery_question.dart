class RecoveryQuestion {
  String question;

  RecoveryQuestion({this.question});

  RecoveryQuestion.fromJson(Map<String, dynamic> json) {
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    return data;
  }
}
