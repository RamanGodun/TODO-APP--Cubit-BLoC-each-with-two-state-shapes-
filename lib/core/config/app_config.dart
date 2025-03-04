/// 🌐 [AppSettingsStateManagement] defines the state management approach used across the app.
enum AppSettingsStateManagement { onBloc, onCubit }

/// 📦 [AppConfig] holds global configuration for the application.
class AppConfig {
  /// Defines the state management approach for the application.
  /// Switch between [AppSettingsStateManagement.onBloc] and [AppSettingsStateManagement.onCubit].
  static const AppSettingsStateManagement stateManagement =
      AppSettingsStateManagement.onCubit;

  /// Utility getter to easily check if BLoC is the active state management approach.
  static bool get isAppSettingsOnBlocStateShape =>
      stateManagement == AppSettingsStateManagement.onBloc;
}
