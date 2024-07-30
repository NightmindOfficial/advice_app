import 'package:advice_app/application/advicer/advicer_bloc.dart';
import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/domain/failures/failures.dart';
import 'package:advice_app/domain/usecases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_bloc_test.mocks.dart';

@GenerateMocks([AdvicerUsecases])
void main() {
  late MockAdvicerUsecases mockAdvicerUsecases;
  late AdvicerBloc advicerBloc;

  setUp(() {
    mockAdvicerUsecases = MockAdvicerUsecases();
    advicerBloc = AdvicerBloc(usecases: mockAdvicerUsecases);
  });

  test("initState should be AdvicerInitialState", () {
    // Assert
    expect(advicerBloc.state, equals(AdvicerInitialState()));
  });

  group("AdviceRequestedEvent", () {
    final tAdvice = AdviceEntity(advice: "Der Lachs löppt.", adviceID: 69);
    final tAdviceString = tAdvice.advice;

    test("Should call Usecase if event is added", () async {
      // Arrange
      when(mockAdvicerUsecases.getAdvice())
          .thenAnswer((_) async => Right(tAdvice));
      // Act
      advicerBloc.add(AdviceRequestedEvent());
      await untilCalled(mockAdvicerUsecases.getAdvice());
      // Assert
      verify(mockAdvicerUsecases.getAdvice());
      verifyNoMoreInteractions(mockAdvicerUsecases);
    });

    test("Should emit loading then the loaded state after event is added",
        () async {
      // Arrange
      when(mockAdvicerUsecases.getAdvice())
          .thenAnswer((_) async => Right(tAdvice));
      // Assert
      final expectedStates = [
        AdvicerLoadingState(),
        AdvicerLoadedState(advice: tAdviceString)
      ];
      expectLater(advicerBloc.stream, emitsInOrder(expectedStates));

      // Act
      advicerBloc.add(AdviceRequestedEvent());
    });

    test(
        "Should emit loading then the error state after event is added --> usecase fails --> Server Failure",
        () async {
      // Arrange
      when(mockAdvicerUsecases.getAdvice())
          .thenAnswer((_) async => Left(ServerFailure()));
      // Assert
      final expectedStates = [
        AdvicerLoadingState(),
        AdvicerErrorState(message: serverFailureMsg)
      ];
      expectLater(advicerBloc.stream, emitsInOrder(expectedStates));

      // Act
      advicerBloc.add(AdviceRequestedEvent());
    });

    test(
        "Should emit loading then the error state after event is added --> usecase fails --> General Failure",
        () async {
      // Arrange
      when(mockAdvicerUsecases.getAdvice())
          .thenAnswer((_) async => Left(GeneralFailure()));
      // Assert
      final expectedStates = [
        AdvicerLoadingState(),
        AdvicerErrorState(message: generalFailureMsg)
      ];
      expectLater(advicerBloc.stream, emitsInOrder(expectedStates));

      // Act
      advicerBloc.add(AdviceRequestedEvent());
    });
  });
}
