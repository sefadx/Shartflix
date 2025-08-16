import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shartflix/components/buttons/custom_button.dart';
import 'package:shartflix/components/login_icon.dart';
import '../../components/textfields/custom_textfield.dart';
import '../../gen/app_localizations.dart';
import '../../theme/theme_extension.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: customTheme.gapmedium,
            horizontal: customTheme.gapxlarge,
          ),
          child: Column(
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
              CustomTextField(hintText: text.email, prefixIcon: Icons.email_outlined),

              SizedBox(height: customTheme.gapmedium),
              CustomTextField(
                hintText: text.password,
                prefixIcon: Icons.lock_outline,
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: customTheme.gapxsmall),
                    Icon(Icons.visibility, color: theme.colorScheme.secondary, size: 30),
                    SizedBox(width: customTheme.gapxlarge),
                  ],
                ),
              ),

              SizedBox(height: customTheme.gapxlarge),
              RichText(
                text: TextSpan(
                  text: text.loginForgotPassword,
                  style: theme.textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ),
              SizedBox(height: customTheme.gapxlarge),
              CustomButton(text: text.login, onTap: () {}),
              SizedBox(height: customTheme.gapxxxlarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoginIcon(icon: Icons.g_mobiledata),
                  SizedBox(width: customTheme.gapmedium),
                  LoginIcon(icon: Icons.apple, onTap: () {}),
                  SizedBox(width: customTheme.gapmedium),
                  LoginIcon(icon: Icons.facebook),
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
                      text: text.signUp,
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
