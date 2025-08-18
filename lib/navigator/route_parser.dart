import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'pages.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  @override
  Future<AppRoute> parseRouteInformation(RouteInformation routeInformation) {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return SynchronousFuture(const LoginRoute());
    }

    final segments = uri.pathSegments;

    switch (segments.first) {
      case 'home':
        return SynchronousFuture(const HomeRoute());

      case 'login':
        return SynchronousFuture(const LoginRoute());

      case 'register':
        return SynchronousFuture(const RegisterRoute());
      /*
      case 'profile':
        if (segments.length > 1) {
          final userId = segments[1];
          return SynchronousFuture(ProfileRoute(userId: userId));
        }
        return SynchronousFuture(const LoginRoute());
        */

      default:
        return SynchronousFuture(const LoginRoute());
    }
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoute configuration) {
    String location;

    if (configuration is HomeRoute) {
      location = '/home';
    } else if (configuration is LoginRoute) {
      location = '/login';
    } else if (configuration is RegisterRoute) {
      location = '/register';
    } /*else if (configuration is ProfileRoute) {
      location = '/profile/${configuration.userId}';
    }*/ else {
      // 404 page
      return null;
    }

    return RouteInformation(uri: Uri.parse(location));
  }
}
