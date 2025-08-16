import 'package:flutter/material.dart';
import 'package:shartflix/navigator/pages.dart';

class CustomPageRouteBuilder extends Page {
  const CustomPageRouteBuilder({
    required this.child,
    required this.pageRouteSettings,
    super.key,
    super.arguments
  });

  final Widget child;
  final PageRouteSettings pageRouteSettings;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      opaque: pageRouteSettings.backgroundOpaque,
      barrierDismissible: pageRouteSettings.barrierDismissible,
      fullscreenDialog: pageRouteSettings.fullScreenDialog,
      barrierColor: pageRouteSettings.barrierColor,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}