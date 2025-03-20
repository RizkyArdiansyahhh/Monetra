import 'package:equatable/equatable.dart';

abstract class HostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHosts extends HostEvent {}

class DeleteHost extends HostEvent {
  final String hostId;

  DeleteHost({required this.hostId});
}

class CreateHost extends HostEvent {
  final String hostName;
  final String ipAddress;
  final String port;
  final String groupId;
  final String templateId;
  final String connectionType;

  CreateHost({
    required this.hostName,
    required this.ipAddress,
    required this.port,
    required this.groupId,
    required this.templateId,
    required this.connectionType,
  });

  @override
  List<Object?> get props => [
        hostName,
        ipAddress,
        port,
        connectionType,
        groupId,
        templateId,
      ];
}
