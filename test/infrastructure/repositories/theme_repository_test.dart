import 'package:advice_app/domain/failures/failures.dart';
import 'package:advice_app/domain/repositories/theme_repository.dart';
import 'package:advice_app/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advice_app/infrastructure/exceptions/exceptions.dart';
import 'package:advice_app/infrastructure/repositories/theme_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_repository_test.mocks.dart';

@GenerateMocks([ThemeLocalDatasource])
void main() {
  late MockThemeLocalDatasource mockThemeLocalDatasource;
  late ThemeRepository themeRepository;

  setUp(() {
    mockThemeLocalDatasource = MockThemeLocalDatasource();
    themeRepository =
        ThemeRepositoryImpl(themeLocalDatasource: mockThemeLocalDatasource);
  });

  group("setThemeMode", () {
    const tThemeMode = true;

    test("Should call function to cache themeMode in local datasource", () {
      // Arrange
      when(mockThemeLocalDatasource.cacheThemeData(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);
      // Act
      themeRepository.setThemeMode(mode: tThemeMode);

      // Assert
      verify(mockThemeLocalDatasource.cacheThemeData(mode: tThemeMode));
    });
  });
  group("getThemeMode", () {
    const tThemeMode = true;

    test("Should return themeMode if cached data is available", () async {
      // Arrange
      when(mockThemeLocalDatasource.getCachedThemeData())
          .thenAnswer((_) async => tThemeMode);

      // Act
      final result = await themeRepository.getThemeMode();

      // Assert
      expect(result, const Right(tThemeMode));
      verify(mockThemeLocalDatasource.getCachedThemeData());
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });
    test("Should return CacheFailure if cached data is not available",
        () async {
      // Arrange
      when(mockThemeLocalDatasource.getCachedThemeData())
          .thenThrow(CacheException());

      // Act
      final result = await themeRepository.getThemeMode();

      // Assert
      expect(result, Left(CacheFailure()));
      verify(mockThemeLocalDatasource.getCachedThemeData());
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });
  });

  group("setUseSystemTheme", () {
    const tThemeMode = true;

    test("Should call function to cache useSystemtheme in local datasource",
        () {
      // Arrange
      when(mockThemeLocalDatasource.cacheUseSystemTheme(
              useSystemTheme: anyNamed("useSystemTheme")))
          .thenAnswer((_) async => true);
      // Act
      themeRepository.setUseSystemTheme(useSystemTheme: tThemeMode);

      // Assert
      verify(mockThemeLocalDatasource.cacheUseSystemTheme(
          useSystemTheme: tThemeMode));
    });
  });
  group("getUseSystemTheme", () {
    const tThemeMode = true;

    test("Should return systemThemeMode if cached data is available", () async {
      // Arrange
      when(mockThemeLocalDatasource.getUseSystemTheme())
          .thenAnswer((_) async => tThemeMode);

      // Act
      final result = await themeRepository.getUseSystemTheme();

      // Assert
      expect(result, const Right(tThemeMode));
      verify(mockThemeLocalDatasource.getUseSystemTheme());
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });
    test("Should return CacheFailure if cached data is not available",
        () async {
      // Arrange
      when(mockThemeLocalDatasource.getUseSystemTheme())
          .thenThrow(CacheException());

      // Act
      final result = await themeRepository.getUseSystemTheme();

      // Assert
      expect(result, Left(CacheFailure()));
      verify(mockThemeLocalDatasource.getUseSystemTheme());
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });
  });
}
