import 'package:flutter/cupertino.dart';
import 'package:provider_todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todosList = [];

  List<Todo> get todos => _todosList;

  void addTodo(Todo todo) {
    _todosList.add(todo);
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    _todosList.removeWhere((element) =>
        todo.description == element.description && todo.title == element.title);
    notifyListeners();
  }

  void toggleTodoCompletion(Todo todo) {
    int index = _todosList.indexWhere((element) =>
        todo.description == element.description && todo.title == element.title);
    print(index);
    _todosList.removeAt(index);
    _todosList.insert(index, todo);

    notifyListeners();
  }
}
