import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final int totalScore;
  final int maxScore;

  ScorePage(this.totalScore, this.maxScore);

  @override
  Widget build(BuildContext context) {
    double percentage = (totalScore / maxScore) * 100;
    int scaledScore = (percentage / 100 * 50).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '$scaledScore / 50',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
