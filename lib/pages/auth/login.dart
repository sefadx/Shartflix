import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/login/login_cubit.dart';
import '../../components/buttons/custom_button.dart';
import '../../components/buttons/login_icon.dart';
import '../../components/textfields/custom_textfield.dart';
import '../../gen/app_localizations.dart';
import '../../navigator/app_router.dart';
import '../../navigator/pages.dart';
import '../../theme/theme_extension.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) => current.status != FormStatus.initial,
          listener: (context, state) {
            switch (state.status) {
              case FormStatus.initial:
                break;
              case FormStatus.validating:
                //No need validation when you login.
                // Password limits or username restrictions may change.
                break;
              case FormStatus.success:
                context.read<AuthBloc>().add(
                  LoginRequested(email: state.email, password: state.password),
                );
                break;
            }
            context.read<LoginCubit>().resetFromStatus();
          },
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: customTheme.gapmedium,
                horizontal: customTheme.gapxlarge,
              ),
              child: SubLoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class SubLoginForm extends StatefulWidget {
  const SubLoginForm({super.key});

  @override
  State<SubLoginForm> createState() => _SubLoginFormState();
}

class _SubLoginFormState extends State<SubLoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text.loginHello,
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: customTheme.gapsmall),
            Text(
              text.loginDescription,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: customTheme.gapxxxlarge),
            CustomTextField(
              controller: _emailController,
              hintText: text.email,
              prefixIcon: Icons.email_outlined,
              onChanged: (text) => context.read<LoginCubit>().emailChanged(text),
            ),

            SizedBox(height: customTheme.gapmedium),
            CustomTextField(
              controller: _passwordController,
              obscureText: !state.isPasswordVisible,
              hintText: text.password,
              prefixIcon: Icons.lock_open_outlined,
              suffix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: customTheme.gapxsmall),
                  IconButton(
                    icon: Icon(
                      state.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: theme.colorScheme.secondary,
                      size: 30,
                    ),
                    onPressed: () => context.read<LoginCubit>().togglePasswordVisibility(),
                  ),
                  SizedBox(width: customTheme.gapxlarge),
                ],
              ),
              onChanged: (text) => context.read<LoginCubit>().passwordChanged(text),
            ),

            SizedBox(height: customTheme.gapxlarge),
            RichText(
              text: TextSpan(
                text: text.loginForgotPassword,
                style: theme.textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint("Forgot password tapped.");
                      },
              ),
            ),
            SizedBox(height: customTheme.gapxlarge),
            CustomButton(text: text.login, onTap: context.read<LoginCubit>().submit),
            SizedBox(height: customTheme.gapxxxlarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                LoginIcon(icon: Icons.g_mobiledata, onTap: () {}),
                SizedBox(width: customTheme.gapmedium),
                LoginIcon(icon: Icons.apple, onTap: () {}),
                SizedBox(width: customTheme.gapmedium),
                LoginIcon(icon: Icons.facebook, onTap: () {}),
              ],
            ),
            SizedBox(height: customTheme.gapxxlarge),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${text.noAccount} ",
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary),
                children: [
                  TextSpan(
                    text: text.noAccountSignUp,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            AppRouter.instance.replaceAll(RegisterRoute());
                          },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
