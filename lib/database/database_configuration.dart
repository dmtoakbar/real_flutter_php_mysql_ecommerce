import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class ConfigDatabase {
 static Future<sql.Database> connect() async {
 return sql.openDatabase(
       join(await sql.getDatabasesPath(), 'nexus_database.db'),
      version: 1,
   );
 }
}