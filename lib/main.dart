import 'package:advice_app/application/advicer/advicer_bloc.dart';
import 'package:advice_app/application/theme/theme_service.dart';
import 'package:advice_app/presentation/advicer/advicer_page.dart';
import 'package:advice_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di.sl<ThemeService>().init();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => di.sl<ThemeService>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Advice App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeService.useSystemTheme
              ? ThemeMode.system
              : themeService.darkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
          home: BlocProvider(
            create: (BuildContext context) => di.sl<AdvicerBloc>(),
            child: const AdvicerPage(),
          ),
        );
      },
    );
  }
}
