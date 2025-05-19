import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_sql/model/model_buku.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._instance();

  static Database? _database;
  DBHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "db_buku");
    return await openDatabase(path, version: 1, onCreate: _oncreate);
  }

  Future _oncreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE buku(id INTEGER PRIMARY KEY AUTOINCREMENT,
         judulbuku TEXT,
          kategori TEXT)''');
  }

  Future<int> insertBuku(ModelBuku buku) async {
    Database db = await instance.db;
    return await db.insert("buku", buku.toMap());
  }

  Future<List<Map<String, dynamic>>> getBuku() async {
    Database db = await instance.db;
    return await db.query("buku");
  }

  Future<int> updatebuku(ModelBuku buku) async {
    Database db = await instance.db;
    return await db.update("buku", buku.toMap(),
        where: "id = ?", whereArgs: [buku.id]);
  }

  Future<int> deletebuku(int id) async {
    Database db = await instance.db;
    return await db.delete("buku", where: "id = ?", whereArgs: [id]);
  }

  Future<void> dummybuku() async{
    List<ModelBuku> dataBukutoAdd = [
      ModelBuku(judulbuku: "malam minggu miko", kategori: "novel"),
      ModelBuku(judulbuku: "doraemon", kategori: "komik"),
      ModelBuku(judulbuku: "tenggelamnya kapal van der wijck", kategori: "novel"),
      ModelBuku(judulbuku: "Di bawah lindungan ka'bah", kategori: "Novel"),
      ModelBuku(judulbuku: "Paus Kesepian", kategori: "Novel"),
    ];
    for(ModelBuku modelBuku in dataBukutoAdd){
      await insertBuku(modelBuku);
    }
  }

}