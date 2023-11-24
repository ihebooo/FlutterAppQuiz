import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'question_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'quiz.db';
  static const String tableName = 'questions';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            questionText TEXT,
            options TEXT,
            correctAnswerIndex INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertQuestion(Question question) async {
    final Database db = await database;
    await db.insert(tableName, question.toMap());
  }

  Future<List<Question>> getQuestions() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Question.fromMap(maps[i]);
    });
  }

  // Méthode pour ajouter une nouvelle question à la base de données
  Future<void> addNewQuestion(
      String questionText, List<String> options, int correctAnswerIndex) async {
    final newQuestion = Question(
      id: null, // L'ID sera généré automatiquement par la base de données
      questionText: questionText,
      options: options,
      correctAnswerIndex: correctAnswerIndex,
    );

    await insertQuestion(newQuestion);
  }
}
