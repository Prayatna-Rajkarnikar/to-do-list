import 'package:flutter/material.dart';

import '../models/to_do.dart';

class ToDoList extends StatelessWidget {
  final ToDo toDo;
  final onChangeToDo;
  final onDeleteToDo;

  const ToDoList({
    Key? key,
    required this.toDo,
    required this.onChangeToDo,
    required this.onDeleteToDo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          print('Toggle ToDo status');
          onChangeToDo(toDo);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        leading: Icon(
          toDo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.deepOrangeAccent,
        ),
        title: Text(
          toDo.toDoText!,
          style: TextStyle(
            fontSize: 17,
            color: Colors.black87,
            decoration: toDo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red.shade600,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 15,
            icon: const Icon(Icons.delete),
            onPressed: () {
              print('Delete ToDo');
              onDeleteToDo(toDo.id);
            },
          ),
        ),
      ),
    );
  }
}
