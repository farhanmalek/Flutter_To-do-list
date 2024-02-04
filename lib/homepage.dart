// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/utils/dialog_box.dart';
import 'package:to_do_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');
  //create instance of db class
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
   //first time ever opening the app?create default data
   if (_myBox.get("TODOLIST") == null) {
    db.createInitialData();


   } else {
    db.loadData();
   }

    super.initState();
  }

  //Text controller
  final _controller = TextEditingController();
  //List of todo tasks

  //Checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = value;
    });
    db.updateDataBase();
  }

  //Save new task.

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    // Open dialog box as a result of this button press
    showDialog(
      context: context,
      builder: ((context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      }),
    );
  }

//Delete a to do
  void removeTask(task) {
    setState(() {
      db.toDoList.remove(task);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("TO DO"),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          //Open Popup to add new task
          onPressed: createNewTask,
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) => Dismissible(
            key: ValueKey(db.toDoList[index]),
            background: Container(
              //using out theme here to get the related error
              color: Theme.of(context).colorScheme.error,
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onDismissed: (direction) => removeTask(db.toDoList[index]),
            child: ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) {
                return checkBoxChanged(value, index);
              },
            ),
          ),
        ));
  }
}
