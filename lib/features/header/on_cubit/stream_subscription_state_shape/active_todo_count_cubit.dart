import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/models/todo_model.dart';
import '../../../todos_list/on_cubit/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape extends Cubit<
    ActiveTodoCountStateOnCubitWithUsingStreamSubscriptionStateShape> {
  late final StreamSubscription todoListSubscription;

  final int initialActiveTodoCount;
  final TodoListCubit todoListCubit;

  ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape({
    required this.initialActiveTodoCount,
    required this.todoListCubit,
  }) : super(ActiveTodoCountStateOnCubitWithUsingStreamSubscriptionStateShape(
            activeTodoCount: initialActiveTodoCount)) {
    todoListSubscription =
        todoListCubit.stream.listen((TodoListStateOnCubit todoListState) {
      print('todoListState: $todoListState');

      final int currentActiveTodoCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;

      emit(state.copyWith(activeTodoCount: currentActiveTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
