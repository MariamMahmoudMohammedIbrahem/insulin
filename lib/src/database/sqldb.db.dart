// import 'dart:async';
//
// import 'package:path/path.dart';
// import 'package:sqflite_sqlcipher/sqflite.dart';
// class SqlDb {
//
//   static Database? _db;
//
//   Future <Database?> get db async {
//     if (_db == null) {
//       _db = await initialDb();
//       return _db;
//     }
//     else {
//       return _db;
//     }
//   }
//
//   Future<Database> initialDb() async {
//     String password = 'eoIp28insulin';
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath, 'eoip.db');
//     Database mydb = await openDatabase(
//         path, onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade, password: password);
//     return mydb;
//   }
//
//   //version changed
//   Future<void> _onUpgrade(Database db, int oldversion, int newversion) async {
//     print("onUpgrade");
//   }
//
//   //JUST CALLED ONCE
//   Future _onCreate(Database db, int version) async {
//     //create meters table
//     // CHARGE 1 NO CHARGE 0
//     await db.execute('''
//     CREATE TABLE "Meters"(
//       'name' TEXT NOT NULL UNIQUE,
//       'balance' INTEGER NOT NULL,
//       'tarrif' INTEGER NOT NULL,
//       PRIMARY KEY ('name')
//     )
//     ''');
//     //create electricity table
//     await db.execute('''
//     CREATE TABLE "Electricity"(
//       'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//       'title' TEXT NOT NULL,
//       'clientId' INTEGER NOT NULL,
//       'totalReading' TEXT NOT NULL,
//       'totalCredit' TEXT NOT NULL,
//       'currentTarrif' TEXT NOT NULL,
//       'valveStatus' TEXT NOT NULL,
//       'leackageFlag' TEXT NOT NULL,
//       'fraudFlag' TEXT NOT NULL,
//       'currentConsumption' TEXT NOT NULL,
//       'month1' TEXT NOT NULL,
//       'month2' TEXT NOT NULL,
//       'month3' TEXT NOT NULL,
//       'month4' TEXT NOT NULL,
//       'month5' TEXT NOT NULL,
//       'month6' TEXT NOT NULL,
//       'list' TEXT NOT NULL,
//       'process' TEXT NOT NULL,
//       'time' DATETIME NOT NULL
//     )
//     ''');
//     //create water table
//     await db.execute('''
//     CREATE TABLE "Water"(
//       'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//       'title' TEXT NOT NULL,
//       'clientId' INTEGER NOT NULL,
//       'totalReading' TEXT NOT NULL,
//       'totalCredit' TEXT NOT NULL,
//       'currentTarrif' TEXT NOT NULL,
//       'valveStatus' TEXT NOT NULL,
//       'leackageFlag' TEXT NOT NULL,
//       'fraudFlag' TEXT NOT NULL,
//       'currentConsumption' TEXT NOT NULL,
//       'month1' TEXT NOT NULL,
//       'month2' TEXT NOT NULL,
//       'month3' TEXT NOT NULL,
//       'month4' TEXT NOT NULL,
//       'month5' TEXT NOT NULL,
//       'month6' TEXT NOT NULL,
//       'list' TEXT NOT NULL,
//       'process' TEXT NOT NULL,
//       'time' DATETIME NOT NULL
//     )
//     ''');
//     //create master table
//     //process is balance or tarrif or none
//     await db.execute('''
//     CREATE TABLE "master_table" (
//     'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//     'list' TEXT NOT NULL,
//     'name' TEXT NOT NULL,
//     'type' TEXT NOT NULL,
//     'process' TEXT NOT NULL
//     )
//     ''');
//   }
//   //get the names of the meters
//   Future<List<Map>> readData(String sql) async {
//     Database? mydb = await db;
//     //take returened data from database
//     List<Map> response = await mydb!.rawQuery(sql);
//     return response;
//   }
//
//
//   //UPDATE
//   Future<int> updateData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawUpdate(sql);
//     return response;
//   }
//
//   // delete database
//   Future mydeleteDatabase() async {
//     String databasepath = await getDatabasesPath();
//     String path = join(databasepath, 'eoip.db');
//     await deleteDatabase(path);
//   }
//
// }