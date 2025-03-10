import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/todos_list/on_cubit/todo_list_cubit.dart';
import '../utils/bloc_exports.dart';
import '../app_settings_on_cubit/app_settings_cubit.dart';

/// 🏭 [TodoItemFactory] динамічно повертає потрібний [TodoItemManager]
/// в залежності від значення [isUsingBlocForAppFeatures] з [AppSettingsCubit].
class TodoItemFactory {
  static TodoItemManager create(BuildContext context) {
    final isUsingBlocForAppFeatures =
        context.read<AppSettingsCubit>().state.isUsingBlocForAppFeatures;

    return isUsingBlocForAppFeatures
        ? BlocTodoItemManager(context)
        : CubitTodoItemManager(context);
  }
}

/// 📦 [TodoItemManager] абстрактний клас для управління логікою TodoItem.
abstract class TodoItemManager {
  void editTodo(String id, String description);
  void toggleTodo(String id);
}

/// 🚦 BLoC реалізація [TodoItemManager].
class BlocTodoItemManager implements TodoItemManager {
  final BuildContext _context;

  BlocTodoItemManager(this._context);

  @override
  void editTodo(String id, String description) {
    _context.read<TodoListBloc>().add(
          EditTodoEvent(
            id: id,
            todoDesc: description,
          ),
        );
  }

  @override
  void toggleTodo(String id) {
    _context.read<TodoListBloc>().add(ToggleTodoEvent(id: id));
  }
}

/// 🚦 Cubit реалізація [TodoItemManager].
class CubitTodoItemManager implements TodoItemManager {
  final BuildContext _context;

  CubitTodoItemManager(this._context);

  @override
  void editTodo(String id, String description) {
    _context.read<TodoListCubit>().editTodo(id, description);
  }

  @override
  void toggleTodo(String id) {
    _context.read<TodoListCubit>().toggleTodo(id);
  }
}
