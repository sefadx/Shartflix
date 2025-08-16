import 'package:flutter/material.dart';

/// Theme.of(context).extension<CustomThemeExtension>()!
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  ///gap size 2.0
  final double gapxxsmall;

  ///gap size 5.0
  final double gapxsmall;

  ///gap size 10.0
  final double gapsmall;

  ///gap size 15.0
  final double gapmedium;

  ///gap size 20.0
  final double gaplarge;

  ///gap size 30.0
  final double gapxlarge;

  ///gap size 40.0
  final double gapxxlarge;

  ///gap size 60.0
  final double gapxxxlarge;

  ///radius size 8.0
  final double radiussmall;

  ///radius size 12.0
  final double radiusmedium;

  ///radius size 16.0
  final double radiuslarge;

  const CustomThemeExtension({
    this.gapxxsmall = 2.0,
    this.gapxsmall = 5.0,
    this.gapsmall = 10.0,
    this.gapmedium = 15.0,
    this.gaplarge = 20.0,
    this.gapxlarge = 30.0,
    this.gapxxlarge = 40.0,
    this.gapxxxlarge = 60.0,
    this.radiussmall = 8.0,
    this.radiusmedium = 12.0,
    this.radiuslarge = 16.0,
  });

  @override
  ThemeExtension<CustomThemeExtension> copyWith() {
    return CustomThemeExtension(
      gapxxsmall: gapxxsmall,
      gapxsmall: gapxsmall,
      gapsmall: gapsmall,
      gapmedium: gapmedium,
      gaplarge: gaplarge,
      gapxlarge: gapxlarge,
      gapxxlarge: gapxxlarge,
      gapxxxlarge: gapxxxlarge,
      radiussmall: radiussmall,
      radiusmedium: radiusmedium,
      radiuslarge: radiuslarge,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return this;
  }
}
