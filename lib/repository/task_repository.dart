import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_list/model/task.dart';

class TaskRepository extends GetxController {
  static TaskRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createTask(String userId, Task task) async {
    try {
      DocumentReference docRef = await _db
          .collection("Users")
          .doc(userId)
          .collection("Tasks")
          .add(task.toJson());
      task.id = docRef.id;
      await docRef.update({'id': docRef.id});
    } catch (e) {}
  }

  Future<List<Task>> getTasks(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await _db.collection("Users").doc(userId).collection("Tasks").get();
      return querySnapshot.docs
          .map((doc) => Task.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> updateTask(String userId, Task task) async {
    try {
      await _db
          .collection("Users")
          .doc(userId)
          .collection("Tasks")
          .doc(task.id)
          .update(task.toJson());
    } catch (e) {}
  }

  Future<void> deleteTask(String userId, String taskId) async {
    try {
      await _db
          .collection("Users")
          .doc(userId)
          .collection("Tasks")
          .doc(taskId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
