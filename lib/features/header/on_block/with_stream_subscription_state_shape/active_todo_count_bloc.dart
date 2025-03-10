import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/domain/models/todo_model.dart';
import '../../../todos_list/on_block/todo_list_bloc.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBlocWithStreamSubscriptionStateShape extends Bloc<
    ActiveTodoCountEventWithStreamSubscriptionStateShape,
    ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape> {
  final TodoListBloc todoListBloc;

  ActiveTodoCountBlocWithStreamSubscriptionStateShape({
    required this.todoListBloc,
    required int initialActiveTodoCount,
  }) : super(ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape(
            activeTodoCount: initialActiveTodoCount)) {
    _calculateInitialActiveTodos(todoListBloc.state);

    todoListBloc.stream.listen((TodoListStateOnBloc todoListState) {
      final int currentActiveTodoCount =
          todoListState.todos.where((Todo todo) => !todo.completed).length;

      add(CalculateActiveTodoCountEvent(
          activeTodoCount: currentActiveTodoCount));
    });

    on<CalculateActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeTodoCount));
    });
  }

  void _calculateInitialActiveTodos(TodoListStateOnBloc todoListState) {
    final int currentActiveTodoCount =
        todoListState.todos.where((Todo todo) => !todo.completed).length;

    add(CalculateActiveTodoCountEvent(activeTodoCount: currentActiveTodoCount));
  }
}
