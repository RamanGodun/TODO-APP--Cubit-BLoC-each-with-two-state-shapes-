// import 'package:flutter/material.dart';
// import '../core/models/todo_model.dart';
// import '../core/state_switching/factory_for_todo_item.dart';

// /// 📱 [TodoItem] використовує [TodoItemFactory] для динамічного управління логікою TodoItem.
// class TodoItem extends StatefulWidget {
//   final Todo todo;
//   const TodoItem({required this.todo, super.key});

//   @override
//   State<TodoItem> createState() => _TodoItemState();
// }

// class _TodoItemState extends State<TodoItem> {
//   late final TextEditingController textController;
//   late final TodoItemManager manager;

//   @override
//   void initState() {
//     super.initState();
//     textController = TextEditingController();
//     manager = TodoItemFactory.create(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (context) {
//             bool error = false;
//             textController.text = widget.todo.desc;

//             return StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) {
//                 return AlertDialog(
//                   title: const Text('Edit Todo'),
//                   content: TextField(
//                     controller: textController,
//                     autofocus: true,
//                     decoration: InputDecoration(
//                       errorText: error ? "Value cannot be empty" : null,
//                     ),
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('CANCEL'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         setState(() {
//                           error = textController.text.isEmpty;
//                           if (!error) {
//                             manager.editTodo(
//                               widget.todo.id,
//                               textController.text,
//                             );
//                             Navigator.pop(context);
//                           }
//                         });
//                       },
//                       child: const Text('EDIT'),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//         );
//       },
//       leading: Checkbox(
//         value: widget.todo.completed,
//         onChanged: (bool? checked) {
//           manager.toggleTodo(widget.todo.id);
//         },
//       ),
//       title: Text(widget.todo.desc),
//     );
//   }

//   @override
//   void dispose() {
//     textController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/domain/models/todo_model.dart';
import '../core/domain/utils/cubits_export.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({required this.todo, super.key});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
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
                            context.read<TodoListCubit>().editTodo(
                                  widget.todo.id,
                                  textController.text,
                                );
// ! when using BLoC
                            // context.read<TodoListBloc>().add(
                            //       EditTodoEvent(
                            //         id: widget.todo.id,
                            //         todoDesc: textController.text,
                            //       ),
                            //     );
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
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
// ! when using BLoC
          // context.read<TodoListBloc>().add(ToggleTodoEvent(id: widget.todo.id));
        },
      ),
      title: Text(widget.todo.desc),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
