part of 'greeting_bloc.dart';

@immutable
sealed class GreetingEvent {}

class UpdateGreeting extends GreetingEvent {}
