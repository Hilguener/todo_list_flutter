class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> todoList() {
    return [
      ToDo(id: '1', todoText: 'Tarefa 1', isDone: false),
      ToDo(id: '2', todoText: 'Tarefa 2', isDone: true),
      ToDo(id: '3', todoText: 'Tarefa 3', isDone: false),
      ToDo(id: '4', todoText: 'Tarefa 4', isDone: true),
      ToDo(id: '5', todoText: 'Tarefa 5', isDone: false),
    ];
  }
}
