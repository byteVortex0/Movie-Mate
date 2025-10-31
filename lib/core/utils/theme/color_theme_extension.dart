import 'package:flutter/material.dart';
import 'package:movie_mate/core/utils/color_manager.dart';

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  final Color? bgColor;
  final Color? bgToolbarColor;
  final Color? textColor;
  final Color? toolbarTextColor;
  final Color? cardColor;

  const ColorThemeExtension({
    required this.bgColor,
    required this.bgToolbarColor,
    required this.textColor,
    required this.toolbarTextColor,
    required this.cardColor,
  });

  @override
  ThemeExtension<ColorThemeExtension> copyWith({
    Color? bgColor,
    Color? bgToolbarColor,
    Color? textColor,
    Color? toolbarTextColor,
    Color? cardColor,
  }) {
    return ColorThemeExtension(
      bgColor: bgColor ?? this.bgColor,
      bgToolbarColor: bgToolbarColor ?? this.bgToolbarColor,
      textColor: textColor ?? this.textColor,
      toolbarTextColor: toolbarTextColor ?? this.toolbarTextColor,
      cardColor: cardColor ?? this.cardColor,
    );
  }

  @override
  ThemeExtension<ColorThemeExtension> lerp(
    covariant ThemeExtension<ColorThemeExtension>? other,
    double t,
  ) {
    if (other is! ColorThemeExtension) {
      return this;
    }
    return ColorThemeExtension(
      bgColor: Color.lerp(bgColor, other.bgColor, t),
      bgToolbarColor: Color.lerp(bgToolbarColor, other.bgToolbarColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      toolbarTextColor: Color.lerp(toolbarTextColor, other.toolbarTextColor, t),
      cardColor: Color.lerp(cardColor, other.cardColor, t),
    );
  }

  static const ColorThemeExtension light = ColorThemeExtension(
    bgColor: Colors.white,
    bgToolbarColor: Colors.blue,
    textColor: Colors.black,
    toolbarTextColor: Colors.white,
    cardColor: LightColorManager.cardColor,
  );

  static const ColorThemeExtension dark = ColorThemeExtension(
    bgColor: DarkColorManager.bgColor,
    bgToolbarColor: DarkColorManager.bgToolbarColor,
    textColor: Colors.white,
    toolbarTextColor: DarkColorManager.toolbarTextColor,
    cardColor: DarkColorManager.cardColor,
  );
}
