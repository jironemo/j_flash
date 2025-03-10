class CardEntity {
  int? id;
  final String front;
  final String back;
  final int cardListId;
  CardEntity(
      {this.id,
      required this.front,
      required this.back,
      required this.cardListId});

  Map<String, dynamic> toMap() {
    return {'id': id, 'front': front, 'back': back, 'card_list_id': cardListId};
  }

  factory CardEntity.fromMap(Map<String, dynamic> map) {
    return CardEntity(
      id: map['id'],
      front: map['front'],
      back: map['back'],
      cardListId: map['card_list_id'],
    );
  }
}
