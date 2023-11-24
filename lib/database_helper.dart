import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'question_model.dart'; // Replace 'question_model.dart' with the correct path to the file defining the Question class

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
}
