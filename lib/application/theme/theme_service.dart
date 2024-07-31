import 'package:advice_app/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

abstract class ThemeService extends ChangeNotifier {
  late bool darkMode;

  Future<void> toggleTheme();
  Future<void> setTheme({required bool mode});
  Future<void> init();
}

class ThemeServiceImpl extends ChangeNotifier implements ThemeService {
  final ThemeRepository themeRepository;

  ThemeServiceImpl({required this.themeRepository});

  @override
  bool darkMode = true;

  @override
  Future<void> init() async {
    final modeOrFailure = await themeRepository.getThemeMode();
    modeOrFailure.fold((failure) {
      setTheme(mode: darkMode);
    }, (mode) {
      setTheme(mode: mode);
    });
  }

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
}
