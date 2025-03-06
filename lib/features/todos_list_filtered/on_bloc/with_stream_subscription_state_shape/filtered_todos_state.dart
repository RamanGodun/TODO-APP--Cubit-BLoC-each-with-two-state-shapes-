part of 'filtered_todos_bloc.dart';

final class FilteredTodosStateOnBlocWithStreamSubscriptionStateShape
    extends Equatable {
  const FilteredTodosStateOnBlocWithStreamSubscriptionStateShape({
    required this.filteredTodos,
  });

  factory FilteredTodosStateOnBlocWithStreamSubscriptionStateShape.initial() {
    return const FilteredTodosStateOnBlocWithStreamSubscriptionStateShape(
        filteredTodos: []);
  }

  final List<Todo> filteredTodos;

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodosState(filteredTodos: $filteredTodos)';

  FilteredTodosStateOnBlocWithStreamSubscriptionStateShape copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosStateOnBlocWithStreamSubscriptionStateShape(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
