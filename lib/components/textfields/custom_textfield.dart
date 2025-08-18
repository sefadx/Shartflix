import 'package:flutter/material.dart';

import '../../theme/theme_extension.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffix,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.colorScheme.surface,
        hintText: hintText,
        hintStyle: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.secondary),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: customTheme.gapxlarge),
            Icon(prefixIcon, color: theme.colorScheme.secondary, size: 30),
            SizedBox(width: customTheme.gapsmall),
          ],
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: customTheme.gapxxxlarge,
          minHeight: customTheme.gapxxxlarge,
        ),
        suffixIcon: suffix,
        contentPadding: EdgeInsets.symmetric(
          vertical: customTheme.gapxlarge,
          horizontal: customTheme.gapmedium,
        ),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(customTheme.radiuslarge),
          borderSide: BorderSide(color: theme.colorScheme.secondary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(customTheme.radiuslarge),
          borderSide: BorderSide(color: theme.colorScheme.secondary, width: 2),
        ),
      ),
    );
  }
}
