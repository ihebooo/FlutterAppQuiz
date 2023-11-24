import 'package:flutter/material.dart';
import 'questions_data.dart';
import 'QuizPage.dart';
import 'AddQuestionPage.dart'; // Import the page for adding questions

class HomePage extends StatelessWidget {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(allQuestions),
                  ),
                );
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
                        AddQuestionPage(), // Navigate to the AddQuestionPage
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
