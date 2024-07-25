import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/domain/usecases/advicer_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdvicerUsecases usecases = AdvicerUsecases();

  AdvicerBloc() : super(AdvicerInitial()) {
    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdvicerLoading());
      AdviceEntity adviceEntity = await usecases.getFakeAdvice();
      emit(AdvicerLoaded(advice: adviceEntity.advice));
    });
  }
}
