import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_flutter/config/theme/cubit/theme_cubit.dart';

class IconButtonThemeWidget extends StatelessWidget {
  const IconButtonThemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        ThemeCubit theme = context.read<ThemeCubit>();

        return IconButton(
          onPressed: () async {
            if (state.brightness == Brightness.dark) {
              return theme.changeLight();
            }
            theme.changeDark();
          },
          icon: Icon(
            state.brightness == Brightness.dark
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
        );
      },
    );
  }
}
