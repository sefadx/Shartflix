import 'package:flutter/material.dart';

import 'app_router.dart';

enum Pages { Home, Login }

class PageConfiguration {
  PageConfiguration({
    required this.key,
    required this.path,
    required this.uiPage,
    this.pageRouteSettings = PageRouteSettings.defaultSettings,
    this.currentPageAction
  });

  final String key;
  final String path;
  final Pages uiPage;
  PageRouteSettings pageRouteSettings;
  PageAction? currentPageAction;
}

class PageRouteSettings {
  const PageRouteSettings({
    this.backgroundOpaque = true,
    this.barrierDismissible = false,
    this.fullScreenDialog = false,
    this.barrierColor,
  });

  static const defaultSettings = PageRouteSettings();

  final Color? barrierColor;
  final bool backgroundOpaque;
  final bool barrierDismissible;
  final bool fullScreenDialog;
}

// Page Configurations
const String PathHome = '/home';
PageConfiguration ConfigHome = PageConfiguration(key: 'Home', path: PathHome, uiPage: Pages.Home);

const String PathLogin = '/login';
PageConfiguration ConfigLogin = PageConfiguration(key: 'Login', path: PathLogin, uiPage: Pages.Login);