part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerState {}

final class AdvicerInitialState extends AdvicerState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

final class AdvicerLoadingState extends AdvicerState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

final class AdvicerLoadedState extends AdvicerState with EquatableMixin {
  AdvicerLoadedState({required this.advice});
  final String advice;

  @override
  List<Object?> get props => [advice];
}

final class AdvicerErrorState extends AdvicerState with EquatableMixin {
  AdvicerErrorState({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
