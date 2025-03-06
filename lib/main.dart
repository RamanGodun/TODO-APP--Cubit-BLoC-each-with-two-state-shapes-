import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_bloc_observer.dart';
import 'core/config/app_theme.dart';
import 'core/utils/bloc_exports.dart';
import 'core/utils/cubits_export.dart';

import 'presentation/home_page.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
/* Cubits */
        BlocProvider<TodoFilterCubit>(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider<TodoListCubit>(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape>(
          create: (context) =>
              ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape(
            initialActiveTodoCount:
                context.read<TodoListCubit>().state.todos.length,
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
        BlocProvider<ActiveTodoCountCubitWithUsingListenerStateShape>(
          create: (context) => ActiveTodoCountCubitWithUsingListenerStateShape(
            initialActiveTodoCount:
                context.read<TodoListCubit>().state.todos.length,
          ),
        ),
        BlocProvider<FilteredTodosCubitWithStreamSubscriptionStateShape>(
          create: (context) =>
              FilteredTodosCubitWithStreamSubscriptionStateShape(
            initialTodos: context.read<TodoListCubit>().state.todos,
            todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
            todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
        BlocProvider<FilteredTodosCubitWithListenerStateShape>(
          create: (context) => FilteredTodosCubitWithListenerStateShape(
            initialTodos: context.read<TodoListCubit>().state.todos,
          ),
        ),

/* BLoCs */
        BlocProvider<TodoFilterBloc>(
          create: (context) => TodoFilterBloc(),
        ),
        BlocProvider<TodoSearchBloc>(
          create: (context) => TodoSearchBloc(),
        ),
        BlocProvider<TodoListBloc>(
          create: (context) => TodoListBloc(),
        ),
        BlocProvider<ActiveTodoCountBlocWithStreamSubscriptionStateShape>(
          create: (context) =>
              ActiveTodoCountBlocWithStreamSubscriptionStateShape(
            initialActiveTodoCount:
                context.read<TodoListBloc>().state.todos.length,
            todoListBloc: BlocProvider.of<TodoListBloc>(context),
          ),
        ),
        BlocProvider<FilteredTodosBlocWithStreamSubscriptionStateShape>(
          create: (context) =>
              FilteredTodosBlocWithStreamSubscriptionStateShape(
            initialTodos: context.read<TodoListBloc>().state.todos,
            todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
            todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context),
            todoListBloc: BlocProvider.of<TodoListBloc>(context),
          ),
        ),
        BlocProvider<ActiveTodoCountBlocWithListenerStateShape>(
          create: (context) => ActiveTodoCountBlocWithListenerStateShape(
            initialActiveTodoCount:
                context.read<TodoListBloc>().state.todos.length,
          ),
        ),
        BlocProvider<FilteredTodosBlocWithListenerStateShape>(
          create: (context) => FilteredTodosBlocWithListenerStateShape(
            initialTodos: context.read<TodoListBloc>().state.todos,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.darkTheme,
        home: const HomePage(),
      ),
    );
  }
}

/*

     ! NEED TO DO next:

? 1. Data persistence (SQLie or Hive)
? 2. Additional state management ("In Progress" state with CircularProgressIndicator)
? 3. Error dialog
? 4. Pagination (traditional or infinite scrolling)
? 5. Use TextWidget, not Text(...)
? 6. Use custom showDialog
? 7. Refactor design
? 8. Use onGenerate routes navigation if add extra pages

 */
