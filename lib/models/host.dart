class Host {
  final String hostId;
  final String host;
  final String ip;
  final String icmpPing;

  Host({
    required this.hostId,
    required this.host,
    required this.ip,
    required this.icmpPing,
  });

  factory Host.fromJson(Map<String, dynamic> json) {
    String extractedIp = 'Unknown';
    if (json['interfaces'] is List && json['interfaces'].isNotEmpty) {
      var firstInterface = json['interfaces'][0];
      if (firstInterface is Map<String, dynamic> &&
          firstInterface.containsKey('ip')) {
        extractedIp = firstInterface['ip'] ?? 'Unknown';
      }
    }

    String extractedIcmpPing = '0';
    if (json['items'] is List) {
      var icmpItem = json['items'].firstWhere(
        (item) => item is Map<String, dynamic> && item['key_'] == 'icmpping',
        orElse: () => <String, dynamic>{},
      );
      if (icmpItem.isNotEmpty) {
        extractedIcmpPing = icmpItem['lastvalue'] ?? '0';
      }
    }

    return Host(
      hostId: json['hostid'] ?? 'Unknown',
      host: json['host'] ?? 'Unknown',
      ip: extractedIp,
      icmpPing: extractedIcmpPing,
    );
  }
}
