import 'package:flutter/material.dart';
import 'question_model.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;

  QuizPage(this.questions);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  List<bool?> userAnswers = [];
  bool canGoToNextQuestion = false;

  void checkAnswer(int selectedIndex) {
    int correctIndex =
        widget.questions[currentQuestionIndex].correctAnswerIndex;
    bool isCorrect = selectedIndex == correctIndex;
    userAnswers.add(isCorrect);

    if (isCorrect) {
      setState(() {
        score++;
      });
    }

    setState(() {
      canGoToNextQuestion = true;
    });
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        canGoToNextQuestion =
            false; // Réinitialise le bouton pour la prochaine question
      });
    } else {
      // Navigation vers la page de résultats ou autre logique de fin de quiz
      // Tu peux remplacer le code suivant par ce qui est nécessaire pour toi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(score, widget.questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.questions[currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            // Affiche les options de réponse
            ...widget.questions[currentQuestionIndex].options
                .asMap()
                .entries
                .map((option) {
              int index = option.key;
              String optionText = option.value;
              return ElevatedButton(
                onPressed: () {
                  checkAnswer(index);
                },
                child: Text(optionText),
              );
            }).toList(),
            // Affiche le bouton pour passer à la question suivante s'il est activé
            if (canGoToNextQuestion)
              ElevatedButton(
                onPressed: () {
                  goToNextQuestion();
                },
                child: Text('Next Question'),
              ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultPage(this.score, this.totalQuestions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Score: $score / $totalQuestions',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
