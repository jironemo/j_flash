abstract class BaseEntity {
  Map<String, dynamic> toMap();
  BaseEntity();
  factory BaseEntity.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
