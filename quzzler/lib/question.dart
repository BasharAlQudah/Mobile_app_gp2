class Question {
  late bool _questionAnswer;
  late String _questionText;

  Question(String question, bool answer) {
    _questionAnswer = answer;
    _questionText = question;
  }

  bool getAnswer() {
    return _questionAnswer;
  }

  String getQuestion() {
    return _questionText;
  }
}
