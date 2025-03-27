class Deck {
  int? id;
  String name;
  int numOfCards;
  Deck({this.id, required this.name, required this.numOfCards});
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'num_of_cards': numOfCards};
  }

  factory Deck.fromMap(Map<String, dynamic> map) {
    return Deck(
      id: map['id'],
      name: map['name'],
      numOfCards: map['num_of_cards'],
    );
  }
}
