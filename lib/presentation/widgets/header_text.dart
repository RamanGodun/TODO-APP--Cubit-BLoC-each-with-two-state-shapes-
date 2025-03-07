import 'package:flutter/material.dart';

import '../../core/app_constants/app_constants.dart';
import '../../core/utils/helpers.dart';
import 'text_widget.dart';

class HeaderText extends StatelessWidget {
  final String headlineText;
  final String subTitleText;

  const HeaderText({
    super.key,
    required this.headlineText,
    required this.subTitleText,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Helpers.getColorScheme(context).onSurface.withOpacity(0.7);
    return Column(
      children: [
        const SizedBox(height: AppConstants.largePadding),
        TextWidget(
          headlineText,
          TextType.headline,
          color: textColor,
        ),
        const SizedBox(height: 4),
        TextWidget(
          subTitleText,
          TextType.titleMedium,
          color: textColor,
        ),
        const SizedBox(height: AppConstants.largePadding),
      ],
    );
  }
}
