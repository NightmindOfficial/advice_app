import 'package:advice_app/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

abstract class ThemeService extends ChangeNotifier {
  late bool darkMode;
  late bool useSystemTheme;

  Future<void> toggleTheme();
  Future<void> toggleUseSystemTheme();

  Future<void> setTheme({required bool mode});
  Future<void> setUseSystemTheme({required bool systemTheme});

  Future<void> init();
}

class ThemeServiceImpl extends ChangeNotifier implements ThemeService {
  final ThemeRepository themeRepository;

  ThemeServiceImpl({
    required this.themeRepository,
  });

  @override
  bool darkMode = true;

  @override
  late bool useSystemTheme;

  //* Initialization

  @override
  Future<void> init() async {
    final useSystemThemeOrFailure = await themeRepository.getUseSystemTheme();

    useSystemThemeOrFailure.fold((failure) async {
      await setUseSystemTheme(systemTheme: false);
    }, (useSystemTheme) async {
      await setUseSystemTheme(systemTheme: useSystemTheme);
    });

    final modeOrFailure = await themeRepository.getThemeMode();
    modeOrFailure.fold((failure) {
      setTheme(mode: darkMode);
    }, (mode) {
      setTheme(mode: mode);
    });
  }

  //* Theme Switch

  @override
  Future<void> setTheme({required bool mode}) async {
    darkMode = mode;
    notifyListeners();
    await themeRepository.setThemeMode(mode: darkMode);
  }

  @override
  Future<void> toggleTheme() async {
    darkMode = !darkMode;
    await setTheme(mode: darkMode);
  }

  //* System Theme

  @override
  Future<void> setUseSystemTheme({required bool systemTheme}) async {
    useSystemTheme = systemTheme;
    notifyListeners();
    await themeRepository.setUseSystemTheme(useSystemTheme: systemTheme);
  }

  @override
  Future<void> toggleUseSystemTheme() async {
    useSystemTheme = !useSystemTheme;
    await setUseSystemTheme(systemTheme: useSystemTheme);
  }
}
