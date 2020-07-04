import 'dart:io';

import 'package:chat_app/Database/models/ChatItem.dart';
import 'package:chat_app/Database/models/MessageItem.dart';
import 'package:chat_app/Database/variables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DATABASEFILENAME = "myDatabase.db";

bool isNewlyCreated = false;

void _onOpen(Database _db) async {
  db = _db;
  print("Database Opened");
  if(!isNewlyCreated) return;
  try{
    await db.execute('CREATE TABLE '+ChatTable+' ('+ChatItem.ID+' INTEGER PRIMARY KEY AUTOINCREMENT, '+ChatItem.RECIEVER+' TEXT)');
  } on DatabaseException catch (e) {
    print("SqfliteDatabaseException E = "+e.toString());
  }
  try{
    await db.execute('CREATE TABLE '+MessageTable+' ('+MessageItem.ID+' INTEGER PRIMARY KEY AUTOINCREMENT, '+MessageItem.RECIEVER_ID+' INTEGER, '+MessageItem.MESSAGE+' TEXT, '+MessageItem.DATETIME+' DATETIME DEFAULT CURRENT_TIMESTAMP)');
  } on DatabaseException catch (e) {
    print("SqfliteDatabaseException E = "+e.toString());
  }
  
  ///////////////////// DUMMY DATA INSERT START /////////////////////
  try{
    
    print(await ChatItem.addChatItem(db, "Tony Stack"));
    print(await ChatItem.addChatItem(db, "Steve Rogers"));
    print(await ChatItem.addChatItem(db, "Peter Parker"));
    print(await ChatItem.addChatItem(db, "Natasha Ramanof"));
    print(await ChatItem.addChatItem(db, "Stan Lee"));
    
    print(await MessageItem.addMessageItem(db, 1, "Hello Tony, How are you?"));
    print(await MessageItem.addMessageItem(db, 2, "Hey Steve, How's you and bucky?"));
    print(await MessageItem.addMessageItem(db, 3, "Hi Peter, How was your date with MJ?"));
    print(await MessageItem.addMessageItem(db, 4, "Agent Romanof, Did you finished the Assignment?"));
    print(await MessageItem.addMessageItem(db, 5, "Hey Stan Lee, We Love You 300"));
    
    print("PRINTING TABLE DATA");
    print((await db.query(MessageTable)).toString());
  }
  on DatabaseException catch (e) {
    print("DatabaseException. E = "+e.toString());
  }
  ////////////////////// DUMMY DATA INSERT END //////////////////////
  
}

Future<void> initDatabase() async {
  // Sqflite.setDebugModeOn(true);
  //ignore: deprecated_member_use
  // Sqflite.devSetDebugModeOn(true);
  String dbFolderPath = await getDatabasesPath();
  var path = join(dbFolderPath, DATABASEFILENAME);
  if(!File(path).existsSync()) File(path).createSync(recursive: true);
  // await deleteDatabase(path);
  db = await openDatabase(path,
    version: 1,
    onCreate: (db, version) {
      print("Database Created With Version: "+version.toString());
      isNewlyCreated = true;
    },
    onOpen: _onOpen,
    singleInstance: true,
  );
  
}