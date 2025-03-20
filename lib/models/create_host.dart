List<Map<String, String>> groups = [
  {"id": "27", "name": "PH"},
  {"id": "28", "name": "Server10"},
];
List<Map<String, String>> templates = [
  {"id": "10564", "name": "ICMP PING"},
];

String? validateHostName(String hostName) {
  if (hostName.isEmpty) {
    return "Host name cannot be empty";
  } else {
    return null;
  }
}

String? validateIpAddress(String ipAddress) {
  final RegExp ipRegex = RegExp(
    r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
  );

  if (ipAddress.isEmpty) {
    return "IP address cannot be empty";
  } else if (!ipRegex.hasMatch(ipAddress)) {
    return "Invalid IP address format";
  } else {
    return null;
  }
}

String? validatePort(String port) {
  if (port.isEmpty) {
    return "Port cannot be empty";
  } else if (!port.contains(RegExp(r'^[0-9]+$'))) {
    return "Port must be a number";
  } else if (int.parse(port) < 0 || int.parse(port) > 65535) {
    return "Port must be between 0 and 65535";
  } else {
    return null;
  }
}
