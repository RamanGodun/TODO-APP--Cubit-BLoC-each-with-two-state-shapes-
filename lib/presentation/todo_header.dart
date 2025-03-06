import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/models/todo_model.dart';
import '../core/utils/bloc_exports.dart'; // ! when using BLoC
// import '../../core/utils/cubits_export.dart'; // ! when using CUBIT

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(fontSize: 40.0),
        ),
        // BlocListener<TodoListCubit, TodoListStateOnCubit>( // ! when using CUBIT
        BlocListener<TodoListBloc, TodoListStateOnBloc>(
          // ! when using BLoC
          listener: (context, state) {
            final int activeTodoCount = state.todos
                .where((Todo todo) => !todo.completed)
                .toList()
                .length;
// ! when using CUBIT
            // context
            //     .read<ActiveTodoCountCubitWithUsingListenerStateShape>()
            //     .calculateActiveTodoCount(activeTodoCount);
// ! when using BLoC
            context.read<ActiveTodoCountBlocWithListenerStateShape>().add(
                CalculateActiveTodoCountEventWithListenerStateShape(
                    activeTodoCount: activeTodoCount));
          },
          child: Text(
            // '${context.watch<ActiveTodoCountCubitWithUsingListenerStateShape>().state.activeTodoCount} items left', // ! when using CUBIT
            '${context.watch<ActiveTodoCountBlocWithListenerStateShape>().state.activeTodoCount} items left', // ! when using BLoC
            style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
          ),
        )
      ],
    );
  }
}

/*
! NEXT for stream subscription state-shape

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          // '${context.watch<ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape>().state.activeTodoCount} items left', // ! when using cubit
          '${context.watch<ActiveTodoCountBlocWithStreamSubscriptionStateShape>().state.activeTodoCount} items left', // ! when using bloc
          style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
        ),
      ],
    );
  }
}



!Next is with Listener state shape




 */
