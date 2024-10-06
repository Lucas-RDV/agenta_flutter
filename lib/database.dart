import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'contato.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'contatos.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, email TEXT, telefone TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> newContato(Contato contato) async {
    final db = await database;
    await db.insert(
      'contatos',
      contato.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contato>> getContatos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contatos');
    return List.generate(maps.length, (i) {
      return Contato(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        email: maps[i]['email'],
        telefone: maps[i]['telefone'],
      );
    });
  }

  Future<void> atualizarContato(Contato contato) async {
    final db = await database;
    await db.update(
      'contatos',
      contato.toMap(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future<void> deletarContato(int id) async {
    final db = await database;
    await db.delete(
      'contatos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}