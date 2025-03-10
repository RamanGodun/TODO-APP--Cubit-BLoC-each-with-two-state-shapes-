import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/domain/models/todo_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc
    extends HydratedBloc<TodoListEventOnBloc, TodoListStateOnBloc> {
  TodoListBloc() : super(TodoListStateOnBloc.initial()) {
    on<AddTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleTodoEvent>(_toggleTodo);
    on<RemoveTodoEvent>(_removeTodo);
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoListStateOnBloc> emit) {
    final newTodo = Todo(desc: event.todoDesc);
    final newTodos = [...state.todos, newTodo];
    emit(state.copyWith(todos: newTodos));
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoListStateOnBloc> emit) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
          id: event.id,
          desc: event.todoDesc,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoListStateOnBloc> emit) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
          id: event.id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoListStateOnBloc> emit) {
    final newTodos =
        state.todos.where((Todo t) => t.id != event.todo.id).toList();
    emit(state.copyWith(todos: newTodos));
  }

  @override
  TodoListStateOnBloc? fromJson(Map<String, dynamic> json) {
    try {
      final todos = (json['todos'] as List<dynamic>?)
          ?.map((e) => Todo.fromMap(e as Map<String, dynamic>))
          .whereType<Todo>()
          .toList();
      return todos != null && todos.isNotEmpty
          ? TodoListStateOnBloc(todos: todos)
          : TodoListStateOnBloc.initial();
    } catch (_) {
      return TodoListStateOnBloc.initial();
    }
  }

  @override
  Map<String, dynamic>? toJson(TodoListStateOnBloc state) {
    try {
      return {'todos': state.todos.map((e) => e.toMap()).toList()};
    } catch (_) {
      return null;
    }
  }
}
