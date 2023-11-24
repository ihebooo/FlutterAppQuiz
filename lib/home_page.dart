import 'package:flutter/material.dart';
import 'questions_data.dart'; // Assure-toi que le chemin d'accès est correct
import 'QuizPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Quiz!',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(
                        allQuestions), // Utilisation de allQuestions ici
                  ),
                );
              },
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
