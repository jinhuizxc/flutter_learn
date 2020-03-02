import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static Database db;

  //初始化数据库
  static Future init() async {
    //Get a location using getDatabasesPath
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'flutter.db');
    print(path);
    try {
      db = await openDatabase(path);
    } catch (e) {
      print("Error $e");
    }

    // 检查数据库中, 表是否完整, 在部份android中, 会出现表丢失的情况
    bool tableIsRight = await checkTableIsRight();
    if (!tableIsRight) {
      // 关闭上面打开的db，否则无法执行open
      db.close();
      // Delete the database
      await deleteDatabase(path);

      // 创建一张表
      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        print('db created version is $version');
        createDB(db);
      }, onOpen: (Database db) async {
        print('new db opened');
      });
    } else {
      print("Opening existing database");
    }
  }

  //创建数据库
  static void createDB(Database db) {
    db.execute(createSql['userInfo'], null);
    db.execute(createSql['collection'], null);
  }

  //拷贝数据库
  static Future copyDB(String dbPath) async {
    ByteData data = await rootBundle.load(join("assets", "app.db"));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(dbPath).writeAsBytes(bytes);
  }


// 获取数据库中所有的表
  static Future<List> getTables() async {
    if (db == null) {
      return Future.value([]); //
    }

    List tables = await db
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    return targetList;
  }

  //当前存在的表
  static List<String> expectTables = ['userInfo', 'collection'];

  // 检查数据库中, 表是否完整, 在部份android中, 会出现表丢失的情况
  static checkTableIsRight() async {
    List<String> tables = await getTables();
    for (var value in expectTables) {
      if (!tables.contains(value)) {
        return false;
      }
    }
    return true;
  }
}

//数据库创建脚本
const createSql = {
  'userInfo': """
     CREATE TABLE IF NOT EXISTS userInfo (
     id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
     userName	TEXT NOT NULL UNIQUE,
     password	TEXT NOT NULL,
     nickName	TEXT,
     age	INTEGER NOT NULL DEFAULT 20,
     sex	INTEGER NOT NULL DEFAULT 0
   )
 """,
  'collection': """
   CREATE TABLE IF NOT EXISTS collection (id INTEGER PRIMARY KEY NOT NULL UNIQUE, name TEXT NOT NULL, router TEXT)
 """,
};
