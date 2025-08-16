import 'package:flutter/material.dart';
import 'pages.dart';

class AppRouteInformationParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return ConfigLogin;
    }

    switch (uri.pathSegments.first) {
      case 'home':
        return ConfigHome;
      case 'login':
        return ConfigLogin;
      default:
        return ConfigLogin;
    }
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    return RouteInformation(location: configuration.path);
  }
}