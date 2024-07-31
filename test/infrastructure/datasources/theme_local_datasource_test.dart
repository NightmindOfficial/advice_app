import 'package:advice_app/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advice_app/infrastructure/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_local_datasource_test.mocks.dart';

const cachedThemeMode = "cached-theme-mode";

@GenerateMocks([SharedPreferences])
void main() {
  late ThemeLocalDatasource themeLocalDatasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    themeLocalDatasource = ThemeLocalDatasourceImpl(sp: mockSharedPreferences);
  });

  group("getCachedThemeData", () {
    const tThemeData = true;
    test("Should return bool (themeData) if there is one in sharedPreferences",
        () async {
      // Arrange
      when(mockSharedPreferences.getBool(any)).thenReturn(tThemeData);

      // Act
      final result = await themeLocalDatasource.getCachedThemeData();

      // Assert
      verify(mockSharedPreferences.getBool(cachedThemeMode));
      expect(result, tThemeData);
    });
    test(
        "Should return a CacheException if there is no themeData stored in sharedPreferences",
        () {
      // Arrange
      when(mockSharedPreferences.getBool(any)).thenReturn(null);

      // Act
      final call = themeLocalDatasource.getCachedThemeData;

      // Assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("cacheThemeData", () {
    const tThemeData = true;

    test("Should call sharedPreferences to cache themeMode", () {
      // Arrange
      when(mockSharedPreferences.setBool(any, any))
          .thenAnswer((_) async => true);

      // Act
      themeLocalDatasource.cacheThemeData(mode: tThemeData);

      // Assert
      verify(mockSharedPreferences.setBool(cachedThemeMode, tThemeData));
    });
  });
}
