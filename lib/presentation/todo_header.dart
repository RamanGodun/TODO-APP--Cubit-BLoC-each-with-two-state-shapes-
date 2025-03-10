// import 'package:flutter/material.dart';
// import '../../core/state_switching/factory_for_header.dart';
// import '../widgets/text_widget.dart';

// /// 📱 [TodoHeader] використовує [TodoHeaderFactory] для визначення
// /// потрібної реалізації на основі поточного стейт-менеджменту.
// class TodoHeader extends StatelessWidget {
//   const TodoHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final manager = TodoHeaderFactory.create(context);

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const TextWidget('TODO', TextType.smallHeadline),
//         manager.buildHeaderText(),
//       ],
//     );
//   }
// }

/*

    final isCounterOnBloc = CounterFactory.isCounterOnBloc(context);
    final CounterManager counterManager =
        CounterFactory.create(context, isCounterOnBloc: isCounterOnBloc);


 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/domain/config/app_config.dart';
import '../core/domain/utils/cubits_export.dart';
import 'widgets/text_widget.dart';

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
      '${context.watch<ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape>().state.activeTodoCount} items left', // ! when using cubit
      // '${context.watch<ActiveTodoCountBlocWithStreamSubscriptionStateShape>().state.activeTodoCount} items left', // ! when using bloc
      style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
    );
  }
}

// !Next is with Listener state shape

class TodoHeaderForListenerStateShape extends StatelessWidget {
  const TodoHeaderForListenerStateShape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoListCubit, TodoListStateOnCubit>(
      // ! when using CUBIT
      // return BlocListener<TodoListBloc, TodoListStateOnBloc>( // ! when using BLoC
      listener: (context, state) {
        // ! when using CUBIT
        context
            .read<ActiveTodoCountCubitWithUsingListenerStateShape>()
            .calculateActiveTodoCount();
      },
      // ! when using BLoC
      // context.read<ActiveTodoCountBlocWithListenerStateShape>().add(
      //     CalculateActiveTodoCountEventWithListenerStateShape(
      //         activeTodoCount: activeTodoCount));
      child: BlocBuilder<ActiveTodoCountCubitWithUsingListenerStateShape,
          ActiveTodoCountStateOnCubitWithUsingListenerStateShape>(
        builder: (context, state) {
          return TextWidget(
            '${state.activeTodoCount} items left', // ! when using CUBIT
            // '${state.activeTodoCount} items left', // ! when using BLoC
            TextType.titleMedium,
          );
        },
      ),
    );
  }
}
