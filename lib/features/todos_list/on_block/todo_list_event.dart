part of 'todo_list_bloc.dart';

sealed class TodoListEventOnBloc extends Equatable {
  const TodoListEventOnBloc();

  @override
  List<Object> get props => [];
}

final class AddTodoEvent extends TodoListEventOnBloc {
  const AddTodoEvent({
    required this.todoDesc,
  });

  final String todoDesc;

  @override
  String toString() => 'AddTodoEvent(todoDesc: $todoDesc)';

  @override
  List<Object> get props => [todoDesc];
}

final class EditTodoEvent extends TodoListEventOnBloc {
  const EditTodoEvent({
    required this.id,
    required this.todoDesc,
  });

  final String id;
  final String todoDesc;

  @override
  String toString() => 'EditTodoEvent(id: $id, todoDesc: $todoDesc)';

  @override
  List<Object> get props => [id, todoDesc];
}

final class ToggleTodoEvent extends TodoListEventOnBloc {
  const ToggleTodoEvent({
    required this.id,
  });

  final String id;

  @override
  String toString() => 'ToggleTodoEvent(id: $id)';

  @override
  List<Object> get props => [id];
}

final class RemoveTodoEvent extends TodoListEventOnBloc {
  const RemoveTodoEvent({
    required this.todo,
  });

  final Todo todo;

  @override
  String toString() => 'RemoveTodoEvent(todo: $todo)';

  @override
  List<Object> get props => [todo];
}
