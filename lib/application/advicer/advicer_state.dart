part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerState {}

final class AdvicerInitialState extends AdvicerState {}

final class AdvicerLoadingState extends AdvicerState {}

final class AdvicerLoadedState extends AdvicerState {
  AdvicerLoadedState({required this.advice});
  final String advice;
}

final class AdvicerErrorState extends AdvicerState {
  AdvicerErrorState({required this.message});
  final String message;
}
