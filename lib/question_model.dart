class Question {
  int id;
  String questionText;
  List<String> options;
  int correctAnswerIndex;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionText': questionText,
      'options': options.join(';'),
      'correctAnswerIndex': correctAnswerIndex,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      questionText: map['questionText'],
      options: map['options'].split(';'),
      correctAnswerIndex: map['correctAnswerIndex'],
    );
  }
}
