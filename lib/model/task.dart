class Task {
  String? id;
  String title;
  bool isDone;

  Task({this.id, required this.title, this.isDone = false});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'] ?? false,
    );
  }

  static List<Task> todoList() {
    return [];
  }
}


