import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'custom_page_route_builder.dart';
import 'pages.dart';

/*
class PageAction {
  PageAction({this.state = PageState.none, this.page, this.pages, this.widget});

  PageState state;
  PageConfiguration? page;
  List<PageConfiguration>? pages;
  Widget? widget;
}*/

enum PageState { none, addPage, addAll, addWidget, pop, replace, replacePush, replaceAll }

class AppRouter extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouter._instance() : navigatorKey = GlobalKey<NavigatorState>() {
    _pages.add(_createPage(const SplashRoute()));
  }
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
    debugPrint('Route pushed: ${route.id}');
    _addPage(route);
  }

  void pop({AppRoute? route}) {
    if (route != null) {
      final initialPageCount = _pages.length;
      _pages.removeWhere((page) => page.arguments == route);

      if (_pages.length < initialPageCount) {
        debugPrint('Route popped: ${route.id}');
        notifyListeners();
      } else {
        debugPrint('Route not found: ${route.id}');
      }
    } else if (canPop()) {
      if (canPop()) {
        final removedPage = _pages.removeLast();
        final removedRoute = removedPage.arguments as AppRoute?;
        debugPrint('Route popped last page: ${removedRoute?.id ?? 'unknown'}');
        notifyListeners();
      } else {
        debugPrint('Route pop called. There is one or no page. ${route}');
      }
    }
  }

  void replace(AppRoute route) {
    if (canPop()) {
      pop();
    }
    push(route);
  }

  void replaceAll(AppRoute route) {
    _pages.clear();
    _addPage(route);
  }

  late Completer<dynamic> _resultCompleter;

  Future<dynamic> pushForResult(AppRoute route) async {
    _resultCompleter = Completer<dynamic>();
    push(route);
    return _resultCompleter.future;
  }

  void returnWithResult<T>(T result) {
    if (!_resultCompleter.isCompleted) {
      _resultCompleter.complete(result);
      pop();
    }
  }

  @override
  Future<void> setNewRoutePath(AppRoute configuration) {
    _pages.clear();
    _addPage(configuration);
    return SynchronousFuture(null);
  }

  @override
  Future<bool> popRoute() {
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
    return Navigator(key: navigatorKey, pages: List.of(_pages), onDidRemovePage: (page) => pop());
  }
}

