import 'package:flutter/material.dart';
import 'package:quiz/home_page.dart';
import 'database_helper.dart';
import 'question_model.dart';
import 'AddQuestionPage.dart';
import 'signin.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuestionsManagementPage extends StatefulWidget {
  @override
  _QuestionsManagementPageState createState() =>
      _QuestionsManagementPageState();
}

class _QuestionsManagementPageState extends State<QuestionsManagementPage> {
  late List<Question> questions;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    await _auth.signOut();
    await FirebaseAuth.instance.signOut();

// Clear the navigation stack and redirect to the sign-in page
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
    Fluttertoast.showToast(
      msg: 'Logged out successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void initState() {
    super.initState();
    questions = []; // Initialize the variable as an empty list
    _fetchQuestions();
  }

  // Function to delete a question by its content
  Future<void> deleteQuestionByContent(String questionText) async {
    try {
      // Create a reference to the Firestore collection
      CollectionReference questionsCollection =
          FirebaseFirestore.instance.collection('questions');

      // Use a query to find the document with the matching questionText
      QuerySnapshot querySnapshot = await questionsCollection
          .where('questionText', isEqualTo: questionText)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // If there are matching documents, delete them
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          await questionsCollection.doc(document.id).delete();
        }
      } else {
        // Handle the case where no matching document was found
        print('No matching document found');
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      print('Error deleting question: $e');
    }
  }

  // Function to handle the deletion of a question
  _deleteQuestion(Question question) async {
    // Get the question text to identify the question
    String questionText = question.questionText;

    // Call the function to delete the question by its content
    await deleteQuestionByContent(questionText);

    // After deletion, fetch the updated list of questions
    _fetchQuestions();

    // Show a toast message for deletion success
    Fluttertoast.showToast(
      msg: 'Question deleted successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  _fetchQuestions() async {
    questions = await _databaseHelper.getAllQuestions();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);

    if (user == null) {
      // Redirect to sign-in page if user is not authenticated
      return SignInPage();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Questions'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut();
              // Add your logout logic here
              // Navigate to HomePage
            },
          ),
        ],
      ),
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      questions[index].questionText,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteQuestion(questions[index]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuestionPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
