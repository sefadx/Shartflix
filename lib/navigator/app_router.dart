import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../bloc/navigator/navigation_bloc.dart';
import '../view/home.dart';
import '../view/auth/login.dart';
import 'custom_page_route_builder.dart';
import 'pages.dart';

class PageAction {
  PageAction({
    this.state = PageState.none,
    this.page,
    this.pages,
    this.widget,
  });

  PageState state;
  PageConfiguration? page;
  List<PageConfiguration>? pages;
  Widget? widget;
}

enum PageState {
  none,
  addPage,
  addAll,
  addWidget,
  pop,
  replace,
  replacePush,
  replaceAll,
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


class AppRouter extends RouterDelegate<PageConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
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

  Future<dynamic> pushForResult({required Widget child, required PageConfiguration pageConfig}) async {
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

  void replaceAll(PageConfiguration pageConfig) {
    _pages.clear();
    addPage(pageConfig: pageConfig);
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

        default:
          //404 page
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
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
    );
  }
}