/*class AppRouter extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final NavigationBloc navigationBloc;

  AppRouter(this.navigationBloc) {
    navigationBloc.stream.listen((_) => notifyListeners());
  }

  @override
  PageConfiguration? get currentConfiguration =>
      navigationBloc.state.pages.isNotEmpty ? navigationBloc.state.pages.last : null;

  Page _createPage(Widget child, PageConfiguration pageConfig) {
    return CustomPageRouteBuilder(
      child: child,
      pageRouteSettings: pageConfig.pageRouteSettings,
      key: ValueKey(pageConfig.key),
      arguments: pageConfig,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Page> pages = navigationBloc.state.pages.map((pageConfig) {
      switch (pageConfig.uiPage) {
        case Pages.Home:
          return _createPage(PageHome(), pageConfig);
        case Pages.Login:
          return _createPage(PageLogin(), pageConfig);
        }
    }).toList();
    debugPrint(pages.toString());
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onDidRemovePage: (page) {
        navigationBloc.add(PopPage());
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    navigationBloc.add(ReplaceAllPages(configuration));
  }
}
*/
/*
class AppRouter extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouter._instance() : navigatorKey = GlobalKey<NavigatorState>();

  static final AppRouter _start = AppRouter._instance();
  static AppRouter get instance => _start;

  final List<Page> _pages = [];
  List<Page> get pages => List.unmodifiable(_pages);

  @override
  PageConfiguration? get currentConfiguration {
    if (_pages.isEmpty) {
      return null;
    }
    return _pages.last.arguments as PageConfiguration?;
  }

  late Completer<dynamic> _resultCompleter;

  Future<dynamic> pushForResult({
    required Widget child,
    required PageConfiguration pageConfig,
  }) async {
    _resultCompleter = Completer<dynamic>();
    _addPageData(child, pageConfig);
    return _resultCompleter.future;
  }

  void returnWithResult<T>(T result) {
    if (canPop() && _resultCompleter.isCompleted == false) {
      _resultCompleter.complete(result);
      pop();
    }
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    _pages.clear();
    addPage(pageConfig: configuration);
    return SynchronousFuture(null);
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      pop();
      return Future.value(true);
    }
    return Future.value(false);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }

    if (_pages.isNotEmpty) {
      _pages.removeLast();
      notifyListeners();
    }
    return true;
  }

  bool canPop() {
    return _pages.length > 1;
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(_createPage(child, pageConfig));
    notifyListeners();
  }

  Page _createPage(Widget child, PageConfiguration pageConfig) {
    return CustomPageRouteBuilder(
      child: child,
      pageRouteSettings: pageConfig.pageRouteSettings,
      key: ValueKey(pageConfig.key),
      arguments: pageConfig,
    );
  }

  void pop() {
    if (canPop()) {
      _pages.removeLast();
      notifyListeners();
    }
  }

  void push(PageConfiguration pageConfig) {
    addPage(pageConfig: pageConfig);
  }

  void pushWidget({required Widget child, required PageConfiguration pageConfig}) {
    _addPageData(child, pageConfig);
  }

  void replace(PageConfiguration pageConfig) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(pageConfig: pageConfig);
  }

  void replaceWidget({required Widget child, required PageConfiguration pageConfig}) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    _addPageData(child, pageConfig);
  }

  void replaceAll(PageConfiguration pageConfig) {
    _pages.clear();
    addPage(pageConfig: pageConfig);
  }

  void replaceAllWidget({required Widget child, required PageConfiguration pageConfig}) {
    _pages.clear();
    _addPageData(child, pageConfig);
  }

  void addAll(List<PageConfiguration> routes) {
    _pages.clear();
    for (var route in routes) {
      addPage(pageConfig: route);
    }
  }

  void addPage({required PageConfiguration pageConfig}) {
    final shouldAddPage = _pages.isEmpty || (currentConfiguration?.key != pageConfig.key);

    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.Home:
          _addPageData(const PageHome(), pageConfig);
          break;
        case Pages.Login:
          _addPageData(PageLogin(), pageConfig);
          break;
        case Pages.Register:
          _addPageData(PageRegister(), pageConfig);
        default:
          Placeholder();
          break;
      }
    }
  }
  /*void _addWidget(Widget child, PageConfiguration pageConfig) {
    _addPageData(child, pageConfig);
  }
  List<Page> _buildPages() {
    final action = _appState.currentAction;

    switch (action.state) {
      case PageState.none:
        break;
      case PageState.addPage:
        if (action.page != null) {
          addPage(pageConfig: action.page!);
        }
        break;
      case PageState.addAll:
        if (action.pages != null) {
          addAll(action.pages!);
        }
        break;
      case PageState.addWidget:
        if (action.widget != null && action.page != null) {
          _addWidget(action.widget!, action.page!);
        }
        break;
      case PageState.pop:
        pop();
        break;
      case PageState.replace:
        if (action.page != null) {
          replace(action.page!);
        }
        break;
      case PageState.replacePush:
        if (action.page != null) {
          pop();
          addPage(pageConfig: action.page!);
        }
        break;
      case PageState.replaceAll:
        if (action.page != null) {
          replaceAll(action.page!);
        }
        break;
    }
    _appState.resetCurrentAction();
    return List.of(_pages);
  }*/

  @override
  Widget build(BuildContext context) {
    return Navigator(key: navigatorKey, pages: List.of(_pages), onPopPage: _onPopPage);
  }
}
*/
