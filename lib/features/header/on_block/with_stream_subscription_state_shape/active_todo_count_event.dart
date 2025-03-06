part of 'active_todo_count_bloc.dart';

sealed class ActiveTodoCountEventWithStreamSubscriptionStateShape
    extends Equatable {
  const ActiveTodoCountEventWithStreamSubscriptionStateShape();

  @override
  List<Object> get props => [];
}

final class CalculateActiveTodoCountEvent
    extends ActiveTodoCountEventWithStreamSubscriptionStateShape {
  const CalculateActiveTodoCountEvent({
    required this.activeTodoCount,
  });

  final int activeTodoCount;

  @override
  String toString() =>
      'CalculateActiveTodoCountEvent(activeTodoCount: $activeTodoCount)';

  @override
  List<Object> get props => [activeTodoCount];
}
