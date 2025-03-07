import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_settings_state.dart';

///  [AppSettingsCubit] is a `HydratedCubit` responsible for managing
/// the application settings using Cubit state management.
/// It provides persistent state management even after app restarts.
class AppSettingsCubit extends HydratedCubit<AppSettingsState> {
  /// 🆕 Initializes the Cubit with the default state or the hydrated state if available.
  AppSettingsCubit() : super(AppSettingsState.initial());

  /// 🔁 Toggles between BLoC and Cubit state management modes.
  /// Emits a new state with the updated management approach.
  void toggleUseBloc() {
    final newUseBloc = !state.isUsingBlocForAppFeatures;
    emit(state.copyWith(isUseBloc: newUseBloc));
  }

  /// 🎨 Toggles the theme between light and dark mode.
  /// Updates the appropriate theme state depending on whether BLoC or Cubit is active.
  void toggleTheme(bool isDarkMode) {
    if (state.isUsingBlocForAppFeatures) {
      emit(state.copyWith(isDarkThemeForBloc: isDarkMode));
    } else {
      emit(state.copyWith(isDarkThemeForCubit: isDarkMode));
    }
  }

  /// 💾 Converts the current [AppSettingsState] to a JSON map
  /// for persistent storage using [HydratedBloc].
  @override
  Map<String, dynamic>? toJson(AppSettingsState state) {
    return {
      'isUsingBlocForAppFeatures': state.isUsingBlocForAppFeatures,
      'isDarkThemeForBloc': state.isDarkThemeForBloc,
      'isDarkThemeForCubit': state.isDarkThemeForCubit,
    };
  }

  /// 💾 Restores the [AppSettingsState] from a JSON map
  /// when the app is restarted or resumed.
  @override
  AppSettingsState? fromJson(Map<String, dynamic> json) {
    return AppSettingsState(
      isUsingBlocForAppFeatures:
          json['isUsingBlocForAppFeatures'] as bool? ?? true,
      isDarkThemeForBloc: json['isDarkThemeForBloc'] as bool? ?? false,
      isDarkThemeForCubit: json['isDarkThemeForCubit'] as bool? ?? false,
    );
  }
}
