part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerState {}

final class AdvicerInitial extends AdvicerState {}

final class AdvicerLoading extends AdvicerState {}

final class AdvicerLoaded extends AdvicerState {
  AdvicerLoaded({required this.advice});
  final String advice;
}

final class AdvicerError extends AdvicerState {}
