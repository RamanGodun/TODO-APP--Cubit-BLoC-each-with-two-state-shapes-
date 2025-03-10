/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/models/todo_model.dart';
import '../core/utils/bloc_exports.dart'; // ! when using BLoC
// import '../../core/utils/cubits_export.dart'; // ! when using CUBIT

// !Next is with Listener state shape
class ShowTodosWithListenerStateShape extends StatelessWidget {
  const ShowTodosWithListenerStateShape({super.key});

// ! when using BLoC
  List<Todo> setFilteredTodos(
    Filter filter,
    List<Todo> todos,
    String searchTerm,
  ) {
    List<Todo> filteredTodos;

    switch (filter) {
      case Filter.active:
        filteredTodos = todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        filteredTodos = todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
        filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
    return filteredTodos;
  }
// ! till this point when using BLoC (when Cubit this code absent)

  @override
  Widget build(BuildContext context) {
    // final todos = context
    //     .watch<FilteredTodosCubitWithListenerStateShape>()
    //     .state
    //     .filteredTodos; // ! when using CUBIT
    final todos = context
        .watch<FilteredTodosBlocWithListenerStateShape>()
        .state
        .filteredTodos; // ! when using BLoC

    return MultiBlocListener(
      listeners: [
// ! when using CUBIT
        // BlocListener<TodoListCubit, TodoListStateOnCubit>(
        //   listener: (context, state) {
        //     context
        //         .read<FilteredTodosCubitWithListenerStateShape>()
        //         .setFilteredTodos(
        //           context.read<TodoFilterCubit>().state.filter,
        //           state.todos,
        //           context.read<TodoSearchCubit>().state.searchTerm,
        //         );
        //   },
        // ),
        // BlocListener<TodoFilterCubit, TodoFilterStateOnCubit>(
        //   listener: (context, state) {
        //     context
        //         .read<FilteredTodosCubitWithListenerStateShape>()
        //         .setFilteredTodos(
        //           state.filter,
        //           context.read<TodoListCubit>().state.todos,
        //           context.read<TodoSearchCubit>().state.searchTerm,
        //         );
        //   },
        // ),
        // BlocListener<TodoSearchCubit, TodoSearchStateOnCubit>(
        //   listener: (context, state) {
        //     context
        //         .read<FilteredTodosCubitWithListenerStateShape>()
        //         .setFilteredTodos(
        //           context.read<TodoFilterCubit>().state.filter,
        //           context.read<TodoListCubit>().state.todos,
        //           state.searchTerm,
        //         );
        //   },
        // ),
        // ! when using BLoC
        BlocListener<TodoListBloc, TodoListStateOnBloc>(
          listener: (context, state) {
            final filteredTodos = setFilteredTodos(
              context.read<TodoFilterBloc>().state.filter,
              state.todos,
              context.read<TodoSearchBloc>().state.searchTerm,
            );
            context.read<FilteredTodosBlocWithListenerStateShape>().add(
                CalculateFilteredTodosEventWithListenerStateShape(
                    filteredTodos: filteredTodos));
          },
        ),
        BlocListener<TodoFilterBloc, TodoFilterStateOnBloc>(
          listener: (context, state) {
            final filteredTodos = setFilteredTodos(
              state.filter,
              context.read<TodoListBloc>().state.todos,
              context.read<TodoSearchBloc>().state.searchTerm,
            );
            context.read<FilteredTodosBlocWithListenerStateShape>().add(
                CalculateFilteredTodosEventWithListenerStateShape(
                    filteredTodos: filteredTodos));
          },
        ),
        BlocListener<TodoSearchBloc, TodoSearchStateOnBloc>(
          listener: (context, state) {
            final filteredTodos = setFilteredTodos(
              context.read<TodoFilterBloc>().state.filter,
              context.read<TodoListBloc>().state.todos,
              state.searchTerm,
            );
            context.read<FilteredTodosBlocWithListenerStateShape>().add(
                CalculateFilteredTodosEventWithListenerStateShape(
                    filteredTodos: filteredTodos));
          },
        ),
      ],
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: todos.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(color: Colors.grey);
        },
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(todos[index].id),
            background: showBackground(0),
            secondaryBackground: showBackground(1),
            onDismissed: (_) {
              // context
              //     .read<TodoListCubit>()
              //     .removeTodo(todos[index]); // ! when using CUBIT
              context.read<TodoListBloc>().add(
                  RemoveTodoEvent(todo: todos[index])); // ! when using BLoC
            },
            confirmDismiss: (_) {
              return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Do you really want to delete?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('NO'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('YES'),
                      ),
                    ],
                  );
                },
              );
            },
            child: TodoItemForListenerStaeShape(todo: todos[index]),
          );
        },
      ),
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class TodoItemForListenerStaeShape extends StatefulWidget {
  const TodoItemForListenerStaeShape({
    required this.todo,
    super.key,
  });

  final Todo todo;

  @override
  State<TodoItemForListenerStaeShape> createState() =>
      _TodoItemForListenerStaeShapeState();
}

