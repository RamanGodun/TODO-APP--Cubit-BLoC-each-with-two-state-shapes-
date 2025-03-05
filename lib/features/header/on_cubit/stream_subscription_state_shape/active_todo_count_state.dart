part of 'active_todo_count_cubit.dart';

final class ActiveTodoCountStateWithUsingStreamSubscriptionStateShape
    extends Equatable {
  const ActiveTodoCountStateWithUsingStreamSubscriptionStateShape({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountStateWithUsingStreamSubscriptionStateShape.initial() {
    return const ActiveTodoCountStateWithUsingStreamSubscriptionStateShape(
        activeTodoCount: 0);
  }

  final int activeTodoCount;

  @override
  List<Object> get props => [activeTodoCount];

  @override
  String toString() =>
      'ActiveTodoCountState(activeTodoCount: $activeTodoCount)';

  ActiveTodoCountStateWithUsingStreamSubscriptionStateShape copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountStateWithUsingStreamSubscriptionStateShape(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}
