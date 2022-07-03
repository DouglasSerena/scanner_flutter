import 'package:flutter/material.dart';

import './colors/theme_colors_dark.dart';
import './colors/theme_colors_light.dart';

enum THEME { dark, light }

Map<THEME, ThemeData> themes = {
  THEME.light: themeColorsLight,
  THEME.dark: themeColorsDark,
};
