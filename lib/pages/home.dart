import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/bloc/profile/profile_bloc.dart';
import 'package:shartflix/bloc/profile/profile_event.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../components/buttons/navigation_button.dart';
import '../gen/app_localizations.dart';
import '../navigator/app_router.dart';
import '../navigator/pages.dart';
import '../theme/theme_extension.dart';
import 'profile.dart';

class PageHome extends StatelessWidget {
  PageHome({super.key});
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthBloc>().auth!;
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavCubit(0)),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(accessToken: auth.token)..add(HomeMovieFetched()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(accessToken: auth.token)..add(ProfileFetched()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<HomeBloc, HomeState>(
              listenWhen: (previous, current) => previous.runtimeType != current.runtimeType,
              listener: (context, state) {
                if (state is HomeLoading) {
                  AppRouter.instance.push(const PopupLoadingRoute());
                } else if (state is HomeNext) {
                  AppRouter.instance.pop(route: const PopupLoadingRoute());
                } else if (state is HomeMovieFavorite) {
                  AppRouter.instance.pop(route: const PopupLoadingRoute());
                } else if (state is HomeFailure) {
                  AppRouter.instance.pop(route: const PopupLoadingRoute());
                  AppRouter.instance.push(
                    PopupInfoRoute(title: text.error, message: state.message),
                  );
                }
              },
              child: BlocBuilder<NavCubit, int>(
                builder: (context, navIndex) {
                  return IndexedStack(
                    index: navIndex,
                    children: [_HomeBody(pageController: _pageController), PageProfile()],
                  );
                },
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                top: customTheme.gapxsmall,
                bottom: customTheme.gapxlarge,
                right: customTheme.gapxxxlarge,
                left: customTheme.gapxxxlarge,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: NavBarButton(
                      icon: Icons.home_outlined,
                      text: text.homePage,
                      onTap: () {
                        final navCubit = context.read<NavCubit>();
                        if (navCubit.state == 0 &&
                            _pageController.page != _pageController.initialPage) {
                          _pageController.animateToPage(
                            _pageController.initialPage,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linearToEaseOut,
                          );
                        } else if (navCubit.state == 0) {
                          AppRouter.instance.replaceAll(HomeRoute());
                        } else {
                          navCubit.changeIndex(0);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: customTheme.gaplarge),
                  Expanded(
                    child: NavBarButton(
                      icon: Icons.person,
                      text: text.profile,
                      onTap: () {
                        context.read<NavCubit>().changeIndex(1);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  final PageController pageController;
  const _HomeBody({required this.pageController});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeMovieFetched());
          },
          child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: state.listMovie.length,
            onPageChanged: (index) {
              if (state.listMovie.elementAt(index) == state.listMovie.last &&
                  state.pagination.currentPage < state.pagination.maxPage) {
                context.read<HomeBloc>().add(
                  HomeMovieFetched(page: state.pagination.currentPage + 1),
                );
              }
            },
            itemBuilder: (context, index) {
              return Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Ink(
                    color: Colors.transparent,
                    child: Center(
                      child: Image.network(
                        state.listMovie.elementAt(index).fixPosterUrl,
                        fit: BoxFit.fitHeight,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 120,
                    child: Material(
                      color: Colors.transparent,
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              theme.colorScheme.background,
                              theme.colorScheme.background.withOpacity(0.8),
                              theme.colorScheme.background.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(customTheme.gaplarge),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.image_outlined, size: 30),
                        SizedBox(width: customTheme.gaplarge),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.listMovie.elementAt(index).Title,
                                style: theme.textTheme.titleLarge,
                              ),
                              Text(
                                state.listMovie.elementAt(index).Plot,
                                style: theme.textTheme.bodyMedium,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 180,
                    right: 25,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(customTheme.radiuslarge),
                      onTap:
                          () => context.read<HomeBloc>().add(
                            HomeMovieFavoriteRequest(
                              favoriteId: state.listMovie.elementAt(index).id,
                            ),
                          ),
                      child: Material(
                        color: Colors.transparent,
                        child: Ink(
                          padding: EdgeInsets.symmetric(
                            vertical: customTheme.gaplarge,
                            horizontal: customTheme.gapsmall,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background.withOpacity(0.70),
                            border: Border.all(color: theme.colorScheme.secondary, width: 0.5),
                            borderRadius: BorderRadius.circular(customTheme.radiuslarge),
                          ),
                          child: Icon(
                            state.listMovie.elementAt(index).isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
