import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../components/buttons/custom_button.dart';
import '../../gen/app_localizations.dart';
import '../../theme/theme_extension.dart';

class PagePopupOffer extends StatelessWidget {
  const PagePopupOffer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthBloc>().auth!;
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Ink(
          padding: EdgeInsets.all(customTheme.gaplarge),
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(customTheme.radiusxxlarge),
              topRight: Radius.circular(customTheme.radiusxxlarge),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text.limitedOffer,
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: customTheme.gapmedium),
              Text(
                text.offerDescription,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: customTheme.gapmedium),
              Ink(
                padding: EdgeInsets.all(customTheme.gaplarge),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(customTheme.radiuslarge),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(text.incomeBonuses, style: theme.textTheme.headlineSmall),
                    SizedBox(height: customTheme.gapxlarge),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _OfferIcon(icon: Icons.diamond, title: text.premiumAccount),
                        SizedBox(width: customTheme.gaplarge),
                        _OfferIcon(icon: Icons.handshake, title: text.moreMatch),
                        SizedBox(width: customTheme.gaplarge),
                        _OfferIcon(icon: Icons.arrow_upward, title: text.morePriority),
                        SizedBox(width: customTheme.gaplarge),
                        _OfferIcon(icon: Icons.favorite, title: text.moreLike),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: customTheme.gapmedium),
              Text(text.selectTokenOffer, style: theme.textTheme.headlineSmall),
              SizedBox(height: customTheme.gapxlarge),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _OfferCard(discount: 10, preTokenAmount: 200, tokenAmount: 330, price: 99.99),
                  SizedBox(width: customTheme.gapmedium),
                  _OfferCard(discount: 10, preTokenAmount: 2000, tokenAmount: 3375, price: 799.99),
                  SizedBox(width: customTheme.gapmedium),
                  _OfferCard(discount: 10, preTokenAmount: 1000, tokenAmount: 1350, price: 399.99),
                ],
              ),
              SizedBox(height: customTheme.gapmedium),
              CustomButton(text: text.seeAllTokens),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  final double tokenAmount, preTokenAmount, price;
  final double discount;
  const _OfferCard({
    required this.tokenAmount,
    required this.preTokenAmount,
    required this.price,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;

    final locale = Localizations.localeOf(context).toString();
    final currencyFormatted = NumberFormat.simpleCurrency(locale: locale);
    final percentFormatted = NumberFormat.decimalPattern(locale);

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Ink(
          height: 250,
          padding: EdgeInsets.all(customTheme.gapmedium),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withRed(150),
            borderRadius: BorderRadius.circular(customTheme.radiuslarge),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    preTokenAmount.toInt().toString(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    tokenAmount.toInt().toString(),
                    style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(text.token, style: theme.textTheme.titleMedium),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text.price(currencyFormatted.format(price)),
                    style: theme.textTheme.headlineSmall,
                  ),
                  Text(
                    text.perWeek,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -10,
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: customTheme.gaplarge,
              vertical: customTheme.gapxsmall,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withRed(100),
              borderRadius: BorderRadius.circular(customTheme.radiuslarge),
            ),
            child: Text(
              text.percentDiscount(percentFormatted.format(discount)),
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w200),
            ),
          ),
        ),
      ],
    );
  }
}

class _OfferIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  const _OfferIcon({required this.title, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customTheme = theme.extension<CustomThemeExtension>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Ink(
          padding: EdgeInsets.all(customTheme.gapsmall),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withRed(150),
            border: Border.all(color: theme.colorScheme.primary.withGreen(100), width: 4),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 50),
        ),
        SizedBox(height: customTheme.gapsmall),
        Text(title, style: theme.textTheme.titleSmall, textAlign: TextAlign.center),
      ],
    );
  }
}
