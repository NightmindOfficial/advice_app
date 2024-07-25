import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/domain/failures/failures.dart';
import 'package:advice_app/domain/usecases/advicer_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdvicerUsecases usecases = AdvicerUsecases();

  AdvicerBloc() : super(AdvicerInitialState()) {
    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdvicerLoadingState());
      final Either<Failure, AdviceEntity> adviceOrFailure =
          await usecases.getFakeAdvice();

      emit(
        adviceOrFailure.fold(
          (failure) => (AdvicerErrorState(
            message: _mapFailureToMessage(failure),
          )),
          (advice) => AdvicerLoadedState(advice: advice.advice),
        ),
      );
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case const (ServerFailure):
      return "Whoops, a Server / API error occurred. Please try again.";
    case const (GeneralFailure):
    default:
      return "Whoops, something has gone wrong. Please try again.";
  }
}
