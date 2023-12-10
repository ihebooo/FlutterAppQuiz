import 'package:cloud_firestore/cloud_firestore.dart';
import 'question_model.dart';

class DatabaseHelper {
  final CollectionReference _questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  Future<void> insertQuestion(Question question) async {
    await _questionsCollection.add(question.toMap());
  }

  Future<List<Question>> getAllQuestions() async {
    QuerySnapshot questionSnapshot = await _questionsCollection.get();
    List<Question> questions = [];

    questionSnapshot.docs.forEach((doc) {
      questions.add(Question.fromMap(doc.data() as Map<String, dynamic>));
    });

    return questions;
  }
}
