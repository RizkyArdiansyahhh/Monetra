import 'package:equatable/equatable.dart';
import 'package:monetra/models/host.dart';

abstract class HostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HostInitial extends HostState {}

class HostLoading extends HostState {}

class HostLoaded extends HostState {
  final List<Host> hosts;

  HostLoaded(this.hosts);

  @override
  List<Object?> get props => [hosts];
}

class HostError extends HostState {
  final String message;

  HostError(this.message);

  @override
  List<Object?> get props => [message];
}

class HostAdded extends HostState {}

class HostDelected extends HostState {}
