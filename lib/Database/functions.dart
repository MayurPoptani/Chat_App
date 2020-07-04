import 'dart:io';

import 'package:chat_app/Database/variables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DATABASEFILENAME = "myDatabase.db";

Future<void> initDatabase() async {
  String dbFolderPath = await getDatabasesPath();
  var path = join(dbFolderPath, DATABASEFILENAME);
  if(!File(path).existsSync()) File(path).createSync(recursive: true);
  db = await openDatabase(path,
    version: 1,
    onCreate: (db, version) => print("Database Created Version "+version.toString()),
    onOpen: (db) => print("Database Opened"),
    singleInstance: true,
  );
}