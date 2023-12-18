import 'package:flutter/material.dart';
import 'app_styles.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<TodoItem> todos = [];
  final TextEditingController todoController = TextEditingController();

  void _showAddTodoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Add Task',
                    style: AppStyles.tasksHeadingStyle,
                  ),
                  TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: 'Enter your task...',
                    ),
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      setState(() {
                        todos.add(TodoItem(task: todoController.text));
                        todoController.clear();
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/elma.png'),
                  radius: 30.0,
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'elma',
                      style: AppStyles.nameStyle,
                    ),
                    Text(
                      'elma@gmail.com',
                      style: AppStyles.emailStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'My Tasks',
              style: AppStyles.tasksHeadingStyle,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(todos[index].task),
                  onDismissed: (direction) {
                    setState(() {
                      todos.removeAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: CheckboxListTile(
                    title: Text(
                      todos[index].task,
                      style: TextStyle(
                        decoration: todos[index].isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    value: todos[index].isCompleted,
                    onChanged: (value) {
                      setState(() {
                        todos[index].isCompleted = value ?? false;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoItem {
  final String task;
  bool isCompleted;

  TodoItem({required this.task, this.isCompleted = false});
}
