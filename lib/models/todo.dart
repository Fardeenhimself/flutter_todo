class Todo {
  final String id;
  final String name;
  final String addedAt;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.name,
    required this.addedAt,
    this.isCompleted = false,
  });
}
