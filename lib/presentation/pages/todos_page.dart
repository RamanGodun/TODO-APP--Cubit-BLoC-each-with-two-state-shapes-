import 'package:flutter/material.dart';

import '../../features/todo_list/presentation/create_todo.dart';
import '../../features/todo_search/presentation/search_and_filter_todo.dart';
import '../../features/todo_list/presentation/show_todos.dart';
import '../../features/active_todo_count/presentation/todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 40.0,
            ),
            child: Column(
              children: [
                const TodoHeader(),
                const CreateTodo(),
                const SizedBox(height: 20.0),
                SearchAndFilterTodo(),
                const ShowTodos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
