// import 'package:flutter/material.dart';
// import '../core/state_switching/factory_for_list_with_lss.dart';
// import 'todo_item.dart';
// import 'widgets/mini_widgets.dart';

// /// 📱 [ShowTodosWithListenerStateShape] використовує [ShowTodosWithListenerFactory]
// /// для динамічного управління логікою відображення списку Todo.
// class ShowTodosWithListenerStateShape extends StatelessWidget {
//   const ShowTodosWithListenerStateShape({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final manager = ShowTodosWithListenerFactory.create(context);
//     final todos = manager.getTodos();

//     manager.setupListeners();

//     return ListView.separated(
//       primary: false,
//       shrinkWrap: true,
//       itemCount: todos.length,
//       separatorBuilder: (BuildContext context, int index) {
//         return const Divider(color: Colors.grey);
//       },
//       itemBuilder: (BuildContext context, int index) {
//         return Dismissible(
//           key: ValueKey(todos[index].id),
//           background: const DismissibleBackground(0),
//           secondaryBackground: const DismissibleBackground(1),
//           onDismissed: (_) {
//             manager.removeTodo(todos[index]);
//           },
//           confirmDismiss: (_) {
//             return showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (context) {
//                 return const DeleteConfirmationDialog();
//               },
//             );
//           },
//           child: TodoItem(todo: todos[index]),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/domain/models/todo_model.dart';
import '../core/domain/utils/bloc_exports.dart';
import 'todo_item.dart';
import 'widgets/mini_widgets.dart'; // ! when using BLoC
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
            background: const DismissibleBackground(0),
            secondaryBackground: const DismissibleBackground(1),
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
                  return const DeleteConfirmationDialog();
                },
              );
            },
            child: TodoItem(todo: todos[index]),
          );
        },
      ),
    );
  }
}
