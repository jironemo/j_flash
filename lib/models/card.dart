import 'package:j_flash/models/base.dart';

class CardEntity extends BaseEntity {
  int? id;
  String front;
  String back;
  int deckId;
  CardEntity(
      {this.id, required this.front, required this.back, required this.deckId});

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'front': front, 'back': back, 'deck_id': deckId};
  }

  @override
  factory CardEntity.fromMap(Map<String, dynamic> map) {
    return CardEntity(
      id: map['id'],
      front: map['front'],
      back: map['back'],
      deckId: map['deck_id'],
    );
  }
}
