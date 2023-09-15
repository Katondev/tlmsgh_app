class AnswerSubmit {
  String? question;
  String? answer;
  List<String>? option;
  String? selectedOption;

  AnswerSubmit({this.question, this.answer, this.option, this.selectedOption});

  AnswerSubmit.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    option = json['option'].cast<String>();
    selectedOption = json['selectedOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['option'] = this.option;
    data['selectedOption'] = this.selectedOption;
    return data;
  }
}