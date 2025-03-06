part of 'filtered_todos_bloc.dart';

sealed class FilteredTodosEventWithStreamSubscriptionStateShape
    extends Equatable {
  const FilteredTodosEventWithStreamSubscriptionStateShape();

  @override
  List<Object> get props => [];
}

class CalculateFilteredTodosEvent
    extends FilteredTodosEventWithStreamSubscriptionStateShape {
  const CalculateFilteredTodosEvent({
    required this.filteredTodos,
  });

  final List<Todo> filteredTodos;

  @override
  String toString() =>
      'CalculateFilteredTodosEvent(filteredTodos: $filteredTodos)';

  @override
  List<Object> get props => [filteredTodos];
}
