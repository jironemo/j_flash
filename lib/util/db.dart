import 'package:j_flash/models/deck.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper<T> {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('jflash.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE deck (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        num_of_cards INTEGER NOT NULL
      )
    ''');
    // Insert Sample Data
    await db.insert('deck', {'name': 'Japanese N5', 'num_of_cards': 40});
    await db.insert('deck', {'name': 'Japanese N4', 'num_of_cards': 40});
    await db.insert('deck', {'name': 'Japanese N3', 'num_of_cards': 40});

    await db.execute('''
      CREATE TABLE card (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        front TEXT NOT NULL,
        back TEXT NOT NULL,
        deck_id INTEGER NOT NULL
      )
    ''');
    // Insert Sample Data
    await db.insert('card', {
      'front': 'What is the sound of one hand clapping?',
      'back': '*slaps* *slaps* *slaps*',
      'deck_id': 1
    });
    await db.insert('card', {
      'front': 'What do you want for dinner?',
      'back': 'Spaghetti!!!!',
      'deck_id': 1
    });
    await db.insert('card', {
      'front': 'Is that a plane? Is that a bird?',
      'back': 'It\'s superman!',
      'deck_id': 2
    });
    await db.insert('card', {
      'front': 'When there\'s trouble you know who to call',
      'back': 'Teen Titans!',
      'deck_id': 2
    });
    await db.insert('card', {
      'front': 'What\'s your superpower?',
      'back': 'I\'m rich',
      'deck_id': 3
    });
    await db.insert('card', {
      'front': 'Do you want to build a snowman?',
      'back': 'No!!!!',
      'deck_id': 3
    });
  }

  Future<int> insertDeck(Deck cardList) async {
    final db = await database;
    return await db.insert('deck', cardList.toMap());
  }

  Future<Map<String, dynamic>> fetchItembyId(String table, int id) async {
    final db = await database;
    final List<Map<String, dynamic>> map =
        await db.query(table, where: 'id = ?', whereArgs: [id], limit: 1);
    return map.first;
  }

  Future<List<Deck>> fetchDecks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('deck');
    return maps.map((map) => Deck.fromMap(map)).toList();
  }

  Future<int> deleteItem(String table, int id) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateItem(String table, dynamic item) async {
    final db = await database;
    return await db
        .update(table, item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }
}
