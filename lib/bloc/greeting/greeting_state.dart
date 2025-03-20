part of 'greeting_bloc.dart';

@immutable
class GreetingState {
  final String? greeting;

  const GreetingState({this.greeting});
}

final class GreetingInitial extends GreetingState {
  const GreetingInitial() : super(greeting: "");
}
