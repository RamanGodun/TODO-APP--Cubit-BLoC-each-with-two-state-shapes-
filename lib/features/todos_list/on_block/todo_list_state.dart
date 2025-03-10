part of 'todo_list_bloc.dart';

final class TodoListStateOnBloc extends Equatable {
  const TodoListStateOnBloc({
    required this.todos,
  });

  factory TodoListStateOnBloc.initial() {
    return const TodoListStateOnBloc(todos: [
      // Todo(id: '1', desc: 'Clean the room'),
      // Todo(id: '2', desc: 'Wash the dish'),
      // Todo(id: '3', desc: 'Do homework'),
    ]);
  }

  final List<Todo> todos;

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodoListState(todos: $todos)';

  TodoListStateOnBloc copyWith({
    List<Todo>? todos,
  }) {
    return TodoListStateOnBloc(
      todos: todos ?? this.todos,
    );
  }
}
