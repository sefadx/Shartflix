import 'package:flutter/material.dart';
import '../../theme/theme_extension.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CustomButton({required this.text, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(customTheme.radiuslarge),
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.all(customTheme.gaplarge),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(customTheme.radiuslarge),
        ),
        child: Text(
          text,
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
