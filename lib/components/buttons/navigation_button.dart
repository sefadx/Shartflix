import 'package:flutter/material.dart';

import '../../theme/theme_extension.dart';

class NavBarButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const NavBarButton({required this.icon, required this.text, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(customTheme.radiuslarge),
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.all(customTheme.gapsmall),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(customTheme.radiuslarge),
          border: Border.all(color: theme.colorScheme.secondary, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Icon(icon, size: 30)),
            SizedBox(width: customTheme.gapsmall),
            Flexible(
              child: Text(
                text,
                style: theme.textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