class _TodoItemForListenerStaeShapeState
    extends State<TodoItemForListenerStaeShape> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool error = false;
            textController.text = widget.todo.desc;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Edit Todo'),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: error ? "Value cannot be empty" : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          error = textController.text.isEmpty ? true : false;
                          if (!error) {
// ! when using CUBIT
                            // context.read<TodoListCubit>().editTodo(
                            //       widget.todo.id,
                            //       textController.text,
                            //     );
// ! when using BLoC
                            context.read<TodoListBloc>().add(
                                  EditTodoEvent(
                                    id: widget.todo.id,
                                    todoDesc: textController.text,
                                  ),
                                );
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: const Text('EDIT'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
// ! when using CUBIT
          // context.read<TodoListCubit>().toggleTodo(widget.todo.id);
// ! when using BLoC
          context.read<TodoListBloc>().add(ToggleTodoEvent(id: widget.todo.id));
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}

// !Next is with stream subscription state shape

class ShowTodosForStreamSubscriptionStateShape extends StatelessWidget {
  const ShowTodosForStreamSubscriptionStateShape({super.key});

  @override
  Widget build(BuildContext context) {
    // final todos = context
    //     .watch<FilteredTodosCubitWithStreamSubscriptionStateShape>()
    //     .state
    //     .filteredTodos; // ! when using CUBIT
    final todos = context
        .watch<FilteredTodosBlocWithStreamSubscriptionStateShape>()
        .state
        .filteredTodos; // ! when using BLoC

    return ListView.separated(
      // ? next two is the alternative using Expanded widget to avoid "unconstrained..." bug
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.grey);
      },
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: ValueKey(todos[index].id),
          background: showBackground(0),
          secondaryBackground: showBackground(1),
// ! when using CUBIT
          // onDismissed: (_) {
          //   context.read<TodoListCubit>().removeTodo(todos[index]);
          // },
// ! when using BLoC
          onDismissed: (_) {
            context
                .read<TodoListBloc>()
                .add(RemoveTodoEvent(todo: todos[index]));
          },
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Do you really want to delete?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('NO'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('YES'),
                    ),
                  ],
                );
              },
            );
          },
          child: TodoItemForListenerStaeShape(todo: todos[index]),
        );
      },
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class TodoItemForStreamSubscriptionStateShape extends StatefulWidget {
  const TodoItemForStreamSubscriptionStateShape({
    required this.todo,
    super.key,
  });

  final Todo todo;

  @override
  State<TodoItemForStreamSubscriptionStateShape> createState() => _TodoItemForStreamSubscriptionStateShapeState();
}

class _TodoItemForStreamSubscriptionStateShapeState extends State<TodoItemForStreamSubscriptionStateShape> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool error = false;
            textController.text = widget.todo.desc;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Edit Todo'),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: error ? "Value cannot be empty" : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          error = textController.text.isEmpty ? true : false;
                          if (!error) {
// ! when using CUBIT
                            //   context.read<TodoListCubit>().editTodo(
                            //         widget.todo.id,
                            //         textController.text,
                            //       );
// ! when using BLoC
                            context.read<TodoListBloc>().add(
                                  EditTodoEvent(
                                    id: widget.todo.id,
                                    todoDesc: textController.text,
                                  ),
                                );
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: const Text('EDIT'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
// ! when using CUBIT
          // context.read<TodoListCubit>().toggleTodo(widget.todo.id);
// ! when using BLoC
          context.read<TodoListBloc>().add(ToggleTodoEvent(id: widget.todo.id));
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}

 */
