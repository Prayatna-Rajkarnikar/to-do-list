import 'package:flutter/material.dart';
import '../models/to_do.dart';
import '../widgets/to_do_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoLists = ToDo.toDoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoLists;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orangeAccent.shade100,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _search(), // Search widget
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 45, bottom: 20, left: 5),
                          child: const Text(
                            'Your To Do List',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Display ToDoList for each ToDo item
                        for (ToDo todo in _foundToDo.reversed)
                          ToDoList(
                            toDo: todo,
                            onChangeToDo: _changeToDo,
                            onDeleteToDo: _deleteItem,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Add button and input field at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: const InputDecoration(
                          hintText: 'Add a new item',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _addTodoList(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: Colors.deepOrangeAccent,
                        minimumSize: const Size(40, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.orangeAccent.shade100,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 25.0, left: 5),
            child: Text(
              'Hello User',
              style: TextStyle(
                fontSize: 37,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 5.0),
            child: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('images/user.png'),
            ),
          ),
        ],
      ),
    );
  }

  void _changeToDo(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone; // Toggle the isDone property
    });
  }


  void _deleteItem(String id) {
    setState(() {
      todoLists.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoList(String toDo) {
    setState(() {
      todoLists.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        toDoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoLists;
    } else {
      results = todoLists
          .where((item) => item.toDoText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget _search() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
