part of 'todo_search_bloc.dart';

final class TodoSearchStateOnBloc extends Equatable {
  const TodoSearchStateOnBloc({
    required this.searchTerm,
  });

  factory TodoSearchStateOnBloc.initial() {
    return const TodoSearchStateOnBloc(searchTerm: '');
  }

  final String searchTerm;

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'TodoSearchState(searchTerm: $searchTerm)';

  TodoSearchStateOnBloc copyWith({
    String? searchTerm,
  }) {
    return TodoSearchStateOnBloc(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
