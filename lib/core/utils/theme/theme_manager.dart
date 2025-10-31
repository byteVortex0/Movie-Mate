import 'package:flutter/material.dart';
import 'package:movie_mate/core/utils/theme/color_theme_extension.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    extensions: const <ThemeExtension<dynamic>>[ColorThemeExtension.light],
  );

  static ThemeData darkTheme = ThemeData(
    extensions: const <ThemeExtension<dynamic>>[ColorThemeExtension.dark],
  );
}
