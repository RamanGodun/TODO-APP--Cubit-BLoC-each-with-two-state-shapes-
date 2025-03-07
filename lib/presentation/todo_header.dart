import 'package:flutter/material.dart';
import '../features/header/state_switching/factory.dart';
import 'widgets/text_widget.dart';

/// 📱 [TodoHeader] використовує [TodoHeaderFactory] для визначення
/// потрібної реалізації на основі поточного стейт-менеджменту.
class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = TodoHeaderFactory.create(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TextWidget('TODO', TextType.smallHeadline),
        manager.buildHeaderText(),
      ],
    );
  }
}

/*
/// Common reusable widget for Todo Header
class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TextWidget('TODO', TextType.smallHeadline),
        AppConfig.isAppStateShapeManagementWithListeners
            ? const TodoHeaderForListenerStateShape()
            : const TodoHeaderForStreamSubscriptionStateShape(),
      ],
    );
  }
}


// ! NEXT for stream subscription state-shape
class TodoHeaderForStreamSubscriptionStateShape extends StatelessWidget {
  const TodoHeaderForStreamSubscriptionStateShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      // '${context.watch<ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape>().state.activeTodoCount} items left', // ! when using cubit
      '${context.watch<ActiveTodoCountBlocWithStreamSubscriptionStateShape>().state.activeTodoCount} items left', // ! when using bloc
      style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
    );
  }
}

// !Next is with Listener state shape
class TodoHeaderForListenerStateShape extends StatelessWidget {
  const TodoHeaderForListenerStateShape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoListBloc, TodoListStateOnBloc>(
      // ! when using BLoC
      listener: (context, state) {
        final int activeTodoCount =
            state.todos.where((Todo todo) => !todo.completed).toList().length;
        // ! when using CUBIT
        // context
        //     .read<ActiveTodoCountCubitWithUsingListenerStateShape>()
        //     .calculateActiveTodoCount(activeTodoCount);
        // ! when using BLoC
        context.read<ActiveTodoCountBlocWithListenerStateShape>().add(
            CalculateActiveTodoCountEventWithListenerStateShape(
                activeTodoCount: activeTodoCount));
      },
      child: TextWidget(
          // '${context.watch<ActiveTodoCountCubitWithUsingListenerStateShape>().state.activeTodoCount} items left', // ! when using CUBIT
          '${context.watch<ActiveTodoCountBlocWithListenerStateShape>().state.activeTodoCount} items left',
          TextType.titleMedium // ! when using BLoC
          ),
    );
  }
}


 */
