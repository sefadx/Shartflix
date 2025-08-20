import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../pages/auth/login.dart';
import '../pages/auth/register.dart';
import '../pages/home.dart';
import '../pages/photo_upload.dart';
import '../pages/popup/popup_info.dart';
import '../pages/popup/popup_offer.dart';
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
  Widget build() => PageHome();
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

class PhotoUploadRoute extends AppRoute {
  const PhotoUploadRoute();
  @override
  Widget build() => const PagePhotoUpload();
}

// ---------  Popup Routes  -------------

class PopupInfoRoute extends AppRoute with EquatableMixin {
  final String? title, message;
  const PopupInfoRoute({this.title, this.message});

  @override
  String get id => runtimeType.toString();

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
  PageRouteSettings get pageRouteSettings => const PageRouteSettings(
    fullScreenDialog: true,
    backgroundOpaque: false,
    barrierDismissible: false,
  );
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
