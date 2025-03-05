import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/todo_model.dart';
import '../../todos_list/on_cubit/todo_list_cubit.dart';
import '../on_cubit/listener_state_shape/active_todo_count_cubit_listener_ss.dart';

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
        BlocListener<TodoListCubit, TodoListState>(
          listener: (context, state) {
            final int activeTodoCount = state.todos
                .where((Todo todo) => !todo.completed)
                .toList()
                .length;
            context
                .read<ActiveTodoCountCubitWithUsingListenerStateShape>()
                .calculateActiveTodoCount(activeTodoCount);
          },
          child: Text(
            '${context.watch<ActiveTodoCountCubitWithUsingListenerStateShape>().state.activeTodoCount} items left',
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
          '${context.watch<ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape>().state.activeTodoCount} items left',
          style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
        ),
      ],
    );
  }
}



!Next is with Listener state shape


 */
