import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_app/controllers/todo_provider.dart';
import 'package:provider_todo_app/models/todo.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController _todoTitleController = TextEditingController();
  TextEditingController _todoDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  children: [
                    TextField(
                      controller: _todoTitleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        hintText: 'Add Todo title',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _todoDescriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        hintText: 'Add Todo description',
                      ),
                    ),
                    Consumer<TodoProvider>(
                      builder: (_, todoProvider, child) {
                        return TextButton(
                          onPressed: () {
                            if (_todoTitleController.text.trim() != "" &&
                                _todoDescriptionController.text.trim() != "") {
                              Todo todo = Todo(
                                  title: _todoTitleController.text.trim(),
                                  description:
                                      _todoDescriptionController.text.trim());
                              todoProvider.addTodo(todo);
                              _todoTitleController.clear();
                              _todoDescriptionController.clear();
                            } else {
                              print('cannot add empty todo');
                            }
                          },
                          child: Text('Add Todo'),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                child: Expanded(
                  child: Center(
                    child: Consumer<TodoProvider>(
                      builder: (context, todoProvider, child) {
                        var todos = todoProvider.todos;

                        return todos.isEmpty
                            ? Text('You have not added any todo')
                            : Column(
                                children: [
                                  Text('Tap on each todo to toggle completion'),
                                  SizedBox(height: 20,),
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        Todo currentTodo = todos[index];
                                        return Card(
                                          child: GestureDetector(
                                            onTap: () {
                                              currentTodo.isCompleted =
                                                  !currentTodo.isCompleted;
                                              todoProvider.toggleTodoCompletion(
                                                  currentTodo);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(20),
                                              
                                              color: currentTodo.isCompleted
                                                  ? Colors.greenAccent
                                                  : Colors.red,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text(currentTodo.title),
                                                        SizedBox(height: 10),
                                                        Text(currentTodo
                                                            .description),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  GestureDetector(
                                                    onTap: () {
                                                      todoProvider.deleteTodo(
                                                          currentTodo);
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: todoProvider.todos.length,
                                    ),
                                  ),
                                ],
                              );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
