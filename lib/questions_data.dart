import 'question_model.dart';

List<Question> allQuestions = [
  Question(
    id: 1,
    questionText: 'What is the capital of France?',
    options: ['Paris', 'London', 'Berlin', 'Madrid'],
    correctAnswerIndex: 0,
  ),
  Question(
    id: 2,
    questionText: 'Which planet is known as the Red Planet?',
    options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
    correctAnswerIndex: 1,
  ),
  Question(
    id: 3,
    questionText: 'Who painted the Mona Lisa?',
    options: [
      'Leonardo da Vinci',
      'Pablo Picasso',
      'Vincent van Gogh',
      'Michelangelo'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    id: 4,
    questionText: 'What is the largest mammal in the world?',
    options: ['Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'],
    correctAnswerIndex: 1,
  ),
  // Add more questions as needed...
];
