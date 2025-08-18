import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_event.dart';
import 'bloc/auth/auth_state.dart';
import 'bloc/theme/theme_bloc.dart';
import 'gen/app_localizations.dart';
import 'navigator/app_router.dart';
import 'navigator/back_dispatcher.dart';
import 'navigator/pages.dart';
import 'navigator/route_parser.dart';
import 'repositories/token_repository.dart';
import 'theme/app_theme.dart';

void main() {
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      debugPrint('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
  final tokenRepository = TokenRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => AuthBloc(tokenRepository: tokenRepository)..add(AppStarted())),
      ],
      child: Shartflix(),
    ),
  );
}

class Shartflix extends StatelessWidget {
  Shartflix({super.key}) {
    _router = AppRouter.instance;
    _backButtonDispatcher = CustomBackButtonDispatcher(_router);
    _routeInformationParser = AppRouteInformationParser();
  }

  late final AppRouter _router;
  late final CustomBackButtonDispatcher _backButtonDispatcher;
  late final AppRouteInformationParser _routeInformationParser;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        if (state is Authenticated) {
          AppRouter.instance.replaceAll(HomeRoute());
        } else if (state is Unauthenticated) {
          AppRouter.instance.replaceAll(LoginRoute());
        } else if (state is AuthLoading) {
          AppRouter.instance.push(const PopupLoadingRoute());
        } else if (state is AuthFailure) {
          AppRouter.instance.pop(route: const PopupLoadingRoute());
          AppRouter.instance.push(PopupInfoRoute(message: state.error));
        }
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            routerDelegate: _router,
            routeInformationParser: _routeInformationParser,
            backButtonDispatcher: _backButtonDispatcher,
          );
        },
      ),
    );
  }
}

/*
void main() {
  runApp(Shartflix());
}

class Shartflix extends StatelessWidget {
  Shartflix({super.key}){
    _router = AppRouter.instance;
    _backButtonDispatcher = CustomBackButtonDispatcher(_router);
    _routeInformationParser = AppRouteInformationParser();
    _router.setNewRoutePath(ConfigLogin);
  }

  final AppState appState = AppState.instance;
  late final AppRouter _router;
  late final CustomBackButtonDispatcher _backButtonDispatcher;
  late final AppRouteInformationParser _routeInformationParser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      //theme: appState.themeData,
      routerDelegate: _router,
      routeInformationParser: _routeInformationParser,
      backButtonDispatcher: _backButtonDispatcher,
    );
  }
}*/
