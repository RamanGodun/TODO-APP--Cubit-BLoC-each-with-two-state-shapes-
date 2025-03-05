part of 'active_todo_count_cubit_listener_ss.dart';

final class ActiveTodoCountStateWithUsingListenerStateShape extends Equatable {
  const ActiveTodoCountStateWithUsingListenerStateShape({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountStateWithUsingListenerStateShape.initial() {
    return const ActiveTodoCountStateWithUsingListenerStateShape(
        activeTodoCount: 0);
  }

  final int activeTodoCount;

  @override
  List<Object> get props => [activeTodoCount];

  @override
  String toString() =>
      'ActiveTodoCountState(activeTodoCount: $activeTodoCount)';

  ActiveTodoCountStateWithUsingListenerStateShape copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountStateWithUsingListenerStateShape(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}
