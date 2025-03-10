import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_settings_on_cubit/app_settings_cubit.dart';
import '../models/todo_model.dart';
import '../utils/bloc_exports.dart';
import '../utils/cubits_export.dart';

/// 🏭 [ShowTodosWithListenerFactory] динамічно повертає потрібний [ShowTodosWithListenerManager]
/// в залежності від значення [isUsingBlocForAppFeatures] з [AppSettingsCubit].
class ShowTodosWithListenerFactory {
  static ShowTodosWithListenerManager create(BuildContext context) {
    final isUsingBlocForAppFeatures =
        context.read<AppSettingsCubit>().state.isUsingBlocForAppFeatures;

    return isUsingBlocForAppFeatures
        ? BlocShowTodosWithListenerManager(context)
        : CubitShowTodosWithListenerManager(context);
  }
}

/// 📦 [ShowTodosWithListenerManager] абстрактний клас для управління логікою відображення списку Todo.
abstract class ShowTodosWithListenerManager {
  List<Todo> getTodos();

  void removeTodo(Todo todo);

  void setupListeners();
}

/// 🚦 BLoC реалізація [ShowTodosWithListenerManager].
class BlocShowTodosWithListenerManager implements ShowTodosWithListenerManager {
  final BuildContext _context;

  BlocShowTodosWithListenerManager(this._context);

  @override
  List<Todo> getTodos() {
    return _context
        .watch<FilteredTodosBlocWithListenerStateShape>()
        .state
        .filteredTodos;
  }

  @override
  void removeTodo(Todo todo) {
    _context.read<TodoListBloc>().add(RemoveTodoEvent(todo: todo));
  }

  @override
  void setupListeners() {
    // BLoC Listeners для оновлення фільтрованих Todos
    BlocListener<TodoListBloc, TodoListStateOnBloc>(
      listener: (context, state) {
        final filteredTodos = _setFilteredTodos(
          context.read<TodoFilterBloc>().state.filter,
          state.todos,
          context.read<TodoSearchBloc>().state.searchTerm,
        );
        context.read<FilteredTodosBlocWithListenerStateShape>().add(
            CalculateFilteredTodosEventWithListenerStateShape(
                filteredTodos: filteredTodos));
      },
    );

    BlocListener<TodoFilterBloc, TodoFilterStateOnBloc>(
      listener: (context, state) {
        final filteredTodos = _setFilteredTodos(
          state.filter,
          context.read<TodoListBloc>().state.todos,
          context.read<TodoSearchBloc>().state.searchTerm,
        );
        context.read<FilteredTodosBlocWithListenerStateShape>().add(
            CalculateFilteredTodosEventWithListenerStateShape(
                filteredTodos: filteredTodos));
      },
    );

    BlocListener<TodoSearchBloc, TodoSearchStateOnBloc>(
      listener: (context, state) {
        final filteredTodos = _setFilteredTodos(
          context.read<TodoFilterBloc>().state.filter,
          context.read<TodoListBloc>().state.todos,
          state.searchTerm,
        );
        context.read<FilteredTodosBlocWithListenerStateShape>().add(
            CalculateFilteredTodosEventWithListenerStateShape(
                filteredTodos: filteredTodos));
      },
    );
  }

  List<Todo> _setFilteredTodos(
    Filter filter,
    List<Todo> todos,
    String searchTerm,
  ) {
    List<Todo> filteredTodos;

    switch (filter) {
      case Filter.active:
        filteredTodos = todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        filteredTodos = todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
        filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
    return filteredTodos;
  }
}

/// 🚦 Cubit реалізація [ShowTodosWithListenerManager].
class CubitShowTodosWithListenerManager
    implements ShowTodosWithListenerManager {
  final BuildContext _context;

  CubitShowTodosWithListenerManager(this._context);

  @override
  List<Todo> getTodos() {
    return _context
        .watch<FilteredTodosCubitWithListenerStateShape>()
        .state
        .filteredTodos;
  }

  @override
  void removeTodo(Todo todo) {
    _context.read<TodoListCubit>().removeTodo(todo);
  }

  @override
  void setupListeners() {
    BlocListener<TodoListCubit, TodoListStateOnCubit>(
      listener: (context, state) {
        context
            .read<FilteredTodosCubitWithListenerStateShape>()
            .setFilteredTodos(
              context.read<TodoFilterCubit>().state.filter,
              state.todos,
              context.read<TodoSearchCubit>().state.searchTerm,
            );
      },
    );

    BlocListener<TodoFilterCubit, TodoFilterStateOnCubit>(
      listener: (context, state) {
        context
            .read<FilteredTodosCubitWithListenerStateShape>()
            .setFilteredTodos(
              state.filter,
              context.read<TodoListCubit>().state.todos,
              context.read<TodoSearchCubit>().state.searchTerm,
            );
      },
    );

    BlocListener<TodoSearchCubit, TodoSearchStateOnCubit>(
      listener: (context, state) {
        context
            .read<FilteredTodosCubitWithListenerStateShape>()
            .setFilteredTodos(
              context.read<TodoFilterCubit>().state.filter,
              context.read<TodoListCubit>().state.todos,
              state.searchTerm,
            );
      },
    );
  }
}
