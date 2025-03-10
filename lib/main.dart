import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/domain/app_constants/app_strings.dart';
import 'core/domain/app_settings_on_cubit/app_settings_cubit.dart';
import 'core/domain/app_settings_on_cubit/loader.dart';
import 'core/domain/config/app_config.dart';
import 'core/domain/config/observer/app_bloc_observer.dart';
import 'core/domain/utils/bloc_exports.dart';
import 'core/domain/utils/cubits_export.dart';

import 'presentation/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  // HydratedBloc.storage.clear(); // ! only in test mode (delete all data)

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
                        context.read<TodoListCubit>().state.todos.length)),
        BlocProvider<FilteredTodosCubitWithListenerStateShape>(
            create: (context) => FilteredTodosCubitWithListenerStateShape(
                initialTodos: context.read<TodoListCubit>().state.todos)),
        BlocProvider<ActiveTodoCountBlocWithListenerStateShape>(
            create: (context) => ActiveTodoCountBlocWithListenerStateShape(
                  todoListBloc: context.read<TodoListBloc>(),
                )),
        BlocProvider<FilteredTodosBlocWithListenerStateShape>(
            create: (context) => FilteredTodosBlocWithListenerStateShape(
                initialTodos: context.read<TodoListBloc>().state.todos)),
      ];

  /// 🟦 Providers for "Stream Subscription" state-shape
  List<BlocProvider> _createStreamSubscriptionStateProviders(
          BuildContext context) =>
      [
        ..._createCommonProviders(),
        BlocProvider<ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape>(
            create: (context) =>
                ActiveTodoCountCubitWithUsingStreamSubscriptionStateShape(
                    todoListCubit: context.read<TodoListCubit>())),
        BlocProvider<FilteredTodosCubitWithStreamSubscriptionStateShape>(
            create: (context) =>
                FilteredTodosCubitWithStreamSubscriptionStateShape(
                    initialTodos: context.read<TodoListCubit>().state.todos,
                    todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
                    todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
                    todoListCubit: BlocProvider.of<TodoListCubit>(context))),
        BlocProvider<ActiveTodoCountBlocWithStreamSubscriptionStateShape>(
          create: (context) =>
              ActiveTodoCountBlocWithStreamSubscriptionStateShape(
            todoListBloc: BlocProvider.of<TodoListBloc>(context),
          ),
        ),
        BlocProvider<FilteredTodosBlocWithStreamSubscriptionStateShape>(
            create: (context) =>
                FilteredTodosBlocWithStreamSubscriptionStateShape(
                    initialTodos: context.read<TodoListBloc>().state.todos,
                    todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
                    todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context),
                    todoListBloc: BlocProvider.of<TodoListBloc>(context))),
      ];

  /// 🧩 Common Providers shared between both state shapes
  List<BlocProvider> _createCommonProviders() => [
        BlocProvider<AppSettingsCubit>(create: (context) => AppSettingsCubit()),
        BlocProvider<TodoListCubit>(create: (context) => TodoListCubit()),
        BlocProvider<TodoFilterCubit>(create: (context) => TodoFilterCubit()),
        BlocProvider<TodoSearchCubit>(create: (context) => TodoSearchCubit()),
        BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
        BlocProvider<TodoFilterBloc>(create: (context) => TodoFilterBloc()),
        BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),
      ];
}

/// 🎯 [AppStateBuilder] selects between Bloc and Cubit state management
class AppStateBuilder extends StatelessWidget {
  const AppStateBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalLoaderCubit>(
      create: (_) => GlobalLoaderCubit(),
      child: BlocListener<GlobalLoaderCubit, bool>(
        listener: (context, isLoading) {
          if (isLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
        child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
          builder: (context, state) {
            final isDarkMode = state.isUsingBlocForAppFeatures
                ? state.isDarkThemeForBloc
                : state.isDarkThemeForCubit;
            return MaterialAppWidget(isDarkMode: isDarkMode);
          },
        ),
      ),
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
