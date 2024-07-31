import 'package:advice_app/infrastructure/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedThemeMode = "cached-theme-mode";

abstract class ThemeLocalDatasource {
  Future<bool> getCachedThemeData();
  Future<void> cacheThemeData({required bool mode});
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
}
