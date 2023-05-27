import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_question.dart';

class DbUtils {

  static final DbUtils _dbUtils = DbUtils._internal();

  DbUtils._internal();

  factory DbUtils() {
    return _dbUtils;
  }

  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String path = join(await getDatabasesPath(), 'questions_database.db');
    var dbQuestions = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbQuestions;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE questions(id INTEGER PRIMARY KEY, question TEXT, answer TEXT)");
  }

  Future<void> deleteTable() async {
    final Database? db = await this.db;
    db?.delete('questions');
  }

  Future<void> insertQuestion(UserQuestion question) async {
    final Database? db = await this.db;
    await db?.insert(
      'questions',
      question.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<UserQuestion>> questions() async {
    // Get a reference to the database.
    final Database? db = await this.db;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>>? maps = await db?.query('questions');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps!.length, (i) {
      return UserQuestion(
        id: maps[i]['id'],
        question: maps[i]['question'],
        answer: maps[i]['answer'],
      );
    });
  }

  Future<void> updateQuestion(UserQuestion question) async {
    final db = await this.db;
    await db?.update(
      'questions',
      question.toMap(),
      where: "id = ?",
      whereArgs: [question.id],
    );
  }

  Future<void> deleteQuestion(int id) async {
    final db = await this.db;
    await db?.delete(
      'questions',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future selectQuestion(int id) async {
    // Get a reference to the database.
    final Database? db = await this.db;

    final map = await db?.query(
        'questions',
        where: "id = ?",
        whereArgs: [id],
        limit: 1
    );

    return map;
  }
}