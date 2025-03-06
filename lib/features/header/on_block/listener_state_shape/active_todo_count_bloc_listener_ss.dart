import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBlocWithListenerStateShape extends Bloc<
    ActiveTodoCountEventWithListenerStateShape,
    ActiveTodoCountStateOnBlocWithListenerStateShape> {
  final int initialActiveTodoCount;

  ActiveTodoCountBlocWithListenerStateShape({
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountStateOnBlocWithListenerStateShape(
            activeTodoCount: initialActiveTodoCount)) {
    on<CalculateActiveTodoCountEventWithListenerStateShape>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeTodoCount));
    });
  }
}
