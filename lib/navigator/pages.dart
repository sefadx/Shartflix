import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../pages/auth/login.dart';
import '../pages/auth/register.dart';
import '../pages/home.dart';
import '../pages/popup/popup_info.dart';
import '../pages/splash.dart';

@immutable
abstract class AppRoute {
  const AppRoute();
  Widget build();
  String get id => runtimeType.toString() + hashCode.toString();
  PageRouteSettings get pageRouteSettings => PageRouteSettings.defaultSettings;
}

class SplashRoute extends AppRoute {
  const SplashRoute();
  @override
  Widget build() => const PageSplash();
}

class HomeRoute extends AppRoute {
  const HomeRoute();
  @override
  Widget build() => const PageHome();
}

class LoginRoute extends AppRoute {
  const LoginRoute();
  @override
  Widget build() => const PageLogin();
}

class RegisterRoute extends AppRoute {
  const RegisterRoute();
  @override
  Widget build() => const PageRegister();
}

class PopupInfoRoute extends AppRoute with EquatableMixin {
  final String? title, message;
  const PopupInfoRoute({this.title, this.message});

  @override
  Widget build() => PagePopupInfo(title: title, message: message);

  @override
  PageRouteSettings get pageRouteSettings =>
      const PageRouteSettings(backgroundOpaque: false, barrierDismissible: true);
  @override
  List<Object?> get props => [title, message];
}

class PopupLoadingRoute extends AppRoute {
  const PopupLoadingRoute();
  @override
  Widget build() => const Center(child: CircularProgressIndicator());
  @override
  PageRouteSettings get pageRouteSettings =>
      const PageRouteSettings(backgroundOpaque: false, barrierDismissible: true);
}
/*
class ProfileRoute extends AppRoute {
  final String userId;
  const ProfileRoute({required this.userId});

  @override
  Widget build(BuildContext context) => PageProfile(userId: userId);
}
*/

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

/*
enum Pages { Home, Login, Register }

class PageConfiguration {
  PageConfiguration({
    required this.key,
    required this.path,
    required this.uiPage,
    this.pageRouteSettings = PageRouteSettings.defaultSettings,
    this.currentPageAction,
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
PageConfiguration ConfigLogin = PageConfiguration(
  key: 'Login',
  path: PathLogin,
  uiPage: Pages.Login,
);

const String PathRegister = '/register';
PageConfiguration ConfigRegister = PageConfiguration(
  key: 'Register',
  path: PathRegister,
  uiPage: Pages.Register,
);
*/
