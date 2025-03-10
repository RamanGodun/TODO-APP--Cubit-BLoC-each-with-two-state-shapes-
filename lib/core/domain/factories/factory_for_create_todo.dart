import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_settings_on_cubit/app_settings_cubit.dart';
import '../utils/bloc_exports.dart';
import '../utils/cubits_export.dart';

/// 🏭 [CreateTodoFactory] динамічно повертає потрібний [CreateTodoManager]
/// в залежності від значення [isUsingBlocForAppFeatures] з [AppSettingsCubit].
class CreateTodoFactory {
  static CreateTodoManager create(BuildContext context) {
    final isUsingBlocForAppFeatures =
        context.read<AppSettingsCubit>().state.isUsingBlocForAppFeatures;

    return isUsingBlocForAppFeatures
        ? BlocCreateTodoManager(context)
        : CubitCreateTodoManager(context);
  }
}

/// 🔢 [CreateTodoManager] визначає абстрактний інтерфейс для управління створенням [TODO]
/// Підтримує як BLoC, так і Cubit стратегії управління станом.
abstract class CreateTodoManager {
  void addTodo(String todoDesc);
}

/// 🚦 BLoC реалізація [CreateTodoManager].
class BlocCreateTodoManager implements CreateTodoManager {
  final BuildContext _context;

  BlocCreateTodoManager(this._context);

  @override
  void addTodo(String todoDesc) {
    _context.read<TodoListBloc>().add(AddTodoEvent(todoDesc: todoDesc));
  }
}

/// 🚦 Cubit реалізація [CreateTodoManager].
class CubitCreateTodoManager implements CreateTodoManager {
  final BuildContext _context;

  CubitCreateTodoManager(this._context);

  @override
  void addTodo(String todoDesc) {
    _context.read<TodoListCubit>().addTodo(todoDesc);
  }
}
