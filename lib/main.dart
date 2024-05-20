import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDFY9Gdbeo9aqOdHi4axWAkzJbL3FjorGU",
          appId: "todo-list-ca2d5",
          messagingSenderId: "538248241659",
          projectId: "1:538248241659:android:1ebd9c79faf2cf17546b5e"));
  runApp(const MyApp());
}
