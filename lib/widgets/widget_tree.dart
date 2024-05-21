import 'package:flutter/cupertino.dart';
import 'package:todo_list/screens/login.dart';
import '../repository/auth_repository.dart';
import '../screens/home.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthRepository().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
