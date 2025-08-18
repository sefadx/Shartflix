import 'package:flutter/material.dart';

import '../theme/theme_extension.dart';

class PageSplash extends StatelessWidget {
  const PageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        "Shartflix",
        style: theme.textTheme.headlineLarge?.copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}
