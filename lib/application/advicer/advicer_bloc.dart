import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitial()) {
    ///Fake Network Request
    Future sleep1() {
      return Future.delayed(const Duration(seconds: 2), () => "1");
    }

    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdvicerLoading());
      await sleep1();
      emit(AdvicerLoaded(advice: "Testing..."));
    });
  }
}
