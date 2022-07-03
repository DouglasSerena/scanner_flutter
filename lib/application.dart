import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_flutter/config/theme/cubit/theme_cubit.dart';
import 'package:scanner_flutter/modules/home/screens/home_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: _build,
      ),
    );
  }

  Widget _build(BuildContext context, ThemeData state) {
    return MaterialApp(
      theme: state,
      title: 'Application',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
