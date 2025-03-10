import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_settings_on_cubit/app_settings_cubit.dart';
import '../models/todo_model.dart';
import '../utils/bloc_exports.dart';
import '../utils/cubits_export.dart';

/// 🏭 [ShowTodosFactory] динамічно повертає потрібний [ShowTodosManager]
/// в залежності від значення [isUsingBlocForAppFeatures] з [AppSettingsCubit].
class ShowTodosFactory {
  static ShowTodosManager create(BuildContext context) {
    final isUsingBlocForAppFeatures =
        context.read<AppSettingsCubit>().state.isUsingBlocForAppFeatures;

    return isUsingBlocForAppFeatures
        ? BlocShowTodosManager(context)
        : CubitShowTodosManager(context);
  }
}

/// 📦 [ShowTodosManager] абстрактний клас для управління логікою відображення списку Todo.
abstract class ShowTodosManager {
  List<Todo> getTodos();

  void removeTodo(Todo todo);
}

/// 🚦 BLoC реалізація [ShowTodosManager].
class BlocShowTodosManager implements ShowTodosManager {
  final BuildContext _context;

  BlocShowTodosManager(this._context);

  @override
  List<Todo> getTodos() {
    return _context
        .watch<FilteredTodosBlocWithStreamSubscriptionStateShape>()
        .state
        .filteredTodos;
  }

  @override
  void removeTodo(Todo todo) {
    _context.read<TodoListBloc>().add(RemoveTodoEvent(todo: todo));
  }
}

/// 🚦 Cubit реалізація [ShowTodosManager].
class CubitShowTodosManager implements ShowTodosManager {
  final BuildContext _context;

  CubitShowTodosManager(this._context);

  @override
  List<Todo> getTodos() {
    return _context
        .watch<FilteredTodosCubitWithStreamSubscriptionStateShape>()
        .state
        .filteredTodos;
  }

  @override
  void removeTodo(Todo todo) {
    _context.read<TodoListCubit>().removeTodo(todo);
  }
}
