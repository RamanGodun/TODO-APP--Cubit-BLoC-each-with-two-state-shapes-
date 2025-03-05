part of 'filtered_todos_cubit.dart';

final class FilteredTodosStateWithStreamSubscriptionStateShape
    extends Equatable {
  const FilteredTodosStateWithStreamSubscriptionStateShape({
    required this.filteredTodos,
  });

  factory FilteredTodosStateWithStreamSubscriptionStateShape.initial() {
    return const FilteredTodosStateWithStreamSubscriptionStateShape(
        filteredTodos: []);
  }

  final List<Todo> filteredTodos;

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodosState(filteredTodos: $filteredTodos)';

  FilteredTodosStateWithStreamSubscriptionStateShape copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosStateWithStreamSubscriptionStateShape(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
