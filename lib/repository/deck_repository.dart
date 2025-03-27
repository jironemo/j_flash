import 'package:j_flash/models/deck.dart';
import 'package:j_flash/util/db.dart';

class DeckRepository {
  Future<List<Deck>> fetchDecks() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('deck');
    return maps.map((map) => Deck.fromMap(map)).toList();
  }

  Future<Deck> fetchDeck(int id) async {
    final db = DatabaseHelper.instance;
    Deck c = Deck.fromMap(await db.fetchItembyId('deck', id));
    return c;
  }

  Future<int> insertDeck(Deck deck) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('deck', deck.toMap());
  }
}
