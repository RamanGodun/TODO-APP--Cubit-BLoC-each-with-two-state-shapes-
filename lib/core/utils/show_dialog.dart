import 'package:flutter/material.dart';

import '../../presentation/widgets/text_widget.dart';
import '../config/app_constants.dart';
import '../config/app_strings.dart';
import 'helpers.dart';

/// 💬 [DialogService] provides a simple way to show alert dialogs in the app.
abstract class DialogService {
  /// ⚠️ Shows a customizable alert dialog with the provided [text].
  /// The dialog is centered and takes 40% of the screen height.
  static void showAlertDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                AppConstants.dialogMaxHeightRatio,
          ),
          child: Center(
            child: TextWidget(
              text,
              TextType.button,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Center(
              child: TextWidget(
                AppStrings.okButton,
                TextType.titleMedium,
                color: Helpers.getColorScheme(context).primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
