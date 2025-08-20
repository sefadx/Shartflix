import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/bloc/profile/profile_event.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../components/buttons/custom_button.dart';
import '../gen/app_localizations.dart';
import '../navigator/app_router.dart';
import '../navigator/pages.dart';
import '../theme/theme_extension.dart';
import 'popup/popup_offer.dart';

class PageProfile extends StatelessWidget {
  const PageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthBloc>().auth!;
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (pre, curr) => pre.runtimeType != curr.runtimeType,
      listener: (context, state) {
        if (state is ProfileInformation && state.user != null) {
          context.read<AuthBloc>().tokenRepository.saveTokens(auth: state.user!.token);
        } else if (state is ProfileFailure) {
          AppRouter.instance.pop(route: const PopupLoadingRoute());
          AppRouter.instance.push(PopupInfoRoute(title: text.failure, message: state.message));
        } else if (state is ProfileFavoriteMovieFailure) {
          AppRouter.instance.pop(route: const PopupLoadingRoute());
          AppRouter.instance.push(PopupInfoRoute(title: text.failure, message: state.message));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: theme.colorScheme.background,
          elevation: 0,
          toolbarOpacity: 0,
          scrolledUnderElevation: 0,
          title: Text(text.profileDetail, style: theme.textTheme.titleMedium),
          actionsPadding: EdgeInsets.all(customTheme.gapmedium),
          actions: [
            CustomButton(
              icon: Icon(Icons.diamond, size: 20),
              text: text.limitedOffer,
              textStyle: theme.textTheme.titleSmall,
              padding: EdgeInsets.symmetric(
                horizontal: customTheme.gaplarge,
                vertical: customTheme.gapsmall,
              ),
              radius: customTheme.radiusxxlarge,
              onTap:
                  () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return const PagePopupOffer();
                    },
                  ),
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                context.read<ProfileBloc>().add(ProfilePageFetched());
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.all(customTheme.gapxxlarge),
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                            child:
                                state.user?.photoUrl != null
                                    ? Image.network(state.user!.photoUrl!)
                                    : Icon(Icons.person, size: 70),
                          ),
                        ),
                        SizedBox(width: customTheme.gapmedium),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                auth.name.toString(),
                                style: theme.textTheme.headlineSmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "ID: ${auth.id}",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.50),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: customTheme.gapmedium),
                        CustomButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: customTheme.gapmedium,
                            vertical: customTheme.gapsmall,
                          ),
                          radius: customTheme.radiussmall,
                          text: text.addPhoto,
                          textStyle: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                          onTap: () => AppRouter.instance.push(const PhotoUploadRoute()),
                        ),
                      ],
                    ),
                    SizedBox(height: customTheme.gapxxlarge),
                    Text(text.likedYourMovies, style: theme.textTheme.titleSmall),
                    SizedBox(height: customTheme.gapmedium),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.listFavoriteMovie.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: customTheme.gaplarge,
                        childAspectRatio: 9 / 13,
                        crossAxisSpacing: customTheme.gapmedium,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(customTheme.radiuslarge),
                                child: Image.network(
                                  state.listFavoriteMovie.elementAt(index).fixPosterUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: customTheme.gapsmall),
                            Text(
                              state.listFavoriteMovie.elementAt(index).Title,
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              state.listFavoriteMovie.elementAt(index).Director,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
