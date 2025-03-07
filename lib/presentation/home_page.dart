import 'package:cubit_bloc_playground_todo_app/presentation/todo_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/app_constants/app_constants.dart';
import '../core/app_constants/app_strings.dart';
import '../core/app_settings_on_cubit/app_settings_cubit.dart';
import '../core/utils/helpers.dart';
import 'create_todo.dart';
import 'search_and_filter_todo.dart';
import 'show_todos.dart';

import 'widgets/text_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔍 Determine if the app uses BLoC or Cubit for state management
    final isUsingBlocForAppFeatures = context.select<AppSettingsCubit, bool>(
        (cubit) => cubit.state.isUsingBlocForAppFeatures);

    final isDarkMode = context.select<AppSettingsCubit, bool>(
      (cubit) => cubit.state.isUsingBlocForAppFeatures
          ? cubit.state.isDarkThemeForBloc
          : cubit.state.isDarkThemeForCubit,
    );

    final themeIcon =
        isDarkMode ? AppConstants.darkModeIcon : AppConstants.lightModeIcon;
    final iconColor = Helpers.getColorScheme(context).primary;
    final stateChangeIcon = isUsingBlocForAppFeatures
        ? AppConstants.syncIcon
        : AppConstants.changeCircleIcon;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: TextWidget(
              isUsingBlocForAppFeatures
                  ? AppStrings.appIsOnBloc
                  : AppStrings.appIsOnCubit,
              TextType.titleMedium,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(themeIcon, color: iconColor),
                onPressed: () => _toggleTheme(context, isDarkMode)),
            IconButton(
                icon: Icon(stateChangeIcon, color: iconColor),
                onPressed: () =>
                    context.read<AppSettingsCubit>().toggleUseBloc()),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              const TodoHeader(),
              const CreateTodo(),
              const SizedBox(height: 20.0),
              SearchAndFilterTodo(),
              const ShowTodos(),
            ],
          ),
        ),
      ),
    );
  }

  /// USED methods

  /// 🕹️ Toggles the theme between light and dark.
  void _toggleTheme(BuildContext context, bool isDarkMode) {
    context.read<AppSettingsCubit>().toggleTheme(!isDarkMode);
  }
}
