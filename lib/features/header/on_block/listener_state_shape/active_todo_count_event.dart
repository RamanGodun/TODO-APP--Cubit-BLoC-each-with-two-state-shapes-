part of 'active_todo_count_bloc_listener_ss.dart';

sealed class ActiveTodoCountEventWithListenerStateShape extends Equatable {
  const ActiveTodoCountEventWithListenerStateShape();

  @override
  List<Object> get props => [];
}

final class CalculateActiveTodoCountEventWithListenerStateShape
    extends ActiveTodoCountEventWithListenerStateShape {
  const CalculateActiveTodoCountEventWithListenerStateShape({
    required this.activeTodoCount,
  });

  final int activeTodoCount;

  @override
  String toString() =>
      'CalculateActiveTodoCountEvent(activeTodoCount: $activeTodoCount)';

  @override
  List<Object> get props => [activeTodoCount];
}
