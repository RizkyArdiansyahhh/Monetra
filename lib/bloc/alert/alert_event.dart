part of 'alert_bloc.dart';

sealed class AlertEvent extends Equatable {
  const AlertEvent();

  @override
  List<Object> get props => [];
}

class FetchAlerts extends AlertEvent {}
