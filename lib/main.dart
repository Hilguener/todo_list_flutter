import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/myapp.dart';
import 'package:todo_list/repository/task_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDFY9Gdbeo9aqOdHi4axWAkzJbL3FjorGU",
          appId: "1:538248241659:android:1ebd9c79faf2cf17546b5e",
          messagingSenderId: "538248241659",
          projectId: "todo-list-ca2d5"));
  Get.put(TaskRepository());
  runApp(const MyApp());
}
