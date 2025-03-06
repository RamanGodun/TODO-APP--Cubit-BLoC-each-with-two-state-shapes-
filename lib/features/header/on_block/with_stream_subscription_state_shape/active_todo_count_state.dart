part of 'active_todo_count_bloc.dart';

final class ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape
    extends Equatable {
  const ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape.initial() {
    return const ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape(
        activeTodoCount: 0);
  }

  final int activeTodoCount;

  @override
  List<Object> get props => [activeTodoCount];

  @override
  String toString() =>
      'ActiveTodoCountState(activeTodoCount: $activeTodoCount)';

  ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}
