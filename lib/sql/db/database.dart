import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:synchronized/synchronized.dart';
import 'package:test_crossplatform/sql/model/Student.dart';

class DBProvider {
  // DBProvider._();
  // static final DBProvider db = DBProvider._();

  // static Database _database;

  String tableName = 'Students';
  String columnId = 'id';
  String name = 'name';



  // Future<Database> get database async {
  //   if (_database != null) return _database;
  //
  //   _database = await _initDb();
  //   return _database;
  // }
  //
  // Future<Database> _initDb() async {
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   String path = dir.path + 'Student.db';
  //   return await openDatabase(path, version: 1, onCreate: _createDb);
  // }

  // Student
  // Id | Name
  // 0 ..
  // 1 ..

  // void _createDb(Database db, int version) async {
  //   await db.execute(
  //     'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT)'
  //   );
  // }
  //
  // // READ
  // Future<List<Student>> getStudents() async {
  //   Database db = await database;
  //   final List<Map<String, dynamic>> studentsMapList = await db.query(tableName);
  //   final List<Student> studentsList = [];
  //
  //   studentsMapList.forEach((studentMap) {
  //     studentsList.add(Student.fromMap(studentMap));
  //   });
  //
  //   return studentsList;
  // }
  //
  // // INSERT
  // Future<Student> insertStudent(Student student) async {
  //   Database db = await database;
  //   student.id = await db.insert(tableName, student.toMap());
  //   return student;
  // }
  //
  // // UPDATE
  // Future<int> updateStudent(Student student) async {
  //   Database db = await database;
  //   return await db.update(
  //     tableName,
  //     student.toMap(),
  //     where: '$columnId = ?',
  //     whereArgs: [student.id]
  //   );
  // }
  //
  // // DELETE
  // Future<int> deleteStudent(int id) async {
  //   Database db = await database;
  //   return await db.delete(
  //     tableName,
  //     where: '$columnId = ?',
  //     whereArgs: [id]
  //   );
  // }
}

class StudentsDB {
  final String tableName;
  StudentsDB(this.tableName);
  String columnId = 'id';
  String name = 'name';

  Database? _db = null;

  // First variant
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    final path = join(await getDatabasesPath(), tableName);
    var theDb = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) => db.execute(
        'CREATE TABLE students($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT)'
      ),
    );
    return theDb;
  }

// Second variant

// final _lock = Lock();
// Future<Database> getDb() async {
//   if (_db == null) {
//     await _lock.synchronized(() async {
//       // Check again once entering the synchronized block
//       if (_db == null) {
//         _db = await openDatabase(path);
//       }
//     });
//   }
//   return _db;
// }

  Future<void> insertStudent(Student student) async {
    final db = await this.db;

    await db.insert(
      'students',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Student>> getStudents() async {
    final db = await this.db;

    final List<Map<String, dynamic>> maps = await db.query('students');

    return List.generate(maps.length, (i) {
      return Student(maps[i]['id'], maps[i]['name']);
    });
  }
}