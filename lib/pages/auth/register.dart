import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/login/login_cubit.dart';
import '../../bloc/register/register_cubit.dart';
import '../../components/buttons/custom_button.dart';
import '../../components/buttons/login_icon.dart';
import '../../components/textfields/custom_textfield.dart';
import '../../gen/app_localizations.dart';
import '../../navigator/app_router.dart';
import '../../navigator/pages.dart';
import '../../theme/theme_extension.dart';

class PageRegister extends StatelessWidget {
  const PageRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: BlocListener<RegisterCubit, RegisterState>(
          listenWhen: (previous, current) => current.status != FormStatus.initial,
          listener: (context, state) {
            switch (state.status) {
              case FormStatus.initial:
                break;
              case FormStatus.validating:
                String message = '';
                if (!state.isFullNameValid) {
                  message += "${text.fullNameValid}\n";
                }
                if (!state.isEmailValid) {
                  message += "${text.emailValid}\n";
                }
                if (!state.isPasswordValid) {
                  message += "${text.passwordValid}\n";
                }
                if (state.password != state.rePassword) {
                  message += "${text.rePasswordCheck}\n";
                }
                if (!state.checkAgreement) {
                  message += "${text.agreementCheck}\n";
                }
                if (message.isEmpty) {
                  message = text.unknownError;
                }
                AppRouter.instance.push(PopupInfoRoute(title: text.warning, message: message));
                break;
              case FormStatus.success:
                context.read<AuthBloc>().add(
                  RegisterRequested(name: state.name, email: state.email, password: state.password),
                );
                break;
            }
            context.read<RegisterCubit>().resetFromStatus();
          },
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: customTheme.gapmedium,
                horizontal: customTheme.gapxlarge,
              ),
              child: SubRegisterForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class SubRegisterForm extends StatefulWidget {
  const SubRegisterForm({super.key});

  @override
  State<SubRegisterForm> createState() => _SubRegisterFormState();
}

class _SubRegisterFormState extends State<SubRegisterForm> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

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

    return BlocBuilder<RegisterCubit, RegisterState>(
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
              controller: _fullNameController,
              hintText: text.fullName,
              prefixIcon: Icons.person_add_alt,
              onChanged: (text) => context.read<RegisterCubit>().fullNameChanged(text),
            ),

            SizedBox(height: customTheme.gapmedium),

            CustomTextField(
              controller: _emailController,
              hintText: text.email,
              prefixIcon: Icons.email_outlined,
              onChanged: (text) => context.read<RegisterCubit>().emailChanged(text),
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
                    onPressed: () => context.read<RegisterCubit>().togglePasswordVisibility(),
                  ),
                  SizedBox(width: customTheme.gapxlarge),
                ],
              ),
              onChanged: (text) => context.read<RegisterCubit>().passwordChanged(text),
            ),

            SizedBox(height: customTheme.gapmedium),

            CustomTextField(
              controller: _rePasswordController,
              obscureText: !state.isPasswordVisible,
              hintText: text.rePassword,
              prefixIcon: Icons.lock_open_outlined,
              onChanged: (text) => context.read<RegisterCubit>().rePasswordChanged(text),
            ),

            SizedBox(height: customTheme.gapxlarge),

            RichText(
              text: TextSpan(
                text: text.userAgreementPart1,
                style: theme.textTheme.bodyMedium,
                recognizer: TapGestureRecognizer()..onTap = () {},
                children: [
                  TextSpan(
                    text: text.userAgreementPart2,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint("User Agreement tapped.");
                            context.read<RegisterCubit>().checkAgreement();
                          },
                  ),
                  TextSpan(text: " ${text.pleaseReadAgreement}"),
                ],
              ),
            ),

            SizedBox(height: customTheme.gapxlarge),

            CustomButton(text: text.signUpRightNow, onTap: context.read<RegisterCubit>().submit),

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
                text: "${text.alreadyHaveAccount} ",
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary),
                children: [
                  TextSpan(
                    text: text.alreadyHaveAccountLogIn,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint("${text.alreadyHaveAccount} tapped.");
                            AppRouter.instance.replaceAll(LoginRoute());
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
