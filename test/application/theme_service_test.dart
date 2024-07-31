import 'package:advice_app/application/theme/theme_service.dart';
import 'package:advice_app/domain/failures/failures.dart';
import 'package:advice_app/domain/repositories/theme_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_service_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  late MockThemeRepository mockThemeRepository;
  late ThemeService themeService;

  late int listenerCount;

  setUp(() {
    listenerCount = 0;
    mockThemeRepository = MockThemeRepository();
    themeService = ThemeServiceImpl(themeRepository: mockThemeRepository)
      ..addListener(() {
        listenerCount += 1;
      });
  });

  test("Check if default value is set to dark mode", () {
    // Assert
    expect(themeService.darkMode, true);
  });

  group("setTheme", () {
    const tMode = false;

    test(
        "Should set the theme to the parameter given in arguments and store this information",
        () {
      // Arrange
      themeService.darkMode = true;
      when(mockThemeRepository.setThemeMode(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);

      // Act
      themeService.setTheme(mode: tMode);

      // Assert
      expect(themeService.darkMode, tMode);
      verify(mockThemeRepository.setThemeMode(mode: tMode));
      expect(listenerCount, 1);
    });
  });

  group("toggleTheme", () {
    const tMode = false;

    test("Should toggle current themeMode and store this information", () {
      // Arrange
      themeService.darkMode = true;
      when(mockThemeRepository.setThemeMode(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);

      // Act
      themeService.toggleTheme();

      // Assert
      expect(themeService.darkMode, tMode);
      verify(mockThemeRepository.setThemeMode(mode: tMode));
      expect(listenerCount, 1);
    });
  });

  group("init", () {
    const tMode = false;

    test(
        "Should get a theme mode from local data source, use it and notify listeners",
        () async {
      // Arrange
      themeService.darkMode = true;
      when(mockThemeRepository.getThemeMode())
          .thenAnswer((_) async => const Right(tMode));

      // Act
      await themeService.init();

      // Assert
      expect(themeService.darkMode, tMode);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);
    });

    test(
        "Should use initial fallback theme (dark) if no theme from local source (shared prefs) is returned, and notify listeners",
        () async {
      // Arrange
      themeService.darkMode = true;
      when(mockThemeRepository.getThemeMode())
          .thenAnswer((_) async => Left(CacheFailure()));

      // Act
      await themeService.init();

      // Assert
      expect(themeService.darkMode, true);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);
    });
  });
}
