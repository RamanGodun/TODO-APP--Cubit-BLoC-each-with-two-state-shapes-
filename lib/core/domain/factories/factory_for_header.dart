import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_settings_on_cubit/app_settings_cubit.dart';
import '../models/todo_model.dart';
import '../utils/bloc_exports.dart';
import '../utils/cubits_export.dart';
import '../../../presentation/widgets/text_widget.dart';

/// 🏭 [TodoHeaderFactory] динамічно повертає потрібний [TodoHeaderManager]
/// в залежності від значення [isUsingBlocForAppFeatures] з [AppSettingsCubit].
class TodoHeaderFactory {
  static TodoHeaderManager create(BuildContext context) {
    final isUsingBlocForAppFeatures =
        context.read<AppSettingsCubit>().state.isUsingBlocForAppFeatures;

    return isUsingBlocForAppFeatures
        ? BlocTodoHeaderManager(context)
        : CubitTodoHeaderManager(context);
  }
}

/// 🔢 [TodoHeaderManager] визначає абстрактний інтерфейс для управління текстом заголовка.
/// Підтримує як BLoC, так і Cubit стратегії управління станом.
abstract class TodoHeaderManager {
  Widget buildHeaderText();
}

/// 🚦 BLoC реалізація [TodoHeaderManager].
class BlocTodoHeaderManager implements TodoHeaderManager {
  final BuildContext _context;

  BlocTodoHeaderManager(this._context);

  @override
  Widget buildHeaderText() {
    return BlocListener<TodoListBloc, TodoListStateOnBloc>(
      listener: (context, state) {
        final int activeTodoCount =
            state.todos.where((Todo todo) => !todo.completed).toList().length;

        context.read<ActiveTodoCountBlocWithListenerStateShape>().add(
              CalculateActiveTodoCountEventWithListenerStateShape(
                activeTodoCount: activeTodoCount,
              ),
            );
      },
      child: TextWidget(
        '${_context.watch<ActiveTodoCountBlocWithListenerStateShape>().state.activeTodoCount} items left',
        TextType.titleMedium,
      ),
    );
  }
}

/// 🚦 Cubit реалізація [TodoHeaderManager].
class CubitTodoHeaderManager implements TodoHeaderManager {
  final BuildContext _context;

  CubitTodoHeaderManager(this._context);

  @override
  Widget buildHeaderText() {
    return TextWidget(
      '${_context.watch<ActiveTodoCountCubitWithUsingListenerStateShape>().state.activeTodoCount} items left',
      TextType.titleMedium,
    );
  }
}
