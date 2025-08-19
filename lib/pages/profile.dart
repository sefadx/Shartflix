import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_state.dart';
import '../gen/app_localizations.dart';
import '../theme/theme_extension.dart';

class PageProfile extends StatelessWidget {
  const PageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthBloc>().auth!; //If you are in then have the token
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (pre, curr) => pre.runtimeType != curr.runtimeType,
      listener: (context, state) {},
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Placeholder();
        },
      ),
    );
  }
}
