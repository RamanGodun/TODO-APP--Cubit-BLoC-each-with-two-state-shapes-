import 'package:flutter/material.dart';

import '../../../core/config/app_constants.dart';

/// 🆕 `AppFloatingActionButton` ensures consistent styling for all FABs in the app.
class AppFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String heroTag;

  const AppFloatingActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      foregroundColor: AppConstants.darkForegroundColor,
      backgroundColor: AppConstants.darkPrimaryColor,
      child: Icon(icon),
    );
  }
}
