import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'active_todo_count_state_listener_ss.dart';

class ActiveTodoCountCubitWithUsingListenerStateShape
    extends Cubit<ActiveTodoCountStateWithUsingListenerStateShape> {
  final int initialActiveTodoCount;

  ActiveTodoCountCubitWithUsingListenerStateShape({
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountStateWithUsingListenerStateShape(
            activeTodoCount: initialActiveTodoCount));

  void calculateActiveTodoCount(int activeTodoCount) {
    emit(state.copyWith(activeTodoCount: activeTodoCount));
  }
}
