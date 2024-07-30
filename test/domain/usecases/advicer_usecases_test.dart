import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/domain/failures/failures.dart';
import 'package:advice_app/domain/repositories/advicer_repository.dart';
import 'package:advice_app/domain/usecases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_usecases_test.mocks.dart';

@GenerateMocks([AdvicerRepository])
void main() {
  late AdvicerUsecases advicerUsecases;
  late MockAdvicerRepository mockAdvicerRepository;

  setUp(() {
    mockAdvicerRepository = MockAdvicerRepository();
    advicerUsecases = AdvicerUsecases(advicerRepository: mockAdvicerRepository);
  });

  group("getAdvice", () {
    final tAdvice = AdviceEntity(advice: "Test Advice", adviceID: 420);

    test("Should return the same advice as repo", () async {
      // Arrange - Set up environment to run test
      when(mockAdvicerRepository.getAdviceFromAPI())
          .thenAnswer((_) async => Right(tAdvice));

      // Act - Execute Test
      final result = await advicerUsecases.getAdvice();

      // Assert - Check Results
      expect(result, Right(tAdvice));
      verify(mockAdvicerRepository.getAdviceFromAPI());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });

    test("Should return the same failure as repo", () async {
      // Arrange - Set up environment to run test
      when(mockAdvicerRepository.getAdviceFromAPI())
          .thenAnswer((_) async => Left(ServerFailure()));

      // Act - Execute Test
      final result = await advicerUsecases.getAdvice();

      // Assert - Check Results
      expect(result, Left(ServerFailure()));
      verify(mockAdvicerRepository.getAdviceFromAPI());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });
  });
}
