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
  }) : super(ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape(
          activeTodoCount: _calculateInitialActiveTodos(todoListBloc.state),
        )) {
    on<CalculateActiveTodoCountEvent>(_onCalculate);

    todoListBloc.stream.listen((TodoListStateOnBloc todoListState) {
      final int currentActiveTodoCount =
          todoListState.todos.where((Todo todo) => !todo.completed).length;

      if (currentActiveTodoCount != state.activeTodoCount) {
        add(CalculateActiveTodoCountEvent(
            activeTodoCount: currentActiveTodoCount));
      }
    });
  }

  static int _calculateInitialActiveTodos(TodoListStateOnBloc todoListState) {
    return todoListState.todos.where((Todo todo) => !todo.completed).length;
  }

  void _onCalculate(
    CalculateActiveTodoCountEvent event,
    Emitter<ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape> emit,
  ) {
    emit(state.copyWith(activeTodoCount: event.activeTodoCount));
  }
}
