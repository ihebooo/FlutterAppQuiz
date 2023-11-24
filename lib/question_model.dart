class Question {
  int? id; // Nullable ID
  String questionText;
  List<String> options;
  int correctAnswerIndex;

  Question({
    this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionText': questionText,
      'options': options.join(';'), // Join options with a delimiter
      'correctAnswerIndex': correctAnswerIndex,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      questionText: map['questionText'],
      options: map['options'].split(';'), // Split options back into a list
      correctAnswerIndex: map['correctAnswerIndex'],
    );
  }
}
