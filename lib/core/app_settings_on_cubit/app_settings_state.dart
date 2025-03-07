part of 'app_settings_cubit.dart';

/// 🎛️ [AppSettingsState] manages the application settings for [AppSettingsCubit].
/// It controls whether the app is using BLoC or Cubit and manages theme preferences for both.
class AppSettingsState extends Equatable {
  /// 🔁 Indicates whether the app uses BLoC or Cubit for state management.
  final bool isUsingBlocForAppFeatures;

  /// 🎨 Stores the theme preference (dark/light) for BLoC and Cubit approaches.
  final bool isDarkThemeForBloc;
  final bool isDarkThemeForCubit;

  /// 🆕 Creates an immutable state for app settings.
  const AppSettingsState({
    required this.isUsingBlocForAppFeatures,
    required this.isDarkThemeForBloc,
    required this.isDarkThemeForCubit,
  });

  /// 🛠️ Returns the initial state with default values:
  /// ✅ BLoC as the state management approach
  /// 🌞 Light theme for both BLoC and Cubit.
  factory AppSettingsState.initial() {
    return const AppSettingsState(
      isUsingBlocForAppFeatures: true,
      isDarkThemeForBloc: false,
      isDarkThemeForCubit: false,
    );
  }

  /// ✨ Creates a new state with optional overrides while maintaining immutability.
  /// Useful for updating only specific fields without mutating the original state.
  AppSettingsState copyWith({
    bool? isUseBloc,
    bool? isDarkThemeForBloc,
    bool? isDarkThemeForCubit,
  }) {
    return AppSettingsState(
      isUsingBlocForAppFeatures: isUseBloc ?? isUsingBlocForAppFeatures,
      isDarkThemeForBloc: isDarkThemeForBloc ?? this.isDarkThemeForBloc,
      isDarkThemeForCubit: isDarkThemeForCubit ?? this.isDarkThemeForCubit,
    );
  }

  /// 🔍 Used for equality checks to ensure accurate state comparison.
  @override
  List<Object> get props => [
        isUsingBlocForAppFeatures,
        isDarkThemeForBloc,
        isDarkThemeForCubit,
      ];
}
