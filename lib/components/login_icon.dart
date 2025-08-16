import 'package:flutter/material.dart';

import '../theme/theme_extension.dart';

class LoginIcon extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  const LoginIcon({required this.icon, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(customTheme.radiuslarge),
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.all(customTheme.gapmedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(customTheme.radiuslarge),
          border: Border.all(color: theme.colorScheme.secondary, width: 1),
          color: theme.colorScheme.surface,
        ),
        child: Icon(icon, size: 30),
      ),
    );
  }
}
