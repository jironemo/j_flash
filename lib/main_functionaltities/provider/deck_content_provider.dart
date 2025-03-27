import 'package:flutter/material.dart';
import 'package:j_flash/models/card.dart';
import 'package:j_flash/repository/card_repository.dart';

class DeckContentProvider with ChangeNotifier {
  List<CardEntity> cards = [];
  CardEntityRepository cardEntityRepository = CardEntityRepository();
  DeckContentProvider(deckId) {
    fetchCards(deckId);
  }
  void fetchCards(int deckId) async {
    cards = await cardEntityRepository.fetchCards(deckId);
    notifyListeners();
  }
}
