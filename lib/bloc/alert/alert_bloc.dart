import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'alert_event.dart';
part 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final Dio _dio = Dio();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String zabbixUrl = "http://192.168.180.60/zabbix/api_jsonrpc.php";
  final String authToken =
      "a6c41095c2aa33deac930f55d42503c20c307c5c1d0728959ac46c2aaf83e8e0";

  Timer? _timer;
  List<Map<String, dynamic>> _lastFetchedAlerts = []; // Cache data sebelumnya

  AlertBloc() : super(AlertInitial()) {
    on<FetchAlerts>(_onFetchAlerts);

    // Polling setiap 5 detik
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      add(FetchAlerts());
    });
  }

  Future<void> _onFetchAlerts(
      FetchAlerts event, Emitter<AlertState> emit) async {
    try {
      final response = await _dio.post(
        zabbixUrl,
        data: {
          "jsonrpc": "2.0",
          "method": "host.get",
          "params": {
            "output": ["hostid", "host"],
            "selectItems": ["itemid", "name", "key_", "lastvalue"]
          },
          "auth": authToken,
          "id": 1
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.data != null && response.data["result"] != null) {
        List<dynamic> hosts = response.data["result"];

        // Filter host yang tidak diinginkan
        hosts.removeWhere(
            (host) => host["hostid"] == "10084" || host["hostid"] == "10656");

        // Filter hanya ICMP Ping
        List<Map<String, dynamic>> fetchedAlerts = hosts.map((host) {
          var icmpItem = (host["items"] as List?)?.firstWhere(
            (item) => item["key_"] == "icmpping",
            orElse: () => {},
          );

          return {
            "hostid": host["hostid"],
            "host": host["host"],
            "icmp_ping":
                icmpItem != null ? icmpItem["lastvalue"] ?? "N/A" : "N/A",
          };
        }).toList();

        // Cek apakah ada perubahan data
        if (_lastFetchedAlerts.toString() != fetchedAlerts.toString()) {
          // Simpan ke Firestore jika ada perubahan
          for (var alert in fetchedAlerts) {
            await _firestore
                .collection("alerts")
                .doc(alert["hostid"])
                .set(alert, SetOptions(merge: true));
          }

          _lastFetchedAlerts = fetchedAlerts; // Perbarui cache
          emit(AlertLoaded(fetchedAlerts)); // Emit hanya jika ada perubahan
        }
      }
    } catch (e) {
      emit(AlertError("Gagal mengambil data: ${e.toString()}"));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Hentikan polling saat BLoC dihancurkan
    return super.close();
  }
}
