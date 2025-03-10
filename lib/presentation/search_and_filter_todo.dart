// import 'package:flutter/material.dart';
// import '../../core/models/todo_model.dart';
// import '../../core/state_switching/factory_for_search_filter_todo.dart';
// import '../../core/utils/debounce.dart';

// class SearchAndFilterTodo extends StatelessWidget {
//   SearchAndFilterTodo({super.key});
//   final debounce = Debounce(milliseconds: 1000);

//   @override
//   Widget build(BuildContext context) {
//     // 🎯 Використовуємо фабрику для динамічного підключення BLoC або Cubit
//     final SearchAndFilterTodoManager todoManager =
//         SearchAndFilterTodoFactory.create(context);

//     return Column(
//       children: [
//         TextField(
//           decoration: const InputDecoration(
//             labelText: 'Search todos...',
//             border: InputBorder.none,
//             filled: true,
//             prefixIcon: Icon(Icons.search),
//           ),
//           onChanged: (String? newSearchTerm) {
//             if (newSearchTerm != null) {
//               debounce.run(() {
//                 todoManager.setSearchTerm(newSearchTerm);
//               });
//             }
//           },
//         ),
//         const SizedBox(height: 10.0),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             filterButton(context, todoManager, Filter.all),
//             filterButton(context, todoManager, Filter.active),
//             filterButton(context, todoManager, Filter.completed),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget filterButton(
//       BuildContext context, SearchAndFilterTodoManager manager, Filter filter) {
//     return TextButton(
//       onPressed: () {
//         manager.changeFilter(filter);
//       },
//       child: Text(
//         filter == Filter.all
//             ? 'All'
//             : filter == Filter.active
//                 ? 'Active'
//                 : 'Completed',
//         style: TextStyle(
//           fontSize: 18.0,
//           color: textColor(manager, filter),
//         ),
//       ),
//     );
//   }

//   Color textColor(SearchAndFilterTodoManager manager, Filter filter) {
//     final currentFilter = manager.currentFilter;
//     return currentFilter == filter ? Colors.blue : Colors.grey;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/domain/models/todo_model.dart';
import '../core/domain/utils/bloc_exports.dart';
import '../core/domain/utils/debounce.dart';

class SearchAndFilterTodo extends StatelessWidget {
  SearchAndFilterTodo({super.key});
  final debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search todos...',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
// ! When using CUBIT
          // onChanged: (String? newSearchTerm) {
          //   if (newSearchTerm != null) {
          //     debounce.run(() {
          //       context.read<TodoSearchCubit>().setSearchTerm(newSearchTerm);
          //     });
          //   }
          // },
// ! When using BLoC
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              context
                  .read<TodoSearchBloc>()
                  .add(SetSearchTermEvent(newSearchTerm: newSearchTerm));
            }
          },
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.completed),
          ],
        ),
      ],
    );
  }

  Widget filterButton(BuildContext context, Filter filter) {
    return TextButton(
      onPressed: () {
// ! When using CUBIT
        // context.read<TodoFilterCubit>().changeFilter(filter);
// ! When using BLoC
        context
            .read<TodoFilterBloc>()
            .add(ChangeFilterEvent(newFilter: filter));
      },
      child: Text(
        filter == Filter.all
            ? 'All'
            : filter == Filter.active
                ? 'Active'
                : 'Completed',
        style: TextStyle(
          fontSize: 18.0,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
// ! When using CUBIT
    // final currentFilter = context.watch<TodoFilterCubit>().state.filter;
// ! When using BLoC
    final currentFilter = context.watch<TodoFilterBloc>().state.filter;
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}
