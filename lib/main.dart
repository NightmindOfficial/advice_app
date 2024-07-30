import 'package:advice_app/application/advicer/advicer_bloc.dart';
import 'package:advice_app/presentation/advicer/advicer_page.dart';
import 'package:advice_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advice App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: BlocProvider(
        create: (BuildContext context) => di.sl<AdvicerBloc>(),
        child: const AdvicerPage(),
      ),
    );
  }
}
