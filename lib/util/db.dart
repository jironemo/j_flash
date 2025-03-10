import 'package:j_flash/models/card.dart';
import 'package:j_flash/models/card_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('flash.db');
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
      CREATE TABLE card_list (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        num_of_cards INTEGER NOT NULL
      )
    ''');
    // Insert Sample Data
    await db.insert('card_list', {'name': 'Japanese N5', 'num_of_cards': 40});
    await db.insert('card_list', {'name': 'Japanese N4', 'num_of_cards': 40});
    await db.insert('card_list', {'name': 'Japanese N3', 'num_of_cards': 40});

    await db.execute('''
      CREATE TABLE card (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        front TEXT NOT NULL,
        back TEXT NOT NULL,
        card_list_id INTEGER NOT NULL
      )
    ''');
    // Insert Sample Data
    await db.insert('card', {
      'front': 'What is the sound of one hand clapping?',
      'back': '*slaps* *slaps* *slaps*',
      'card_list_id': 1
    });
    await db.insert('card', {
      'front': 'What do you want for dinner?',
      'back': 'Spaghetti!!!!',
      'card_list_id': 1
    });
    await db.insert('card', {
      'front': 'Is that a plane? Is that a bird?',
      'back': 'It\'s superman!',
      'card_list_id': 2
    });
    await db.insert('card', {
      'front': 'When there\'s trouble you know who to call',
      'back': 'Teen Titans!',
      'card_list_id': 2
    });
    await db.insert('card', {
      'front': 'What\'s your superpower?',
      'back': 'I\'m rich',
      'card_list_id': 3
    });
    await db.insert('card', {
      'front': 'Do you want to build a snowman?',
      'back': 'No!!!!',
      'card_list_id': 3
    });
  }

  Future<int> insertItem(CardList cardList) async {
    final db = await database;
    return await db.insert('card_lists', cardList.toMap());
  }

  Future<List<CardList>> fetchCardLists() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('card_list');
    return maps.map((map) => CardList.fromMap(map)).toList();
  }

  Future<List<CardEntity>> fetchCards(int deckId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('card', where: 'card_list_id = ?', whereArgs: [deckId]);
    return maps.map((map) => CardEntity.fromMap(map)).toList();
  }

  Future<CardEntity> fetchCard(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> map =
        await db.query('card', where: 'id = ?', whereArgs: [id], limit: 1);
    return CardEntity.fromMap(map.first);
  }

  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete('card_list', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateItem(CardList cardList) async {
    final db = await database;
    return await db.update('card_list', cardList.toMap(),
        where: 'id = ?', whereArgs: [cardList.id]);
  }
}
