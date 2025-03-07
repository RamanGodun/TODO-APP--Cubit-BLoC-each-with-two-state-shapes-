/// 🌐 **[AppStateShapeManagement]** - Defines the state management approach used across the app.
/// Provides an easy toggle between **BLoC** and **Cubit** state management.
enum AppStateShapeManagement {
  withListener, // 🟢 Use "Listener" app's state shape
  withStreamSubscription // 🔵 Use "StreamSubscription" app's state shape
}

/// 📦 **[AppConfig]** - Holds global configuration settings for the application./// Centralizes state management strategy and exposes utility methods for easy access.
class AppConfig {
  /// 🛠️ Defines the **default state shape management approach** for the app.
  static const AppStateShapeManagement stateManagement = AppStateShapeManagement
      .withListener; // ! Change this to switch between [AppStateShapeManagement.withListener] and [AppStateShapeManagement.withStreamSubscription]

  /// ✅ **Utility getter** to check if the app is using **BLoC** for state management.
  /// Returns **true** if [AppStateShapeManagement.withListener] is active, otherwise **false**.
  static bool get isAppStateShapeManagementWithListeners =>
      stateManagement == AppStateShapeManagement.withListener;
}
