import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/app_constants/app_strings.dart';
import 'core/app_settings_on_cubit/app_settings_cubit.dart';
import 'core/config/app_config.dart';
import 'core/config/observer/app_bloc_observer.dart';
import 'core/utils/bloc_exports.dart';
import 'core/utils/cubits_export.dart';

import 'presentation/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

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
      child: const AppStateBuilder(),
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
        BlocProvider<AppSettingsCubit>(create: (context) => AppSettingsCubit()),
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

/// 🎯 [AppStateBuilder] selects between Bloc and Cubit state management
class AppStateBuilder extends StatelessWidget {
  const AppStateBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        final isDarkMode = state.isUsingBlocForAppFeatures
            ? state.isDarkThemeForBloc
            : state.isDarkThemeForCubit;
        return MaterialAppWidget(isDarkMode: isDarkMode);
      },
    );
  }
}

/// 📱 [MaterialAppWidget] builds the MaterialApp with the selected theme and routing
class MaterialAppWidget extends StatelessWidget {
  final bool isDarkMode;

  const MaterialAppWidget({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: const HomePage(),
    );
  }
}
