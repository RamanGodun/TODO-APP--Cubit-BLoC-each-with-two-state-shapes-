import 'package:flutter/material.dart';
import '../../core/config/app_constants.dart';
import '../../core/utils/helpers.dart';
import 'text_widget.dart';

/// 🆕 `AppElevatedButton` ensures consistent styling for all elevated buttons in the app.
/// - Applies glassmorphism with a soft blur and semi-transparent background.
class AppElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.largePadding),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppConstants.mediumPadding),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5.0),
          padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: AppConstants.commonBorderRadius,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            Helpers.getColorScheme(context).primary.withOpacity(0.2),
          ),
          overlayColor: MaterialStateProperty.all(
            Helpers.getColorScheme(context).secondaryFixed.withOpacity(0.1),
          ),
        ),
        child: TextWidget(
          label,
          TextType.button,
          color: Helpers.getColorScheme(context).onPrimary.withOpacity(0.7),
        ),
      ),
    );
  }
}
