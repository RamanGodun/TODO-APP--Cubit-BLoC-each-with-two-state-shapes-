part of 'active_todo_count_bloc_listener_ss.dart';

final class ActiveTodoCountStateOnBlocWithListenerStateShape extends Equatable {
  const ActiveTodoCountStateOnBlocWithListenerStateShape({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountStateOnBlocWithListenerStateShape.initial() {
    return const ActiveTodoCountStateOnBlocWithListenerStateShape(
        activeTodoCount: 0);
  }

  final int activeTodoCount;

  @override
  List<Object> get props => [activeTodoCount];

  @override
  String toString() =>
      'ActiveTodoCountState(activeTodoCount: $activeTodoCount)';

  ActiveTodoCountStateOnBlocWithListenerStateShape copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountStateOnBlocWithListenerStateShape(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}
