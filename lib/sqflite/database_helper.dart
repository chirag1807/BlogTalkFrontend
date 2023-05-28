import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:blogtalk/models/SaveToDraft.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
          CREATE TABLE IF NOT EXISTS MyTable (
            id INTEGER PRIMARY KEY,
            title TEXT,
            content TEXT,
            topic INTEGER,
            image TEXT,
            date TEXT,
            readMinute INTEGER
          )
          ''',
        );
      },
    );
  }

  Future<int> saveData(String title, String content, int topic, String coverImgPath) async {
    try{
      Database db = await database;
      String date = DateFormat('dd MMMM yyyy').format(DateTime.now());
      int readMinute = calculateReadMinute(content);

      int id = await db.insert(
        'MyTable',
        {
          'title': title,
          'content': content,
          'topic': topic,
          'image': coverImgPath,
          'date': date,
          'readMinute': readMinute
        },
      );
      return id;

    } catch(e) {
      return -1;
    }
  }

  Future<int> updateData(int id, String title, String content, int topic, String coverImgPath) async {
    Database db = await database;
    String date = DateFormat('dd MMMM yyyy').format(DateTime.now());
    int readMinute = calculateReadMinute(content);

    int a = await db.update('MyTable', {
      'title': title,
      'content': content,
      'topic': topic,
      'image': coverImgPath,
      'date': date,
      'readMinute': readMinute
    }, where: 'id = ?', whereArgs: [id]);

    return a;
  }

  Future<List<SaveToDraft>> getAllPosts() async {
    Database db = await database;

    List<Map<String, dynamic>> objects = await db.query('MyTable');

    print(objects[0]['image']);

    return objects.map((map) {
      return SaveToDraft(
        id: map['id'],
        coverImg: map['image'] == "" ? null : File(map['image']),
        title: map['title'],
        content: map['content'],
        topic: map['topic'],
        date: map['date'],
        readMinute: map['readMinute']
      );
    }).toList();

  }

  Future<SaveToDraft?> getPostById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> objects = await db.query('MyTable', where: 'id = ?', whereArgs: [id]);
    if (objects.isNotEmpty) {
      Map<String, dynamic> map = objects.first;
      return SaveToDraft(
          id: map['id'],
          coverImg: map['coverImg'] == "" ? null : File(map['coverImg']),
          title: map['title'],
          content: map['content'],
          topic: map['topic'],
          date: map['date'],
          readMinute: map['readMinute']
      );
    }
    return null;
  }

  Future<int> deletePost(int id) async {
    Database db = await database;
    int a = await db.delete('MyTable', where: 'id = ?', whereArgs: [id]);
    return a;
  }

  int calculateReadMinute(String content) {
    int wordsPerMinute = 180; // Adjust the reading speed as needed
    List<String> words = content.trim().split(RegExp(r'\s+|\n'));
    int wordCount = words.length;
    print(wordCount);
    return max(1, (wordCount / wordsPerMinute).ceil());
  }
}
