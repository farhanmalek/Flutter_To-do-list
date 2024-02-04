import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  //reference the box
  final _myBox = Hive.box('mybox');

  //run this method if this is the first time opening the app. EVER.
  void createInitialData() {
    toDoList = [
      ["Make tutorial", false],
      ["Do Exercise", false],
    ];
  }

  //Load Data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
