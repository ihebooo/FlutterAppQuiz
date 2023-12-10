import 'package:flutter/material.dart';
import 'AddQuestionPage.dart'; // Importez la page pour ajouter des questions
import 'QuizPage.dart';
import 'database_helper.dart';
import 'question_model.dart'; // Importez votre DatabaseHelper

class HomePage extends StatelessWidget {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void startQuiz(BuildContext context) async {
    List<Question> questions = await _databaseHelper.getAllQuestions();
    if (questions.isNotEmpty) {
      questions.shuffle(); // Mélanger l'ordre des questions
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(questions: questions),
        ),
      );
    } else {
      // Gérer le cas où aucune question n'a été récupérée
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No questions available!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.school,
              size: 80.0,
              color: Colors.blueAccent,
            ),
            SizedBox(height: 20.0),
            Text(
              'Welcome to the Quiz!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                startQuiz(
                    context); // Démarrer le quiz avec les questions de Firestore
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Start Quiz',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddQuestionPage(), // Naviguer vers la page d'ajout de question
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Add Question',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
    );
  }
}
