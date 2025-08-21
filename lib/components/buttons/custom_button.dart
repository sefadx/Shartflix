import 'package:flutter/material.dart';
import '../../theme/theme_extension.dart';

class CustomButton extends StatelessWidget {
  final MainAxisSize? mainAxisSize;
  final EdgeInsets? padding;
  final double? radius;
  final String text;
  final Icon? icon;
  final TextStyle? textStyle;
  final void Function()? onTap;

  const CustomButton({
    this.mainAxisSize,
    this.padding,
    this.radius,
    required this.text,
    this.icon,
    this.textStyle,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(customTheme.radiuslarge),
      onTap: onTap,
      child: Ink(
        padding: padding ?? EdgeInsets.all(customTheme.gaplarge),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(radius ?? customTheme.radiuslarge),
        ),
        child: Row(
          mainAxisSize: mainAxisSize ?? MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? icon! : SizedBox(),
            SizedBox(width: icon != null ? 5 : 0),
            Flexible(
              child: Text(
                text,
                style: textStyle ?? theme.textTheme.titleLarge?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
