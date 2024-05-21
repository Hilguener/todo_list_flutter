import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/task.dart';

import '../repository/auth_repository.dart';
import '../repository/task_repository.dart';
import '../widgets/search_box.dart';
import '../widgets/task_item.dart';
import 'login.dart';

class Home extends StatefulWidget {
  Home({super.key});

  final User? user = AuthRepository().currentUser;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> todosList = [];
  final _todoController = TextEditingController();
  String _searchText = '';
  final String? userId = AuthRepository().currentUser?.uid;

  @override
  void initState() {
    super.initState();
    if (userId != null) {
      _loadTasks();
    }
  }

  Future<void> _loadTasks() async {
    if (userId != null) {
      todosList = await TaskRepository.instance.getTasks(userId!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        centerTitle: false,
        title: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.tasks,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: tdBlack,
                size: 30,
              ),
              onSelected: (String result) {
                if (result == AppLocalizations.of(context)!.logout) {
                  _signOut();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: AppLocalizations.of(context)!.logout,
                  child: Text(AppLocalizations.of(context)!.logout),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              SearchBox(
                onSearchTextChanged: (newText) {
                  setState(() {
                    _searchText = newText;
                  });
                },
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 20),
                    ),
                    for (Task todo in todosList)
                      if (_searchText.isEmpty ||
                          todo.title.contains(_searchText))
                        TaskItem(
                          task: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deletedItem,
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0)
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.addNewToDoItem,
                      border: InputBorder.none),
                ),
              )),
              Container(
                margin: const EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _addTodoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(60, 60),
                      elevation: 10),
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  void _signOut() async {
    await AuthRepository().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _addTodoItem(String toDo) async {
    if (toDo.isEmpty || userId == null) return;

    final newTask = Task(
      id: null,
      title: toDo,
    );

    await TaskRepository.instance.createTask(userId!, newTask);

    setState(() {
      todosList.add(newTask);
    });

    _todoController.clear();
  }

  void _deletedItem(String id) async {
    if (userId == null) {
      return;
    }

    try {
      await TaskRepository.instance.deleteTask(userId!, id);

      setState(() {
        todosList.removeWhere((item) => item.id == id);
      });
    } catch (e) {}
  }

  void _handleToDoChange(Task task) async {
    if (userId == null) return;

    setState(() {
      task.isDone = !task.isDone;
    });

    await TaskRepository.instance.updateTask(userId!, task);
  }
}
