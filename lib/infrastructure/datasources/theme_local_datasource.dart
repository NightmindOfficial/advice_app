import 'package:advice_app/infrastructure/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedThemeMode = "cached-theme-mode";
const cachedUseSystemTheme = "cached-use-system-theme";

abstract class ThemeLocalDatasource {
  Future<bool> getCachedThemeData();
  Future<void> cacheThemeData({required bool mode});

  Future<bool> getUseSystemTheme();
  Future<bool> cacheUseSystemTheme({required bool useSystemTheme});
}

class ThemeLocalDatasourceImpl implements ThemeLocalDatasource {
  final SharedPreferences sp;

  ThemeLocalDatasourceImpl({required this.sp});

  @override
  Future<void> cacheThemeData({required bool mode}) {
    return sp.setBool(cachedThemeMode, mode);
  }

  @override
  Future<bool> getCachedThemeData() {
    final modeBool = sp.getBool(cachedThemeMode);

    if (modeBool != null) {
      return Future.value(modeBool);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cacheUseSystemTheme({required bool useSystemTheme}) {
    return sp.setBool(cachedUseSystemTheme, useSystemTheme);
  }

  @override
  Future<bool> getUseSystemTheme() {
    final useSystemTheme = sp.getBool(cachedUseSystemTheme);

    if (useSystemTheme != null) {
      return Future.value(useSystemTheme);
    } else {
      throw CacheException();
    }
  }
}
