import 'dart:async';

import 'package:flutter/material.dart';

import '../../gen/app_localizations.dart';
import '../../navigator/app_router.dart';
import '../../theme/theme_extension.dart';

class PagePopupInfo extends StatelessWidget {
  const PagePopupInfo({this.title, this.message, this.seconds = 2, this.afterDelay, super.key});

  final String? title, message;
  final int seconds;
  final void Function()? afterDelay;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    Timer(Duration(seconds: seconds), afterDelay ?? () => AppRouter.instance.pop());

    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(customTheme.gapxxlarge),
          child: Ink(
            padding: EdgeInsets.all(customTheme.gapmedium),
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(customTheme.radiussmall),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: customTheme.radiussmall)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? text.unknown,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge,
                ),
                SizedBox(height: customTheme.gapmedium),
                Text(
                  message ?? text.unknownError,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: customTheme.gapmedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
