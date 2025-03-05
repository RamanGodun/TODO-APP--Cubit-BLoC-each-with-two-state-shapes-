part of 'filtered_todos_cubit.dart';

final class FilteredTodosStateWithListenerStateShape extends Equatable {
  const FilteredTodosStateWithListenerStateShape({
    required this.filteredTodos,
  });

  factory FilteredTodosStateWithListenerStateShape.initial() {
    return const FilteredTodosStateWithListenerStateShape(filteredTodos: []);
  }

  final List<Todo> filteredTodos;

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodosState(filteredTodos: $filteredTodos)';

  FilteredTodosStateWithListenerStateShape copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosStateWithListenerStateShape(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
