part of 'alert_bloc.dart';

sealed class AlertState extends Equatable {
  const AlertState();

  @override
  List<Object> get props => [];
}

final class AlertInitial extends AlertState {}

class AlertLoaded extends AlertState {
  final List<Map<String, dynamic>> alerts;

  const AlertLoaded(this.alerts);

  @override
  List<Object> get props => [alerts];
}

class AlertLoading extends AlertState {}

class AlertError extends AlertState {
  final String message;

  const AlertError(this.message);
}
