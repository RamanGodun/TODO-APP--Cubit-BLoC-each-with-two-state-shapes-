part of 'todo_filter_bloc.dart';

final class TodoFilterStateOnBloc extends Equatable {
  const TodoFilterStateOnBloc({
    required this.filter,
  });

  factory TodoFilterStateOnBloc.initial() {
    return const TodoFilterStateOnBloc(filter: Filter.all);
  }

  final Filter filter;

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'TodoFilterState(filter: $filter)';

  TodoFilterStateOnBloc copyWith({
    Filter? filter,
  }) {
    return TodoFilterStateOnBloc(
      filter: filter ?? this.filter,
    );
  }
}
