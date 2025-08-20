import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'custom_page_route_builder.dart';
import 'pages.dart';

enum PageState { none, addPage, addAll, addWidget, pop, replace, replacePush, replaceAll }

class AppRouter extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouter._instance() : navigatorKey = GlobalKey<NavigatorState>();
  static final AppRouter _start = AppRouter._instance();
  static AppRouter get instance => _start;

  final List<Page> _pages = [];
  List<Page> get pages => List.unmodifiable(_pages);

  @override
  AppRoute? get currentConfiguration {
    if (_pages.isEmpty) return null;
    final arguments = _pages.last.arguments;
    return arguments is AppRoute ? arguments : null;
  }

  void _addPage(AppRoute route) {
    debugPrint('AppRoute _addPage(): ${route.id}');
    _pages.add(_createPage(route));
    notifyListeners();
  }

  Page _createPage(AppRoute route) {
    return CustomPageRouteBuilder(
      child: route.build(),
      pageRouteSettings: route.pageRouteSettings,
      key: ValueKey(route.id),
      arguments: route,
    );
  }

  // --- Navigation methods ---

  bool canPop() => _pages.length > 1;

  void push(AppRoute route) {
    debugPrint('AppRoute push(): ${route.id}');
    _addPage(route);
  }

  void pop({AppRoute? route}) {
    if (route != null) {
      final initialPageCount = _pages.length;
      _pages.removeWhere((page) => page.arguments == route);

      if (_pages.length < initialPageCount) {
        debugPrint('AppRoute pop(): ${route.id}');
        notifyListeners();
      } else {
        debugPrint('AppRoute pop() not found: ${route.id}');
      }
    } else if (canPop()) {
      if (canPop()) {
        final removedPage = _pages.removeLast();
        final removedRoute = removedPage.arguments as AppRoute?;
        debugPrint('AppRoute pop() last page: ${removedRoute?.id ?? 'unknown'}');
        notifyListeners();
      } else {
        debugPrint('AppRoute pop(). There is one or no page. ${route}');
      }
    }
  }

  void replace(AppRoute route) {
    debugPrint('AppRoute replace(): ${route.id}');
    if (canPop()) {
      pop();
    }
    push(route);
  }

  void replaceAll(AppRoute route) {
    debugPrint('AppRoute replaceAll(): ${route.id}');
    _pages.clear();
    _addPage(route);
  }

  late Completer<dynamic> _resultCompleter;

  Future<dynamic> pushForResult(AppRoute route) async {
    debugPrint('AppRoute pushForResult(): ${route.id}');
    _resultCompleter = Completer<dynamic>();
    push(route);
    return _resultCompleter.future;
  }

  void returnWithResult<T>(T result) {
    debugPrint('AppRoute returnWithResult()');
    if (!_resultCompleter.isCompleted) {
      _resultCompleter.complete(result);
      pop();
    }
  }

  @override
  Future<void> setNewRoutePath(AppRoute route) {
    debugPrint('AppRoute setNewRoutePath(): ${route.id}');
    _pages.clear();
    _addPage(route);
    return SynchronousFuture(null);
  }

  @override
  Future<bool> popRoute() {
    debugPrint('AppRoute popRoute()');
    if (canPop()) {
      pop();
      return Future.value(true);
    }
    return Future.value(false);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) return false;

    if (canPop()) {
      _pages.removeLast();
      notifyListeners();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onDidRemovePage: (page) {},
      //onPopPage: _onPopPage,
    );
  }
}
