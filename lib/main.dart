import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_config.dart';
import 'core/config/observer/app_bloc_observer.dart';
import 'core/theming/app_theme.dart';
import 'core/utils/bloc_exports.dart';
import 'core/utils/cubits_export.dart';

import 'presentation/home_page.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const StateManagementProvider());
}

class StateManagementProvider extends StatelessWidget {
  const StateManagementProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppConfig.isAppStateShapeManagementWithListeners
          ? _createListenerStateProviders(context)
          : _createStreamSubscriptionStateProviders(context),
      child: const MaterialAppWidget(),
    );
  }

  /// 🟧 Providers for "Listeners" state-shape
  List<BlocProvider> _createListenerStateProviders(BuildContext context) => [
        ..._createCommonProviders(),
        BlocProvider<ActiveTodoCountCubitWithUsingListenerStateShape>(
            create: (context) =>
                ActiveTodoCountCubitWithUsingListenerStateShape(
                    initialActiveTodoCount:
                        context.read<TodoListCubit>().state.todos.length),
            lazy: true),
        BlocProvider<FilteredTodosCubitWithListenerStateShape>(
            create: (context) => FilteredTodosCubitWithListenerStateShape(
                initialTodos: context.read<TodoListCubit>().state.todos),
            lazy: true),
        BlocProvider<ActiveTodoCountBlocWithListenerStateShape>(
            create: (context) => ActiveTodoCountBlocWithListenerStateShape(
                initialActiveTodoCount:
                    context.read<TodoListBloc>().state.todos.length),
            lazy: true),
        BlocProvider<FilteredTodosBlocWithListenerStateShape>(
            create: (context) => FilteredTodosBlocWithListenerStateShape(
                initialTodos: context.read<TodoListBloc>().state.todos),
            lazy: true),
      ];

  /// 🟦 Providers for "Stream Subscription" state-shape
  List<BlocProvider> _createStreamSubscriptionStateProviders(
          BuildContext context) =>
      [
        ..._createCommonProviders(),
        BlocProvider<ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape>(
            create: (context) =>
                ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape(
                    initialActiveTodoCount:
                        context.read<TodoListCubit>().state.todos.length,
                    todoListCubit: BlocProvider.of<TodoListCubit>(context)),
            lazy: true),
        BlocProvider<FilteredTodosCubitWithStreamSubscriptionStateShape>(
            create: (context) =>
                FilteredTodosCubitWithStreamSubscriptionStateShape(
                    initialTodos: context.read<TodoListCubit>().state.todos,
                    todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
                    todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
                    todoListCubit: BlocProvider.of<TodoListCubit>(context)),
            lazy: true),
        BlocProvider<ActiveTodoCountBlocWithStreamSubscriptionStateShape>(
            create: (context) =>
                ActiveTodoCountBlocWithStreamSubscriptionStateShape(
                    initialActiveTodoCount:
                        context.read<TodoListBloc>().state.todos.length,
                    todoListBloc: BlocProvider.of<TodoListBloc>(context)),
            lazy: true),
        BlocProvider<FilteredTodosBlocWithStreamSubscriptionStateShape>(
            create: (context) =>
                FilteredTodosBlocWithStreamSubscriptionStateShape(
                    initialTodos: context.read<TodoListBloc>().state.todos,
                    todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
                    todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context),
                    todoListBloc: BlocProvider.of<TodoListBloc>(context)),
            lazy: true),
      ];

  /// 🧩 Common Providers shared between both state shapes
  List<BlocProvider> _createCommonProviders() => [
        BlocProvider<TodoListCubit>(create: (context) => TodoListCubit()),
        BlocProvider<TodoFilterCubit>(
            create: (context) => TodoFilterCubit(), lazy: true),
        BlocProvider<TodoSearchCubit>(
            create: (context) => TodoSearchCubit(), lazy: true),
        BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
        BlocProvider<TodoFilterBloc>(
            create: (context) => TodoFilterBloc(), lazy: true),
        BlocProvider<TodoSearchBloc>(
            create: (context) => TodoSearchBloc(), lazy: true),
      ];
}

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.darkTheme,
      home: const HomePage(),
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
