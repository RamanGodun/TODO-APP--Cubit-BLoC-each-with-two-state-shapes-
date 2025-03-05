import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_theme.dart';
import 'features/active_todo_count/active_todo_count_cubit.dart';
import 'features/filtered_todos/filtered_todos_cubit.dart';
import 'features/todo_filter/todo_filter_cubit.dart';
import 'features/todo_list/todo_list_cubit.dart';
import 'features/todo_search/todo_search_cubit.dart';
import 'presentation/pages/todos_page/todos_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterCubit>(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider<TodoListCubit>(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubit>(
          create: (context) => ActiveTodoCountCubit(
            initialActiveTodoCount:
                context.read<TodoListCubit>().state.todos.length,
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
        BlocProvider<FilteredTodosCubit>(
          create: (context) => FilteredTodosCubit(
            initialTodos: context.read<TodoListCubit>().state.todos,
            todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
            todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.darkTheme,
        home: const TodosPage(),
      ),
    );
  }
}
