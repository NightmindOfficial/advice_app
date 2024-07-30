import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/domain/failures/failures.dart';
import 'package:advice_app/domain/repositories/advicer_repository.dart';
import 'package:advice_app/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:advice_app/infrastructure/exceptions/exceptions.dart';
import 'package:advice_app/infrastructure/models/advice_model.dart';
import 'package:advice_app/infrastructure/repositories/advicer_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_repository_test.mocks.dart';

@GenerateMocks([AdvicerRemoteDatasource])
void main() {
  late AdvicerRepository advicerRepository;
  late MockAdvicerRemoteDatasource mockAdvicerRemoteDatasource;

  setUp(() {
    mockAdvicerRemoteDatasource = MockAdvicerRemoteDatasource();
    advicerRepository = AdvicerRepositoryImpl(
        advicerRemoteDatasource: mockAdvicerRemoteDatasource);
  });

  group("getAdviceFromAPI", () {
    final tAdviceModel =
        AdviceModel(advice: "Das Runde muss ins Eckige", adviceID: 69);
    final AdviceEntity tAdvice = tAdviceModel;

    test(
        "Should return remote data if the call to remote datasource is successful",
        () async {
      // Arrange
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromAPI())
          .thenAnswer((_) async => tAdvice);
      // Act
      final result = await advicerRepository.getAdviceFromAPI();
      // Assert
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromAPI());
      expect(result, Right(tAdviceModel));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });

    test("Should return ServerFailure if datasource throws server exception",
        () async {
      // Arrange
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromAPI())
          .thenThrow(ServerException());
      // Act
      final result = await advicerRepository.getAdviceFromAPI();
      // Assert
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromAPI());
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });

    test(
        "Should return GeneralFailure if datasource throws any other exception",
        () async {
      // Arrange
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromAPI())
          .thenThrow(Exception());
      // Act
      final result = await advicerRepository.getAdviceFromAPI();
      // Assert
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromAPI());
      expect(result, Left(GeneralFailure()));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });
  });
}
