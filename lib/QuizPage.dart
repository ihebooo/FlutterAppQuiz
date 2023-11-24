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

  void checkAnswer(int selectedIndex) {
    int correctIndex =
        widget.questions[currentQuestionIndex].correctAnswerIndex;
    bool isCorrect = selectedIndex == correctIndex;

    setState(() {
      if (isCorrect) {
        score++;
      }
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Affiche le score final après avoir répondu à toutes les questions
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              score: score,
              totalQuestions: widget.questions.length,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.blueAccent, // Couleur de la barre de navigation
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.questions[currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Column(
              children: widget.questions[currentQuestionIndex].options
                  .asMap()
                  .entries
                  .map((option) {
                int index = option.key;
                String optionText = option.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      checkAnswer(index);
                    },
                    child: Text(optionText),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent, // Couleur du bouton
                      onPrimary: Colors.white, // Couleur du texte du bouton
                      minimumSize: Size(200, 40), // Taille du bouton
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50], // Couleur de fond de la page
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultPage({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Colors.blueAccent, // Couleur de la barre de navigation
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quiz Completed!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Score: $score / $totalQuestions',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Restart Quiz'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // Couleur du bouton
                onPrimary: Colors.white, // Couleur du texte du bouton
                minimumSize: Size(150, 40), // Taille du bouton
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50], // Couleur de fond de la page
    );
  }
}
