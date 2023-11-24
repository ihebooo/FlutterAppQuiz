import 'package:flutter/material.dart';
import 'question_model.dart';

 import 'questions_data.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> _remainingQuestions = allQuestions; // Utilise la liste de toutes les questions

  void showNextQuestion() {
    if (_remainingQuestions.isNotEmpty) {
      // Obtient la prochaine question et la retire de la liste des questions restantes
      Question nextQuestion = _remainingQuestions.removeAt(0);

      // Ici, tu peux afficher la question nextQuestion et gérer les réponses de l'utilisateur
      // ...
    } else {
      // Toutes les questions ont été posées
      // Tu peux afficher le score final ou passer à une autre page
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showNextQuestion,
          child: Text('Next Question'),
        ),
      ),
    );
  }
}
