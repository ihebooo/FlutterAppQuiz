import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'question_model.dart';

class AddQuestionPage extends StatefulWidget {
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers =
      List.generate(3, (_) => TextEditingController());
  int _correctOptionIndex = 0; // Set default correct option

  @override
  void dispose() {
    _questionController.dispose();
    _optionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Enter the question'),
            ),
            SizedBox(height: 20.0),
            Text('Options:'),
            SizedBox(height: 8.0),
            for (int i = 0; i < 3; i++)
              _buildOptionField(i + 1, _optionControllers[i]),
            SizedBox(height: 20.0),
            Text('Select the correct option:'),
            _buildRadioOptions(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                saveQuestionToDatabase();
              },
              child: Text('Add Question'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionField(int optionNumber, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Option $optionNumber',
      ),
    );
  }

  Widget _buildRadioOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < 3; i++)
          RadioListTile<int>(
            title: Text('Option ${i + 1}'),
            value: i,
            groupValue: _correctOptionIndex,
            onChanged: (value) {
              setState(() {
                _correctOptionIndex = value!;
              });
            },
          ),
      ],
    );
  }

  void saveQuestionToDatabase() async {
    String questionText = _questionController.text;
    List<String> options =
        _optionControllers.map((controller) => controller.text).toList();

    Question newQuestion = Question(
      questionText: questionText,
      options: options,
      correctAnswerIndex: _correctOptionIndex,
    );

    await DatabaseHelper().insertQuestion(newQuestion);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Question added to Firestore'),
        duration: Duration(seconds: 2),
      ),
    );
    // Navigate back to the home page after inserting the question
    Future.delayed(Duration(seconds: 0), () {
      Navigator.pop(context);
    });
  }
}
