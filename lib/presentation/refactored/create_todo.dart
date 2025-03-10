import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/domain/utils/bloc_exports.dart';

// import '../../features/todos_list/on_cubit/todo_list_cubit.dart'; // ! when using CUBIT

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final TextEditingController newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newTodoController,
      decoration: const InputDecoration(labelText: 'What to do?'),
      onSubmitted: (String? todoDesc) {
        if (todoDesc != null && todoDesc.trim().isNotEmpty) {
          // context.read<TodoListCubit>().addTodo(todoDesc); // ! when using CUBIT
          context
              .read<TodoListBloc>()
              .add(AddTodoEvent(todoDesc: todoDesc)); // ! when using BLoC
          newTodoController.clear();
        }
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import '../../core/state_switching/factory_for_create_todo.dart';

// class CreateTodo extends StatefulWidget {
//   const CreateTodo({super.key});

//   @override
//   State<CreateTodo> createState() => _CreateTodoState();
// }

// class _CreateTodoState extends State<CreateTodo> {
//   final TextEditingController newTodoController = TextEditingController();

//   @override
//   void dispose() {
//     newTodoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 🎯 Використовуємо фабрику для динамічного підключення BLoC або Cubit
//     final CreateTodoManager todoManager = CreateTodoFactory.create(context);

//     return TextField(
//       controller: newTodoController,
//       decoration: const InputDecoration(labelText: 'What to do?'),
//       onSubmitted: (String? todoDesc) {
//         if (todoDesc != null && todoDesc.trim().isNotEmpty) {
//           todoManager.addTodo(todoDesc);
//           newTodoController.clear();
//         }
//       },
//     );
//   }
// }
