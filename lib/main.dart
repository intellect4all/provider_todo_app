import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_app/controllers/todo_provider.dart';
import 'package:provider_todo_app/views/home.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => TodoProvider(),
        child: HomeScreen(),
      ),
    ),
  );
}
