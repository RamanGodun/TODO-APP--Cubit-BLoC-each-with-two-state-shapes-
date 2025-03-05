import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/header/on_block/with_stream_subscription_state_shape/active_todo_count_bloc.dart';
import 'features/todos_list_filtered/on_bloc/with_stream_subscription_state_shape/filtered_todos_bloc.dart';
import 'features/todo_filter/on_bloc/todo_filter_bloc.dart';
import 'features/todos_list/on_block/todo_list_bloc.dart';
import 'features/todo_search/on_block/todo_search_bloc.dart';
import 'core/config/app_theme.dart';
import 'core/utils/cubits_export.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
/* Cubits */
        BlocProvider<TodoFilterCubit>(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider<TodoListCubit>(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape>(
          create: (context) =>
              ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape(
            initialActiveTodoCount:
                context.read<TodoListCubit>().state.todos.length,
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
        BlocProvider<ActiveTodoCountCubitWithUsingListenerStateShape>(
          create: (context) => ActiveTodoCountCubitWithUsingListenerStateShape(
            initialActiveTodoCount:
                context.read<TodoListCubit>().state.todos.length,
          ),
        ),
        BlocProvider<FilteredTodosCubitWithStreamSubscriptionStateShape>(
          create: (context) =>
              FilteredTodosCubitWithStreamSubscriptionStateShape(
            initialTodos: context.read<TodoListCubit>().state.todos,
            todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
            todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
        BlocProvider<FilteredTodosCubitWithListenerStateShape>(
          create: (context) => FilteredTodosCubitWithListenerStateShape(
            initialTodos: context.read<TodoListCubit>().state.todos,
          ),
        ),

/* BLoCs */
        BlocProvider<TodoFilterBloc>(
          create: (context) => TodoFilterBloc(),
        ),
        BlocProvider<TodoSearchBloc>(
          create: (context) => TodoSearchBloc(),
        ),
        BlocProvider<TodoListBloc>(
          create: (context) => TodoListBloc(),
        ),
        BlocProvider<ActiveTodoCountBloc>(
          create: (context) => ActiveTodoCountBloc(
            initialActiveTodoCount:
                context.read<TodoListBloc>().state.todos.length,
            todoListBloc: BlocProvider.of<TodoListBloc>(context),
          ),
        ),
        BlocProvider<FilteredTodosBloc>(
          create: (context) => FilteredTodosBloc(
            initialTodos: context.read<TodoListBloc>().state.todos,
            todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
            todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context),
            todoListBloc: BlocProvider.of<TodoListBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.darkTheme,
        home: const HomePage(),
      ),
    );
  }
}
