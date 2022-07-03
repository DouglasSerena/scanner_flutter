import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_flutter/config/theme/theme_config.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(themes[THEME.dark]!);

  void changeLight() {
    emit(themes[THEME.light]!);
  }

  void changeDark() {
    emit(themes[THEME.dark]!);
  }
}
