// !Next is with stream subscription state shape

// import 'package:flutter/material.dart';
// import '../core/state_switching/factory_for_list_with_ssss.dart';
// import 'todo_item.dart';
// import 'widgets/mini_widgets.dart';

// /// 📱 [ShowTodosForStreamSubscriptionStateShape] використовує [ShowTodosFactory]
// /// для динамічного управління логікою відображення списку Todo.
// class ShowTodosForStreamSubscriptionStateShape extends StatelessWidget {
//   const ShowTodosForStreamSubscriptionStateShape({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final manager = ShowTodosFactory.create(context);
//     final todos = manager.getTodos();

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

import '../core/domain/utils/cubits_export.dart';
import 'todo_item.dart';
import 'widgets/mini_widgets.dart';

class ShowTodosForStreamSubscriptionStateShape extends StatelessWidget {
  const ShowTodosForStreamSubscriptionStateShape({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context
        .watch<FilteredTodosCubitWithStreamSubscriptionStateShape>()
        .state
        .filteredTodos; // ! when using CUBIT
    // final todos = context
    //     .watch<FilteredTodosBlocWithStreamSubscriptionStateShape>()
    //     .state
    //     .filteredTodos; // ! when using BLoC

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
          background: const DismissibleBackground(0),
          secondaryBackground: const DismissibleBackground(1),
// ! when using CUBIT
          onDismissed: (_) {
            context.read<TodoListCubit>().removeTodo(todos[index]);
          },
// ! when using BLoC
          // onDismissed: (_) {
          //   context
          //       .read<TodoListBloc>()
          //       .add(RemoveTodoEvent(todo: todos[index]));
          // },
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
    );
  }
}
