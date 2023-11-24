import 'dart:io';

import 'package:projectdemo/atelier5/models/model_film.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; //join
import 'package:path_provider/path_provider.dart';

/////////////
class DataBaseHelper {
  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  DataBaseHelper(); //instanciation un Premier et unqoue objet

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    print(documentsDirectory);

    String path = join(documentsDirectory.path, '/monstock.db');

    print(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      //onUpgrade:_onupgrade,
      //onDowngrade:
    );
  }

  Future _onCreate(Database db, int version) async {
    print("Creatin database...........");
    await db.execute(
        '''
      CREATE TABLE Film(
      id INTEGER PRIMARY KEY ,
      code TEXT NOT NULL,
      titre TEXT NOT NULL,
      realisateur TEXT NOT NULL,
      annee INT,
      genre TEXT NOT NULL,
      publicCible TEXT NOT NULL);
      ''');
  }

  Future<int> add(Film film) async {
    Database db = await instance.database;
    return await db.insert('Film', film.toMap());
  }
}
