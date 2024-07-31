import 'package:advice_app/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ThemeRepository {
  Future<Either<Failure, bool>> getThemeMode();
  Future<void> setThemeMode({required bool mode});

  Future<Either<Failure, bool>> getUseSystemTheme();
  Future<void> setUseSystemTheme({required bool useSystemTheme});
}
