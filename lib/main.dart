import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/theme/theme_bloc.dart';
import 'gen/app_localizations.dart';
import 'navigator/app_router.dart';
import 'navigator/back_dispatcher.dart';
import 'navigator/pages.dart';
import 'navigator/route_parser.dart';
import 'repositories/token_repository.dart';
import 'theme/app_theme.dart';

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
  late final AppRouter _router;
  late final CustomBackButtonDispatcher _backButtonDispatcher;
  late final AppRouteInformationParser _routeInformationParser;
  final tokenRepository = TokenRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => AuthBloc(tokenRepository: tokenRepository)..add(AppStarted()))
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state){
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          supportedLocales: const [
            Locale('tr', ''),
            Locale('en', ''),
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerDelegate: _router,
          routeInformationParser: _routeInformationParser,
          backButtonDispatcher: _backButtonDispatcher,
        );
      }),
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