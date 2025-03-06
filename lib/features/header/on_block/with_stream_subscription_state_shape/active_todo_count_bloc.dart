import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/todo_model.dart';
import '../../../todos_list/on_block/todo_list_bloc.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBlocWithStreamSubscriptionStateShape extends Bloc<
    ActiveTodoCountEventWithStreamSubscriptionStateShape,
    ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape> {
  late final StreamSubscription todoListSubscription;

  final int initialActiveTodoCount;
  final TodoListBloc todoListBloc;

  ActiveTodoCountBlocWithStreamSubscriptionStateShape({
    required this.initialActiveTodoCount,
    required this.todoListBloc,
  }) : super(ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape(
            activeTodoCount: initialActiveTodoCount)) {
    todoListSubscription =
        todoListBloc.stream.listen((TodoListStateOnBloc todoListState) {
      print('todoListState: $todoListState');

      final int currentActiveTodoCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;

      add(CalculateActiveTodoCountEvent(
          activeTodoCount: currentActiveTodoCount));
    });

    on<CalculateActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
