part of 'filtered_todos_bloc_listener_ss.dart';

final class FilteredTodosStateOnBlocWithListenerStateShape extends Equatable {
  const FilteredTodosStateOnBlocWithListenerStateShape({
    required this.filteredTodos,
  });

  factory FilteredTodosStateOnBlocWithListenerStateShape.initial() {
    return const FilteredTodosStateOnBlocWithListenerStateShape(
        filteredTodos: []);
  }

  final List<Todo> filteredTodos;

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodosState(filteredTodos: $filteredTodos)';

  FilteredTodosStateOnBlocWithListenerStateShape copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosStateOnBlocWithListenerStateShape(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
