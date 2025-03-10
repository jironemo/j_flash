class CardList {
  int? id;
  String name;
  int numOfCards;
  CardList({this.id, required this.name, required this.numOfCards});
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'num_of_cards': numOfCards};
  }

  factory CardList.fromMap(Map<String, dynamic> map) {
    return CardList(
      id: map['id'],
      name: map['name'],
      numOfCards: map['num_of_cards'],
    );
  }
}
