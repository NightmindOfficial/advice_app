part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerEvent {}

/// Event triggered when the "Get Advice" button is pressed.
class AdviceRequestedEvent extends AdvicerEvent {}
