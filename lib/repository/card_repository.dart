import 'package:j_flash/models/card.dart';
import 'package:j_flash/util/db.dart';

class CardEntityRepository {
  Future<List<CardEntity>> fetchCards(int deckId) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query('card', where: 'deck_id = ?', whereArgs: [deckId]);
    return maps.map((map) => CardEntity.fromMap(map)).toList();
  }

  Future<CardEntity> fetchCard(int id) async {
    final db = DatabaseHelper.instance;
    CardEntity c = CardEntity.fromMap(await db.fetchItembyId('card', id));
    return c;
  }

  Future<bool> updateCard(CardEntity card) async {
    final db = DatabaseHelper.instance;
    int c = await db.updateItem('card', card);
    if (c != 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCard(int id) async {
    final db = DatabaseHelper.instance;
    int c = await db.deleteItem('card', id);
    if (c != 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> insertCard(CardEntity card) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('card', card.toMap());
  }
}
