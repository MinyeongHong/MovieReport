import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:MovieReviewApp/contents/model_review.dart';

final String TableName = 'reviews';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'reviews.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE reviews(id TEXT, user_title TEXT,user_poster TEXT,user_genre TEXT,rate TEXT NOT NULL,talk TEXT DEFAULT 0, who TEXT DEFAULT 0 , time TEXT DEFAULT 0)",
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<void> insert(Review review) async {
    final db = await database;

    // Memo를 올바른 테이블에 추가하세요. 또한
    // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
    // 만약 동일한 memo가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
    await db.insert(
      TableName,
      review.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Review>> reviews() async {
    final db = await database;

    // 모든 Memo를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('reviews');

    // List<Map<String, dynamic>를 List<Memo>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return Review(
        id: maps[i]['id'],
        user_title: maps[i]['user_title'],
        user_poster: maps[i]['user_poster'],
        user_genre: maps[i]['user_genre'],
        rate: maps[i]['rate'],
        talk: maps[i]['talk'],
        who: maps[i]['who'],
        time: maps[i]['time'],
      );
    });
  }

  Future<void> update(Review review) async {
    final db = await database;

    // 주어진 Memo를 수정합니다.
    await db.update(
      TableName,
      review.toMap(),
      // Memo의 id가 일치하는 지 확인합니다.
      where: "id = ?",
      // Memo의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
      whereArgs: [review.id],
    );
  }

  Future<void> delete(String? id) async {
    final db = await database;

    // 데이터베이스에서 Memo를 삭제합니다.
    await db.delete(
      TableName,
      // 특정 memo를 제거하기 위해 `where` 절을 사용하세요
      where: "id = ?",
      // Memo의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [id],
    );
  }

  Future<List<Review>> findreview(String? id) async {
    final db = await database;

    // 모든 Memo를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps =
        await db.query('reviews', where: 'id=?', whereArgs: [id]);

    // List<Map<String, dynamic>를 List<Memo>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return Review(
        id: maps[i]['id'],
        user_title: maps[i]['user_title'],
        user_poster: maps[i]['user_poster'],
        user_genre: maps[i]['user_genre'],
        rate: maps[i]['rate'],
        talk: maps[i]['talk'],
        who: maps[i]['who'],
        time: maps[i]['time'],
      );
    });
  }
}
