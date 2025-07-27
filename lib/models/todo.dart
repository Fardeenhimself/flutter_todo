import 'package:hive_flutter/hive_flutter.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime addedAt;

  @HiveField(3)
  bool isCompleted;

  Todo({
    required this.id,
    required this.name,
    DateTime? addedAt,
    this.isCompleted = false,
  }) : addedAt = addedAt ?? DateTime.now();
}
