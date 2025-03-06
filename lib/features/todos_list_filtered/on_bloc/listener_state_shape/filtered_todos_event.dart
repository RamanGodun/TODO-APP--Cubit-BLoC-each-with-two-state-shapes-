part of 'filtered_todos_bloc_listener_ss.dart';

sealed class FilteredTodosEventWithListenerStateShape extends Equatable {
  const FilteredTodosEventWithListenerStateShape();

  @override
  List<Object> get props => [];
}

class CalculateFilteredTodosEventWithListenerStateShape
    extends FilteredTodosEventWithListenerStateShape {
  const CalculateFilteredTodosEventWithListenerStateShape({
    required this.filteredTodos,
  });

  final List<Todo> filteredTodos;

  @override
  String toString() =>
      'CalculateFilteredTodosEvent(filteredTodos: $filteredTodos)';

  @override
  List<Object> get props => [filteredTodos];
}
