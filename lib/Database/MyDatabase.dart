import 'dart:async';

import 'dart:io';

import 'package:path/path.dart';
import 'package:pelatihan_dasar_flutter/Database/VisitQuery.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  String dbName = "inovatrackDB";
  String tblVersion = "dbversion";
  String tblNotification = "notification";
  Map<int, String> notificationQuery = {};
  Map<int, String> tblVersionQuery = {};

  MyDatabase();

  // return the path
  Future<String> checkDb(String dbName, {bool deleteOldDb = false}) async {
    var databasePath = await getDatabasesPath();
    // print(databasePath);
    String path = join(databasePath, dbName);
    print(path);

    // make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      if (deleteOldDb) {
        await deleteDatabase(path);
      }
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }

  Future<MyDatabase> initializeDb({bool deleteOldDb = false}) async {
    String path = await checkDb(this.dbName, deleteOldDb: deleteOldDb);
    Database db = await openDatabase(path);

    //check version
    await db.getVersion().then((version) {
      if (version == 0) {
        //create table visit
        db.rawQuery(VisitQuery.create()).then((onValue) {
          db.setVersion(1);
        });
      } else {
        // db.rawQuery(VisitQuery.drop()).then((onValue) {
        //   db.rawQuery(VisitQuery.create());
        // });
      }
      print(version);
    });

    return this;
  }

  Future<Database> openConnection() async {
    String path = await checkDb(this.dbName);
    Database db = await openDatabase(path);
    return db;
  }
}
